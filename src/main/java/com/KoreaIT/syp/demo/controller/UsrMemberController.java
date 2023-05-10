package com.KoreaIT.syp.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.syp.demo.service.MemberService;
import com.KoreaIT.syp.demo.util.Ut;
import com.KoreaIT.syp.demo.vo.Member;
import com.KoreaIT.syp.demo.vo.ResultData;
import com.KoreaIT.syp.demo.vo.Rq;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;
	
	// 액션 메서드
	// 로그인
	@RequestMapping("/usr/member/login")
	public String showLogin(HttpSession session) {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-5", Ut.f("이미 로그인 상태입니다."));
		}
		
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해 주세요.");
		}
		
		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해 주세요.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s은(는) 존재하지 않는 아이디입니다.", loginId));
		}
		
		System.out.println(Ut.SHA256(loginPw));
		
		if (member.getLoginPw().equals(Ut.SHA256(loginPw)) == false) {
			return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다.");
		}
		
		rq.login(member);
		
		// 우리가 갈 수 있는 경로를 경우의 수로 표현
		// 인코딩
		// 그 외에는 처리 불가 -> 메인으로 보내기
//		if (afterLoginUri.equals("null")) {
//			afterLoginUri = "/";
//		}
		
		return Ut.jsReplace(Ut.f("%s 님 환영합니다.", member.getName()), afterLoginUri);
	}
	
	// 로그아웃
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		
		rq.logout();
		
		return Ut.jsReplace(Ut.f("로그아웃 되었습니다."), afterLogoutUri);
	}
	
	// 회원가입
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname,
			String cellphoneNum, String email, @RequestParam(defaultValue = "/") String afterLoginUri) {

		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		// 중복일 때
		if (joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		// joinRd에 저장된 data1(id) 값
		Member member = memberService.getMemberById(joinRd.getData1());

		String afterJoinUri = "../member/login?afterLoginUri=" + Ut.getEncodedUri(afterLoginUri);

		return Ut.jsReplace(Ut.f("회원가입이 완료되었습니다."), afterJoinUri);
	}
	
	// 아이디 중복 체크
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String loginId) {
		
		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해 주세요.");
		}
		
		Member existsMember = memberService.getMemberByLoginId(loginId);
		
		if (existsMember != null) {
			return ResultData.from("F-2", "해당 아이디는 이미 사용 중입니다.", "loginId", loginId);
		}
		
		return ResultData.from("S-1", "사용 가능한 아이디입니다.", "loginId", loginId);
	}
	
	// 마이페이지
	@RequestMapping("/usr/member/myPage")
	public String showMyPage() {
		
		return "usr/member/myPage";
	}
	
	// 회원 정보 수정 시 비밀번호 한번 더 체크
	@RequestMapping("/usr/member/checkPw")
	public String showCheckPw() {
		
		return "usr/member/checkPw";
	}
	
	@RequestMapping("/usr/member/doCheckPw")
	@ResponseBody
	public String doCheckPw(String loginPw, String replaceUri) {
		
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBackOnView("비밀번호를 입력하세요.");
		}
		
		if (rq.getLoginedMember().getLoginPw().equals(Ut.SHA256(loginPw)) == false) {
			return rq.jsHistoryBack("F-1", "비밀번호가 일치하지 않습니다.");
		}
		
		return rq.jsReplace("", replaceUri);
	}
	
	// 회원정보 수정
	@RequestMapping("/usr/member/modify")
	public String showModify() {
		
		return "usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (Ut.empty(loginPw)) { // 비밀번호를 변경하지 않았을 경우
			loginPw = member.getLoginPw();
		} else {	// 변경했을 경우
			loginPw = Ut.SHA256(loginPw);
		}
		
		ResultData modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPw, name, nickname, cellphoneNum,
				email);

		return rq.jsReplace(modifyRd.getMsg(), "../member/myPage");
	}
	
	// 아이디 찾기
	@RequestMapping("/usr/member/findLoginId")
	public String showFindLoginId() {
		
		return "usr/member/findLoginId";
	}
	
	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String name, String email, @RequestParam(defaultValue = "/") String afterFindLoginIdUri) {
		
		Member member = memberService.getMemberByNameAndEmail(name, email);
		
		if (member == null) {
			return rq.jsHistoryBack("F-1", "해당하는 사용자가 없습니다.");
		}
		
		return Ut.jsReplace(Ut.f("당신의 아이디는 ( %s )입니다.", member.getLoginId()), afterFindLoginIdUri);
	}
}