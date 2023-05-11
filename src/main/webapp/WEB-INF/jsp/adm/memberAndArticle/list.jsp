<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ADMIN - MEMBER and BOARD" />
<%@ include file="../../usr/common/head.jspf"%>
<hr />
<section class="mt-8 text-xl flex">
	<div>
		<div class="container mx-auto px-3">
			<div class="flex">
				<div>
					회원 수 :
					<span class="badge">${membersCount } 명</span>
				</div>
			</div>
			<div>
				<form class="flex">

					<select data-value="${authLevel }" name="authLevel" class="select select-bordered">
						<option disabled="disabled">회원 타입</option>
						<option value="3">일반</option>
						<option value="7">관리자</option>
						<option value="0">전체</option>
					</select>
					
					<select data-value="${searchTypeM }" name="searchTypeM" class="select select-bordered">
						<option disabled="disabled">검색 타입</option>
						<option value="loginId">아이디</option>
						<option value="name">이름</option>
						<option value="nickname">닉네임</option>
						<option value="loginId,name,nickname">전체</option>
					</select>


					<input name="searchKeywordM" type="text" class="ml-2 w-96 input input-borderd" placeholder="검색어를 입력해주세요"
						maxlength="20" value="${param.searchKeywordM }" />
					<button type="submit" class="ml-2 btn btn-ghost">검색</button>
				</form>
			</div>
			<div class="table-box-type-1 mt-3">
				<table class="table table-fixed w-full">
					<colgroup>
						<col width="50" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>가입날짜</th>
							<th>수정날짜</th>
							<th>아이디</th>
							<th>이름</th>
							<th>닉네임</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="member" items="${members }">
							<tr class="hover">
								<td>${member.id}</td>
								<td>${member.forPrintType1RegDate}</td>
								<td>${member.forPrintType1UpdateDate}</td>
								<td>${member.loginId}</td>
								<td>${member.name}</td>
								<td>${member.nickname}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page-menu mt-3 flex justify-center">
				<div class="btn-group">

					<c:set var="pageMenuLen" value="6" />
					<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
					<c:set var="endPage" value="${page + pageMenuLen <= mPagesCount ? page + pageMenuLen : mPagesCount}" />

					<c:set var="pageBaseUri" value="?boardId=${boardId }" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchTypeM=${param.searchTypeM }" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeywordM=${param.searchKeywordM }" />

					<c:if test="${startPage > 1}">
						<a class="btn btn-sm" href="${pageBaseUri }&page=1">1</a>
						<c:if test="${startPage > 2}">
							<a class="btn btn-sm btn-disabled">...</a>
						</c:if>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri }&page=${i }">${i }</a>
					</c:forEach>
					<c:if test="${endPage < mPagesCount}">
						<c:if test="${endPage < mPagesCount - 1}">
							<a class="btn btn-sm btn-disabled">...</a>
						</c:if>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${mPagesCount }">${mPagesCount }</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="container mx-auto px-3">
			<div class="flex">
				<div>
					게시글 수 :
					<span class="badge">${articlesCount } 개</span>
				</div>
			</div>
			<div>
				<form class="flex">
				
					<select data-value="${boardId }" name="boardId" class="select select-bordered">
						<option disabled="disabled">게시판 타입</option>
						<option value="1">NOTICE</option>
						<option value="2">PREE</option>
						<option value="3">QnA</option>
						<option value="0">전체</option>
					</select>
					
					<select data-value="${searchTypeA }" name="searchTypeA" class="select select-bordered">
						<option disabled="disabled">검색 타입</option>
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title,body">전체</option>
					</select>

					<input name="searchKeywordA" type="text" class="ml-2 w-96 input input-borderd" placeholder="검색어를 입력해주세요"
						maxlength="20" value="${param.searchKeywordA }" />
					<button type="submit" class="ml-2 btn btn-ghost">검색</button>
				</form>
			</div>
			<div class="table-box-type-1 mt-3">
				<table class="table table-fixed w-full">
					<colgroup>
						<col width="50" />
						<col width="150" />
						<col width="100" />
						<col width="100" />
						<col width="50" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>작성날짜</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="article" items="${articles }">
							<tr class="hover">
								<td>${article.id }</td>
								<td>${article.regDate }</td>
								<td>${article.title }</td>
								<td>${article.extra_writer }</td>
								<td>${article.hitCount }</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page-menu mt-3 flex justify-center">
				<div class="btn-group">

					<c:set var="pageMenuLen" value="6" />
					<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
					<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : aPagesCount}" />

					<c:set var="pageBaseUri" value="?boardId=${boardId }" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchTypeA=${param.searchTypeA }" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeywordA=${param.searchKeywordA }" />

					<c:if test="${startPage > 1}">
						<a class="btn btn-sm" href="${pageBaseUri }&page=1">1</a>
						<c:if test="${startPage > 2}">
							<a class="btn btn-sm btn-disabled">...</a>
						</c:if>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri }&page=${i }">${i }</a>
					</c:forEach>
					<c:if test="${endPage < aPagesCount}">
						<c:if test="${endPage < aPagesCount - 1}">
							<a class="btn btn-sm btn-disabled">...</a>
						</c:if>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${aPagesCount }">${aPagesCount }</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>