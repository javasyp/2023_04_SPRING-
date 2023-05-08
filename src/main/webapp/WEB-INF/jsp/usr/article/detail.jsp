<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE DETAIL" />
<%@ include file="../common/head.jspf"%>
<hr />

<!-- 조회수 증가 ajax 통신으로 보여주기 -->
<!-- <iframe src="http://localhost:8081/usr/article/doIncreaseHitCountRd?id=2" frameborder="0"></iframe> -->
<script>
	const params = {}
	params.id = parseInt('${param.id}');
</script>

<script>
	// AJAX
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
         
	$(function() {
		setTimeout(ArticleDetail__increaseHitCount, 2000);
	})
</script>

<!-- 댓글 폼 체크 -->
<script type="text/javascript">
	let ReplyWrite__submitFormDone = false;
	
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		
		reply = form.body.value.trim();
		
		if (reply.length < 3) {
			alert('3글자 이상 입력하세요!');
			form.body.focus();
			return;
		}
		
		ReplyWrite__submitFormDone = true;
		
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table border="1">
				<colgroup>
					<col width="200" />
				</colgroup>
	
				<tbody>
					<tr>
						<td>번호</td>
						<td><div class="badge">${article.id }</div></td>
					</tr>
					<tr>
						<td>작성날짜</td>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<td>수정날짜</td>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<td>추천</td>
						<td>
							좋아요 <span class="badge">${article.goodReactionPoint }</span>
							싫어요 <span class="badge">${article.badReactionPoint }</span>
							<c:if test="${actorCanMakeReaction }">
								<div>
									<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
										class="btn btn-xs">LIKE 👍</a>
									<a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
										class="btn btn-xs">DISLIKE 👎</a>
								</div>
							</c:if>
							
							<!-- "좋아요" 취소 -->
							<c:if test="${actorCanCancelGoodReaction }">
								<div>
									<a href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
										class="btn btn-xs">LIKE 👍</a>
									<a onclick="alert(this.title); return false;" title="좋아요를 먼저 취소하세요."
										class="btn btn-xs">DISLIKE 👎</a>
								</div>
							</c:if>
							
							<!-- "싫어요" 취소 -->
							<c:if test="${actorCanCancelBadReaction }">
								<div>
									<a onclick="alert(this.title); return false;" title="싫어요를 먼저 취소하세요." 
										class="btn btn-xs">LIKE 👍</a>
									<a href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
										class="btn btn-xs">DISLIKE 👎</a>
								</div>
							</c:if>
							
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${article.extra_writer }</td>
					</tr>
					<tr>
						<td>조회수</td>
						<td>
							<span class="article-detail__hit-count">${article.hitCount }</span>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>${article.title }</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>${article.body }</td>
					</tr>
				</tbody>
	
			</table>
		</div>
		<div class="btns">
			<button class="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
			<c:if test="${article.actorCanModify }">
				<a class="btn-text-link btn btn-active btn-ghost" href="modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.actorCanDelete }">
				<a class="btn-text-link btn btn-active btn-ghost" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="doDelete?id=${article.id }">삭제</a>
			</c:if>
			
		</div>
	</div>
</section>

<!-- 댓글 -->
<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<c:if test="${rq.logined }">
				<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submitForm(this); return false;">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${article.id }" />
					<input type="hidden" name="replaceUri" value="${rq.currentUri }" />
					<table>
						<colgroup>
							<col width="300" />
							<col width="100" />
						</colgroup>

						<tbody>
							<tr>
								<td>
									<textarea class="input input-bordered w-full max-w-xs" name="body" placeholder="댓글을 입력해 주세요." /></textarea>
								</td>
								<td>
									<button type="submit">댓글 작성</button>
								</td>
							</tr>
						</tbody>

					</table>
				</form>
			</c:if>
			<c:if test="${rq.notLogined }">
				<a class="btn-text-link" href="${rq.loginUri }">로그인 후 이용하기</a>
			</c:if>
		</div>
	</div>
</section>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<h1 class="text-3xl">댓글 리스트 (${repliesCount })</h1>
		<table class="table table-zebra">
			<colgroup>
				<col width="70" />
				<col width="100" />
				<col width="100" />
				<col width="50" />
				<col width="150" />
				<col width="50" />
				<col width="50" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>날짜</th>
					<th>작성자</th>
					<th>추천</th>
					<th>내용</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="reply" items="${replies }">
					<tr class="hover">
						<td>
							<div class="badge">${reply.id}</div>
						</td>
						<td>${reply.getForPrintRegDateType1()}</td>
						<td>${reply.extra_writer}</td>
						<td>${reply.goodReactionPoint}</td>
						<td align="left">${reply.body}</td>
						<td>
							<c:if test="${reply.actorCanModify }">
								<a class="btn-text-link btn btn-active btn-ghost"
									href="../reply/modify?id=${reply.id }&replaceUri=${rq.encodedCurrentUri }">수정</a>
							</c:if>
						</td>
						<td>
						<c:if test="${reply.actorCanModify }">
								<a class="btn-text-link btn btn-active btn-ghost" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
									href="../reply/doDelete?id=${reply.id }&replaceUri=${rq.encodedCurrentUri }">삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</section>

	
<%@ include file="../common/foot.jspf"%>