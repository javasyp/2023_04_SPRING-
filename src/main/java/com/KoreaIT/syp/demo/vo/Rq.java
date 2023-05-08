package com.KoreaIT.syp.demo.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.KoreaIT.syp.demo.service.MemberService;
import com.KoreaIT.syp.demo.util.Ut;

import lombok.Getter;

// 세션 정보를 확인하는 객체
@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	
	private Map<String, String> paramMap;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	
	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		
		paramMap = Ut.getParamMap(req);
		
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;
		
		// 로그인되어 있을 때
		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}
		
		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		
		this.req.setAttribute("rq", this);
	}
	
	public void printHistoryBackJs(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsHistoryBack("F-B", msg));
	}
	
	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) {
		print(str + "\n");
	}
	
	// 로그인 시
	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}
	
	// 로그아웃 시
	public void logout() {
		session.removeAttribute("loginedMemberId");
	}
	
	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}

	public String jsHistoryBack(String resultCode, String msg) {
		return Ut.jsHistoryBack(resultCode, msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}
	
	// 현재 URI 가져오기
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();
		
		System.out.println(currentUri);
		System.out.println(queryString);
		
		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		System.out.println(currentUri);
		return currentUri;
	}

	// Rq 객체 생성 유도
	// 삭제 x, BeforeActionInterceptor 에서 강제 호출
	public void initOnBeforeActionInterceptor() {

	}
	
	public boolean isNotLogined() {
		return !isLogined;
	}
	
	public void run() {
		System.out.println("===========================run A");
	}
	
	public void printReplace(String msg, String replaceUri) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, replaceUri));
	}
	
	// 회원가입 후 원래 있었던 페이지로 이동
	public String getJoinUri() {
		return "../member/join?afterLoginUri=" + getAfterLoginUri();
	}
	
	// 로그인 후 원래 가려고 했던 페이지로 이동
	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}
	
	// 로그아웃 후 기존에 보고 있었던 페이지로 이동
	public String getLogoutUri() {
		String requestUri = req.getRequestURI();

		switch (requestUri) {
		case "/usr/article/write":
			return "../member/doLogout?afterLogoutUri=" + "/";
		}

		return "../member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}
	
	private String getAfterLogoutUri() {
		// 로그아웃 후 접근 불가 페이지

		return getEncodedCurrentUri();
	}

	private String getAfterLoginUri() {
		// 로그인 후 접근 불가 페이지

		String requestUri = req.getRequestURI();

		switch (requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
			return Ut.getEncodedUri(Ut.getAttr(paramMap, "afterLoginUri", ""));
		}

		return getEncodedCurrentUri();
	}
	
	public String getEncodedCurrentUri() {
		return Ut.getEncodedCurrentUri(getCurrentUri());
	}
	
	public String getArticleDetailUriFromArticleList(Article article) {
		return "../article/detail?id=" + article.getId() + "&listUri=" + getEncodedCurrentUri();
	}
}
