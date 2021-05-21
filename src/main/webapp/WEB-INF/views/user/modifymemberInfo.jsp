<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>header</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' type='text/css' media='screen' href='main.css'>
<script src='main.js'></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
html, body {
	width: 100%;
	height: 100%;
}

.header {
	width: 100%;
}

.header_td {
	width: 100%;
	table-layout: fixed;
}
</style>
</head>
<body>
	<!-- header -->
	<c:import url="header.jsp"></c:import>

	<!-- Sign Up Form -->


	<div class="wrapper" style="background-color: lightslategrey;">
		<br> <br>
		<div class="container"
			style="border-radius: 20px; background-color: whitesmoke;">

			<h1 class="text-left">회원 정보 수정</h1>

			<br>

				<form method="post" action="user">
				<input type="hidden" name="act" value="update">
			<div class="form-group"
				style="display: flex; align-items: center; justify-content: center;">
				
				<table>
					<tr>
						<td style="width: 60px;"><b>이름</b></td>
						<td><input type="text" class="form-control" id="title" name="name"
							style="width: 500px"></td>
					</tr>
				</table>
			</div>
			<br>
			<div class="form-group"
				style="display: flex; align-items: center; justify-content: center;">
				<table>
					<tr>
						<td style="width: 60px;"><b>주소</b></td>
						<td><input type="text" class="form-control" id="title" name="address"
							style="width: 500px"></td>
					</tr>
				</table>
			</div>
			<br>
			<div class="form-group"
				style="display: flex; align-items: center; justify-content: center;">
				<table>
					<tr>
						<td style="width: 60px;"><b>전화번호</b></td>
						<td><input type="text" class="form-control" id="title" name="phoneNum"
							style="width: 500px"></td>
					</tr>
				</table>
			</div>

			<br>
			<div class="form-group row" style="margin: auto; width: 5%;">
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
			<br> <br>
			</form>
		</div>
		<br> <br>
	</div>




</body>
</html>