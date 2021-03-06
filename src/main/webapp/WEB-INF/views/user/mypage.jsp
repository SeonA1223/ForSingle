<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- SimpleLightbox plugin CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

a {
	text-decoration: none;
}
</style>

<script>
$(document).ready(function(){
		var id = '${userinfo.id}';
		console.log(id);
		listData();


		function listData(){
		$.ajax({
			
			url : '/user/mypage/list/' + id,
			type: 'GET',
			success: function(user){
				console.log(user.id);
				$("#table").empty();
 				let list = `
 					<br> <br>
 					<form>
 				<div class="form-group"
 					style="display: flex; align-items: center; justify-content: center;">
 					
 					<table>
 						<tr>
 							<td style="width: 60px;"><b>아이디</b></td>
 							<td><input type="text" class="form-control" id="id" name="id" value = "${'${user.id }'}" disabled
 								style="width: 500px"></td>
 						</tr>
 					</table>
 				</div>
 				</br>
 				<div class="form-group"
 					style="display: flex; align-items: center; justify-content: center;">
 					
 					<table>
 						<tr>
 							<td style="width: 60px;"><b>이름</b></td>
 							<td><input type="text" class="form-control" id="name" name="name" value ="${'${user.name }'}"
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
 							<td><input type="text" class="form-control" id="address" name="address" value = "${'${user.address }'}"
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
 							<td><input type="text" class="form-control" id="phoneNum" name="phoneNum" value = "${'${user.phoneNum }'}"
 								style="width: 500px"></td>
 						</tr>
 					</table>
 				</div>

 				<br>
 			
 				</form>
				`; 
				
				
				
				
				$("#table").append(list);
			}
		})
		}
	
	
	$("#modify").click(function(){
		console.log($('#address').val());
		let data = JSON.stringify({
			"id" : $('#id').val(),
			"name" : $('#name').val(),
			"address" : $('#address').val(),
			"phoneNum" : $('#phoneNum').val()
		
		});
		$.ajax({
			url : '/user/mypage/list',
			type : 'PUT',
			contentType:'application/json;charset=utf-8',
			data : data,
			success: function(res){
					 alert("수정되었습니다.");
					 listData();			 
			}
		})
		
	})
	
	$("#delete").click(function(){
		console.log(id);
		if(confirm("진짜 탈퇴하시겠습니까?")){
			$.ajax({
				url : '/user/mypage/list/' + id,
				type: 'DELETE',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				success: function(res){
				alert("삭제되었습니다.");
				location.href = "/";
				}
			})
		}
	})
});
</script>


</head>
<body>
	

	<div style="height:100px;"></div>
	<div align="center mb-3" id="main" style="border-radius: 20px; background-color: whitesmoke;">
			<h1 style="text-align : center;">My Page</h1>
		<div id="table">

		</div>
			<div class="form-group row" style="margin: auto; width: 15%;">
 					<button class="btn btn-primary" id="modify">수정</button>&nbsp&nbsp
 					<button id="delete" class="btn btn-danger">탈퇴</button>&nbsp&nbsp
 					<a href="/">돌아가기</a>
 				</div>
		
		
		
		
	</div>

</body>
</html>
