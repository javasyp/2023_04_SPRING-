<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY" />
<%@ include file="../common/head.jspf"%>
<hr />

<!-- Member 폼 체크 -->
<script type="text/javascript">
	let MemberModify__submitFormDone = false;
	
	function MemberModify__submitForm(form) {
		if (MemberModify__submitFormDone) {
			return;
		}
		
		memberLoginPw = form.loginPw.value.trim();
		
		if (memberLoginPw.length > 0) {
			memberLoginPwConfirm = form.loginPwConfirm.value.trim();
			
			if (memberLoginPwConfirm.length == 0) {
				alert('비밀번호 확인을 입력해 주세요.');
				form.loginPwConfirm.focus();
				return;
			}
			
			if (memberLoginPw != memberLoginPwConfirm) {
				alert('비밀번호가 일치하지 않습니다.');
				form.loginPw.focus();
				return;
			}
		}
		
		memberName = form.name.value.trim();
		memberNickname = form.nickname.value.trim();
		memberCellPhoneNum = form.cellphoneNum.value.trim();
		memberEmail = form.email.value.trim();
		
		if (memberName.length == 0) {
			alert('이름을 입력해 주세요.');
			form.name.focus();
			return;
		}
		
		if (memberNickname.length == 0) {
			alert('닉네임을 입력해 주세요.');
			form.nickname.focus();
			return;
		}
		
		if (memberCellPhoneNum.length == 0) {
			alert('전화번호를 입력해 주세요.');
			form.cellphoneNum.focus();
			return;
		}
		
		if (memberEmail.length == 0) {
			alert('이메일을 입력해 주세요.');
			form.email.focus();
			return;
		}
		
		MemberModify__submitFormDone = true;
		
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form action="../member/doModify" method="POST" onsubmit="MemberModify__submitForm(this); return false;">
				<input type="hidden" name="loginId" value="${rq.loginedMember.loginId }" />
				<table border="1">
					<colgroup>
						<col width="200" />
					</colgroup>
	
					<tbody>
						<tr>
							<td>가입일</td>
							<td>${rq.loginedMember.regDate }</td>
						</tr>
						<tr>
							<td>아이디</td>
							<td>${rq.loginedMember.loginId }</td>
						</tr>
						<tr>
							<td>새 비밀번호</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="loginPw"
									autocomplete="off" placeholder="새 비밀번호를 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td>새 비밀번호 확인</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="loginPwConfirm"
									autocomplete="off" placeholder="새 비밀번호 확인을 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="name"
									value="${rq.loginedMember.name }"
									placeholder="이름을 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="nickname"
									value="${rq.loginedMember.nickname }"
									placeholder="닉네임을 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="cellphoneNum"
									value="${rq.loginedMember.cellphoneNum }"
									placeholder="전화번호를 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="email"
									value="${rq.loginedMember.email }"
									placeholder="이메일을 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit">회원 정보 수정</button>
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