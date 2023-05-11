package com.KoreaIT.syp.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.KoreaIT.syp.demo.repository.MemberRepository;
import com.KoreaIT.syp.demo.util.Ut;
import com.KoreaIT.syp.demo.vo.Member;
import com.KoreaIT.syp.demo.vo.ResultData;

@Service
public class MemberService {
	
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	
	private MemberRepository memberRepository;
	private MailService mailService;

	public MemberService(MailService mailService, MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
		this.mailService = mailService;
	}

	// 서비스 메서드
	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {		// 제네릭 추가

		// 아이디 중복 체크
		Member existsMember = getMemberByLoginId(loginId);
		
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용 중인 아이디(%s)입니다.", loginId));
		}

		// 이름 + 이메일 중복 체크
		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용 중인 이름(%s)과 이메일(%s)입니다.", name, email));
		}
		
		// 저장 시 비밀번호 암호화하여 저장
		loginPw = Ut.SHA256(loginPw);

		// DB 회원 저장
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		// 몇 번째 회원인지
		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);
	}

	// 이름 + 이메일 중복 체크
	// 아이디 찾기
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	// 아이디 중복 체크
	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	
	// 회원 정보 수정
	public ResultData modify(int id, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		memberRepository.modify(id, loginPw, name, nickname, cellphoneNum, email);
		
		return ResultData.from("S-1", "회원 정보 수정이 완료되었습니다.");
	}
	
	// 비밀번호 찾기 (이메일 전송) 임시 패스워드 발송과 동시에 DB에 있는 비밀번호를 임시 비밀번호로 변경
	public ResultData notifyTempLoginPwByEmail(Member actor) {
		// 메일 제목과 내용
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);	// 랜덤 6글자
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";
		
		// 메일 전송
		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}
		
		// 기존 비밀번호를 임시 비밀번호로 변경
		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일 주소로 임시 패스워드가 발송되었습니다.");
	}
	
	// 임시 비밀번호로 변경
	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.modify(actor.getId(), Ut.SHA256(tempPassword), null, null, null, null);
	}
}
