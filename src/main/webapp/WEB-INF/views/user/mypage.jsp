<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
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

#main {
	margin-top: 50px;
}

a {
	text-decoration: none;
}
</style>

<script type="text/javascript">
$(function(){
		var id = '${userinfo.id}';
		listData();


		function listData(){
		$.ajax({
			
			url : '/user/mypage/list/' + id,
			type: 'GET',
			success: function(user){
				console.log(user.id);
				$("#table").empty();
/* 				let list = 
					`
					<tr>
					<th>ID</th>
					<td><input type="text" name="id" id="id" value = "${'${user.id }'}"disabled> </td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" id="name"  value ="${'${user.name }'}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id = "address" name="address" value = "${'${user.address }'}"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="tel" id = "phoneNum" name="phoneNum" value = "${'${user.phoneNum }'}"></td>
				</tr>
				`; */
				
				
				
				
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
		if(confirm("진짜 삭제하시겠습니까?")){
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
	<c:import url="../include/header.jsp"></c:import>

	<div align="center" id="main">
		<table id="table">

		</table>
		<button id="modify">수정</button>
		<button id="delete">탈퇴</button>
		<a href="/">돌아가기</a>
		
	</div>

</body>
</html>
