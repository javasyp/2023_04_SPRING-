<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="FIND PASSWORD" />
<%@ include file="../common/head.jspf"%>
<hr />

<!-- 비밀번호 찾기 폼 체크 -->
<script type="text/javascript">
	let MemberFindLoginPw__submitFormDone = false;
	
	function MemberFindLoginPw__submit(form) {
		
		if (MemberFindLoginPw__submitFormDone) {
			return;
		}
		
		memberLoginId = form.loginId.value.trim();
		
		if (memberLoginId.length == 0) {
			alert('이름을 입력하세요.');
			form.loginId.focus();
			return;
		}
		
		memberEmail = form.email.value.trim();
		
		if (memberEmail.length == 0) {
			alert('이메일을 입력하세요.');
			form.email.focus();
			return;
		}
		
		MemberFindLoginPw__submitFormDone = true;
		
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this); return false;">
			<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri }" />
				<table border="1">
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<td>아이디</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off"
									placeholder="아이디를 입력해 주세요." name="loginId" required/>
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off"
									placeholder="이메일을 입력해 주세요." name="email" required/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit">비밀번호 찾기</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div>
			<button class="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>