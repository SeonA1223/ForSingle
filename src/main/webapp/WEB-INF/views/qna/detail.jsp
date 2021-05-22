<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%-- <c:set var="answerNum" scope="{page}"/> --%>
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
	left: 75%;
}

button.write_locate_button{
	left : 70%;
}

</style>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

$(document).ready(function(){
	$("#has_answer").hide();
	$("#no_answer").hide();
	$("#write_answer").hide();
	getQnAData();
	function getQnAData(){
		let num = '${num}';
		console.log(num);
		$.ajax({
			url : '/post/' + num,
			type : 'GET',
			dataType:'json',
			success: function(detail){
				console.log(detail);
				$("#title").append(detail.title);
				$("#name").append(detail.id);
				$("#date").append(detail.date);
				$("#contents").append(detail.descrip);
				getAnswerData(detail.answernum);
			}
		})
	}
	
	function getAnswerData(data){
		let num = data;
		console.log(num); 
		if(num==0){
			$("#no_answer").show();
		}
		else{
			$.ajax({
				url : '/answer/' + num,
				type : 'GET',
				dataType:'json',
				success: function(answer){
						$("#answer_title").text(answer.title);
						$("#answer_contents").text(answer.descrip);
						$("#has_answer").show();
					}
			})
		
		}
	}
	$("#ans_writeButton").click(function(){
		$("#write_answer").show();
	})
	$("#answer_write").click(function(){
		let id = '${userinfo.id}';
		let num = '${num}';
		let data = JSON.stringify({
			"id" : id,
			"title" : $('#write_answer [name=answer_title]').val(),
			"descrip" : $('#write_answer [name=answer_contents]').val()
		});
		
		$.ajax({
				url :'/answer/' + num,
				type: 'POST',
				contentType:'application/json;charset=utf-8',
				data : data,
				success: function(data){
					console.log(data);
					$("#no_answer").hide();
					getAnswerData(data);
				}
			});
		})
});
</script>
</head>
<body>
	<c:import url="../include/header.jsp" ></c:import>
	
	<div class="container-sm pt-5">
	<h2>QnA</h2>
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
	 	<!-- no answer -->
		 <div class="container-sm pt-3" id="no_answer">
			<button type="button" id="ans_writeButton" class="btn btn-info write_locate_button">답변 작성</button>
			<button type="button" id="ans_modifyButton" class="btn btn-success write_locate_button">수정</button>
		 	<button type="button" id="ans_del_writeButton" class="btn btn-danger write_locate_button">삭제</button>
		 	<button type="button" class="btn btn-light write_locate_button movelist">목록 이동</button>
	  	</div>
	 	
	 	
	 	<!-- answer detail -->
	 	<div id="has_answer">
		 	<div class="container-sm pt-5 pb-3" >
		 	  <div id="accordion">
			    <div class="card">
			      <div class="card-header">
			        <a class="card-link" id="answer_title" data-toggle="collapse" href="#collapseOne">
			         	답변 제목
			        </a>
			      </div>
			      <div id="collapseOne" class="collapse show" id="answer_contents" data-parent="#accordion">
			        <div class="card-body">
			        	내용
			        </div>
			      </div>
			    </div>
			</div>
		</div>
	
		 <button type="button" id="writeButton" class="btn btn-success write_locate">수정</button>
		 <button type="button" id="writeButton" class="btn btn-danger write_locate">삭제</button>
		 <button type="button" id="writeButton" class="btn btn-light write_locate movelist">목록 이동</button>
  	</div>
  	
  	<div id="write_answer">
  		<div class="container-sm pt-5 pb-3" >
  			 <form>
			    <div class="form-group">
			      <label for="answer_title">제목</label>
			      <input type="text" class="form-control" id="answer_title" placeholder="답변 제목을 입력하세요." name="answer_title">
			    </div>
			    <div class="form-group">
			      <label for="answer_contents">답변 내용</label>
			      <input type="text" class="form-control" id="answer_contents" placeholder="답변 내용을 입력하세요" name="answer_contents">
			    </div>
			    <button type="button" id="answer_write" class="btn btn-dark m-3 submit">등록</button>
			  </form>
  		</div>
  	</div>
  	</div>

	
</body>
</html>