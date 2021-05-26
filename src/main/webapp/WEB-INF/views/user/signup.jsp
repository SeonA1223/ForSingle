<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
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

<script type="text/javascript">
	$(function() {
		$("#join_btn").click(function(){
			console.log("click");
			console.log($('#mbr_id').val());
			let data = JSON.stringify({
				
				"id" : $('#mbr_id').val(),
				"pwd" : $('#mbr_pwd').val(),
				"name" : $('#mbr_nm').val(),
				"address" : $('#mbr_addr').val(),
				"phoneNum" : $('#mbr_tel').val()
			
			});
			$.ajax({
				url : '/user/signup',
				type : 'POST',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				data : data,
				success: function(result){
					if(result>0) location.href = "/";
				}
			})
		})
	});
</script>

</head>
<body>
	<c:import url="header.jsp"></c:import>

	<!-- Sign Up Form -->

<div style="height:100px;"></div>
	<div class="wrapper">
		<br> <br>
		<div class="container"
			style="border-radius: 20px; background-color: whitesmoke;">

			<h1 class="text-left">회원가입</h1>

			<br>

			<form method="post" action="">
				<div class="form-group"
					style="display: flex; align-items: center; justify-content: center;">
					<table>
						<tr>
							<td style="width: 60px;"><b>아이디</b></td>
							<td><input type="text" class="form-control" id="mbr_id"
								name="id" style="width: 500px"></td>
						</tr>
					</table>
				</div>
				<br>
				<div class="form-group"
					style="display: flex; align-items: center; justify-content: center;">
					<table>
						<tr>
							<td style="width: 60px;"><b>비밀번호</b></td>
							<td><input type="password" class="form-control" id="mbr_pwd"
								name="pwd" style="width: 500px"></td>
						</tr>
					</table>
				</div>
				<br>
				<div class="form-group"
					style="display: flex; align-items: center; justify-content: center;">
					<table>
						<tr>
							<td style="width: 60px;"><b>이름</b></td>
							<td><input type="text" class="form-control" id="mbr_nm"
								name="name" style="width: 500px"></td>
						</tr>
					</table>
				</div>
				<br>
				<div class="form-group"
					style="display: flex; align-items: center; justify-content: center;">
					<table>
						<tr>
							<td style="width: 60px;"><b>주소</b></td>
							<td><input type="" class="form-control" id="mbr_addr"
								name="address" style="width: 500px"></td>
						</tr>
					</table>
				</div>
				<br>
					
				<div class="form-group"
					style="display: flex; align-items: center; justify-content: center;">
					<table>
					<tr><td colspan="2"><p>전화번호 숫자만 입력하세요.</p><br></td></tr>
						<tr>
						
							<td style="width: 60px;"><b>전화번호</b></td>
							<td><input type="tel" class="form-control" id="mbr_tel"
								name="phoneNum" style="width: 500px"></td>
						</tr>
					</table>
				</div>

				<br>
				<div class="form-group row" style="margin: auto; width: 5%;">
					<button type="button" class="btn btn-primary" id="join_btn">회원가입</button>
				</div>
			</form>
			<br> <br>

		</div>
		<br> <br>
	</div>
</body>
</html>