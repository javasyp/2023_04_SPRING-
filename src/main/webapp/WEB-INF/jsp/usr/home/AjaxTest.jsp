<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax Test</title>
<style>
.rs {
	border: 2px solid black;
	margin-top: 3px;
	padding: 20px;
	font-size: 2rem;
}
</style>
<!-- 제이쿼리 불러오기 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function callByAjax() {
		var form = document.sum_form;
		
		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;	// ./doPlus
		
		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			
			//$('.rs').empty().append(data);
			$('.rs').text(data);

		}, 'html');
	}
</script>
</head>
<body>
	<h1>Ajax Test</h1>
	
	<form name="sum_form" action="./doPlus" method="POST">
		<input type="text" name="num1" placeholder="정수 입력" required />
		<input type="text" name="num2" placeholder="정수 입력" required />
		<input type="submit" value="더하기" />
		<input onclick="callByAjax();" type="button" value="더하기2" />
	</form>
	
	<h2>더한 결과</h2>
	
	<div class="rs"></div>

</body>
</html>