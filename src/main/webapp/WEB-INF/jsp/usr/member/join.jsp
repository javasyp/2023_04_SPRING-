<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>
<hr />

<!-- Join 폼 체크 -->
<script>
	let submitJoinFormDone = false;
	
	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.loginId.value = form.loginId.value.trim();
		
		if (form.loginId.value == 0) {
			alert('아이디를 입력해 주세요.');
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해 주세요.');
			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해 주세요.');
			return;
		}
		
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPw.focus();
			return;
		}
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value == 0) {
			alert('이름을 입력해 주세요.');
			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해 주세요.');
			return;
		}
		
		form.email.value = form.email.value.trim();
		
		if (form.email.value == 0) {
			alert('이메일을 입력해 주세요.');
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해 주세요.');
			return;
		}
		
		submitJoinFormDone = true;
		
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form action="../member/doJoin" onsubmit="submitJoinForm(this); return false;" method="POST">
				<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
				<table class="table table-zebra w-full">
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<td>아이디</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="아이디를 입력해 주세요." name="loginId" />
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="비밀번호를 입력해 주세요." name="loginPw" />
							</td>
						</tr>
						<tr>
							<td>비밀번호 확인</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="비밀번호 확인을 입력해 주세요." name="loginPwConfirm" />
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="이름을 입력해 주세요." name="name" />
							</td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="닉네임을 입력해 주세요." name="nickname" />
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="전화번호를 입력해 주세요." name="cellphoneNum" />
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" autocomplete="off" placeholder="이메일을 입력해 주세요." name="email" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit">회원가입</button>
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