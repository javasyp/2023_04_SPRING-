<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="REPLY MODIFY" />
<%@ include file="../common/head.jspf"%>
<hr />

<!-- Reply 폼 체크 -->
<script type="text/javascript">
	let ReplyModify__submitFormDone = false;
	
	function ReplyModify__submit(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}
		
		replyBody = form.body.value.trim();
		
		if (replyBody.length == 0) {
			alert('내용을 입력해 주세요.');
			form.body.focus();
			return;
		}
		
		ReplyModify__submitFormDone = true;
		
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form action="../reply/doModify" method="POST" onsubmit="ReplyModify__submit(this); return false;">
				<input type="hidden" name="id" value="${reply.id }" />
				<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<td>게시물 번호</td>
							<td>
								<div class="badge">${article.id}</div>
							</td>
						</tr>
						<tr>
							<td>게시물 제목</td>
							<td>
								<div class="badge">${article.title}</div>
							</td>
						</tr>
						<tr>
							<td>게시물 내용</td>
							<td>
								<div class="badge">${article.body}</div>
							</td>
						</tr>
						<tr>
							<td>댓글 번호</td>
							<td>
								<div class="badge">${reply.id}</div>
							</td>
						</tr>
						<tr>
							<td>댓글 작성날짜</td>
							<td>${reply.regDate }</td>
						</tr>
						<tr>
							<td>댓글 작성자</td>
							<td>${reply.extra_writer }</td>
						</tr>
						<tr>
							<td>댓글 내용</td>
							<td>
								<textarea class="input input-bordered w-full max-w-xs" name="body" placeholder="내용을 입력해 주세요.">${reply.body }</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit">수정</button>
							</td>
						</tr>
					</tbody>

				</table>
			</form>
		</div>
		<div class="btns">
			<button class="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back();">뒤로가기</button>


		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>