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
button.write_locate {
	position : relative;
	left: 90%;
}
</style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

$(document).ready(function(){
	listData();
	function listData(){
		$.ajax({
			url: 'post',
			type: 'GET',
			contentType: 'application/json;charset=utf-8',
			dataType:'json',
			success: function(lists){
				console.log(lists);
				$("#list").empty();
				$(lists).each(function(index, data){
					let status;
					if(data.answernum == 0){
						status = '접수완료';
					}else {
						status = '답변완료';
					}
					console.log(status);
					 let str = `<tr class="qna_list" id="${'${data.num}'}" >
				        <td>${'${status}'}</td>
				        <td>${'${data.title}'}</td>
				        <td>${'${data.id}'}</td>
				        <td>${'${data.views}'}</td>
				        <td>${'${data.date}'}</td>
				      </tr>
				      `;
				     
				      console.log(str);
				      $("#list").append(str);
				})
			}
		})
	}
	
	$(document).on("click", ".qna_list", function(){
		console.log("click?");
		let num = $(this).attr('id');
		location.href = "/qna/detail?num=" + num;
		
	})
	$("#writeButton").click(function(){
		window.location = "/qna/write";
	})
});

</script>
</head>
<body>
	<c:import url="../include/header.jsp" ></c:import>

	<div class="container-sm pt-5">
		<h2>QnA 게시판</h2>
		<div style="height: 500px" class = "container-sm pt-5">
		  <table class="table pt-3">
		    <thead>
		      <tr>
		        <th>상태</th>
		        <th>제목</th>
		        <th>작성자</th>
		        <th>조회수</th>
		        <th>날짜</th>
		      </tr>
		    </thead>
		    <tbody id="list">
		     

		    </tbody>
		  </table>
  		</div class="container-sm pt-3">
		   <button type="button" id="writeButton" class="btn btn-dark write_locate">글 작성</button>
  		</div>
	</div>
</body>
</html>