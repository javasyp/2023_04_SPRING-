<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax Test</title>
<style>
.rs {
	border: 3px solid black;
	margin-top: 3px;
	padding: 20px;
	font-size: 2rem;
}
.rs-msg {
	border: 3px solid green;
	margin-top: 3px;
	padding: 20px;
	font-size: 2rem;
}
.rs-code {
	border: 3px solid pink;
	margin-top: 3px;
	padding: 20px;
	font-size: 2rem;
}
</style>
<!-- 제이쿼리 불러오기 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function callByAjaxV2() {
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
	
	function callByAjaxV3() {
	var form = document.sum_form;
		
		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;	// ./doPlus
		
		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			
			data = data.split('/');
			var rs = data[0];
			var msg = data[1];
			$('.rs').text(rs);
			$('.rs-msg').text(msg);
			
		}, 'html');
	}
	
	function callByAjaxV4() {
		var form = document.sum_form;
		
		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;	// ./doPlus
		
		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			
			data = data.split('/');
			var rs = data[0];
			var msg = data[1];
			var code = data[2];
			$('.rs').text(rs);
			$('.rs-msg').text(msg);
			$('.rs-code').text(code);
			
		}, 'html');
	}
	
	function callByAjaxV5() {
		var form = document.sum_form;
		
		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = './doPlusJson';
		
		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			
			$('.rs').text(data.rs);
			$('.rs-msg').text(data.msg);
			$('.rs-code').text(data.code);
			
		}, 'json');
	}
</script>
</head>
<body>
	<h1>Ajax Test</h1>
	
	<form name="sum_form" action="./doPlus" method="POST">
		<input type="text" name="num1" placeholder="정수 입력" required />
		<input type="text" name="num2" placeholder="정수 입력" required />
		<input type="submit" value="더하기" />
		<input onclick="callByAjaxV2();" type="button" value="더하기v2" />
		<input onclick="callByAjaxV3();" type="button" value="더하기v3" />
		<input onclick="callByAjaxV4();" type="button" value="더하기v4" />
		<input onclick="callByAjaxV5();" type="button" value="더하기v5" />
	</form>
	
	<h2>더한 결과</h2>
	<div class="rs"></div>
	
	<h2>더한 결과 메세지</h2>
	<div class="rs-msg"></div>
	
	<h2>더한 결과 코드</h2>
	<div class="rs-code"></div>

</body>
</html>