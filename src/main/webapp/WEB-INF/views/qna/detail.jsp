<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
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

button.btn {
	position : relative;
	left: 67%;
}

</style>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

$(document).ready(function(){
	getData();
	function getData(){
		let num = '${num}';
		console.log(num);
		$.ajax({
			url : '/post/' + num,
			type : 'GET',
			dataType:'json',
			success: function(detail){
				$("#title").val(detail.title);
				$("#name").val(detail.id);
				$("#date").val(detail.date);
				$("#contents").val(detail.descrip);
			}
		})
	}
});
</script>
</head>
<body>
	<c:import url="../include/header.jsp" ></c:import>
	
	<div class="container-sm pt-5">
	<!-- QnA detail -->
		<div class="container-sm">
			<table class="table">
			  <tbody>
			    <tr>
			      <th scope="col">제목</th>
			      <td scope="col" colspan='3' id="title"></th>
			    </tr>
			    <tr>
			      <th scope="col">이름</th>
			      <td id="name"></td>
			      <th scope="col">날짜</th>
			      <td id="date"></td>
			    </tr>
			    <tr>
			      <td style="height: 300px" colspan='4' id="contents"></td>
			    </tr>
			  </tbody>
			</table>
	 	</div>
	 	<!-- answer detail -->
	 	<div class="container-sm pt-5 pb-3">
	 	  <div id="accordion">
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#collapseOne">
		         	답변 제목
		        </a>
		      </div>
		      <div id="collapseOne" class="collapse show" data-parent="#accordion">
		        <div class="card-body">
		        	내용
		        </div>
		      </div>
		    </div>
		</div>
	</div>
	</div class="container-sm pt-3">
		   <button type="button" id="writeButton" class="btn btn-success write_locate">수정</button>
		   <button type="button" id="writeButton" class="btn btn-danger write_locate">삭제</button>
		   <button type="button" id="writeButton" class="btn btn-light write_locate">목록 이동</button>
  		</div>
	
</body>
</html>