package com.KoreaIT.syp.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.syp.demo.service.ArticleService;
import com.KoreaIT.syp.demo.service.BoardService;
import com.KoreaIT.syp.demo.service.MemberService;
import com.KoreaIT.syp.demo.util.Ut;
import com.KoreaIT.syp.demo.vo.Article;
import com.KoreaIT.syp.demo.vo.Board;
import com.KoreaIT.syp.demo.vo.Member;
import com.KoreaIT.syp.demo.vo.Rq;

@Controller
public class AdmMemberController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;
	
	// 회원과 게시글 목록
	@RequestMapping("/adm/memberAndArticle/list")
	public String showList(Model model, @RequestParam(defaultValue="0") String authLevel, 
			@RequestParam(defaultValue="0") int boardId,
			@RequestParam(defaultValue = "loginId,name,nickname") String searchTypeM,
			@RequestParam(defaultValue = "title,body") String searchTypeA,
			@RequestParam(defaultValue = "") String searchKeywordM,
			@RequestParam(defaultValue = "") String searchKeywordA,
			@RequestParam(defaultValue="1") int page) {
		
		Board board = boardService.getBoardById(boardId);
		
		int membersCount = memberService.getMembersCount(authLevel, searchTypeM, searchKeywordM);
		int articlesCount = articleService.getArticlesCount(boardId, searchTypeA, searchKeywordA);
		
		// 페이징
		int itemsInAPage = 10;		// 한 페이지에 나오는 글 개수
		// 글 20개 -> 2
		// 글 24개 -> 3

		int mPagesCount = (int) Math.ceil((double) membersCount / itemsInAPage);
		int aPagesCount = (int) Math.ceil((double) articlesCount / itemsInAPage);

		List<Member> members = memberService.getForPrintMembers(authLevel, itemsInAPage, page, searchTypeM, searchKeywordM);
		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchTypeA, searchKeywordA);
		
		model.addAttribute("authLevel", authLevel);
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("searchTypeM", searchTypeM);
		model.addAttribute("searchTypeA", searchTypeA);
		model.addAttribute("searchKeywordM", searchKeywordM);
		model.addAttribute("searchKeywordA", searchKeywordA);
		
		model.addAttribute("page", page);
		model.addAttribute("mPagesCount", mPagesCount);
		model.addAttribute("aPagesCount", aPagesCount);
		model.addAttribute("membersCount", membersCount);
		model.addAttribute("articlesCount", articlesCount);
		
		model.addAttribute("members", members);
		model.addAttribute("articles", articles);
		
		return "adm/memberAndArticle/list";
	}
	
	// 로그아웃
	@RequestMapping("/adm/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		
		rq.logout();
		
		return Ut.jsReplace(Ut.f("로그아웃 되었습니다."), afterLogoutUri);
	}
}