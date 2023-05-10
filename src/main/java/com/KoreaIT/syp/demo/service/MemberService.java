package com.KoreaIT.syp.demo.service;

import org.springframework.stereotype.Service;

import com.KoreaIT.syp.demo.repository.MemberRepository;
import com.KoreaIT.syp.demo.util.Ut;
import com.KoreaIT.syp.demo.vo.Member;
import com.KoreaIT.syp.demo.vo.ResultData;

@Service
public class MemberService {
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
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
	private Member getMemberByNameAndEmail(String name, String email) {
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

}
