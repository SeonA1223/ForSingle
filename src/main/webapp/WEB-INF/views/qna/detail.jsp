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

button.btn-detail {
	position : relative;
	left: 75%;
}

/* button.write_locate_button{
	left : 80%;
} */

button.submit{
	left: 93%;
}

</style>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

$(document).ready(function(){
	$("#has_answer").hide();
 	$("#no_answer").hide(); 
 	$("#write_answer").hide();
	$("#update_qna").hide();
	$("#confirm_ans_modifyButton").hide(); 
	
	getQnAData();
	/* 기본적인 QnAData를 불러오기 */
	function getQnAData(){
		let num = '${num}';
		console.log(num);
		$.ajax({
			url : '/post/' + num,
			type : 'GET',
			dataType:'json',
			success: function(detail){
				console.log(detail);
				$("#title").empty();
				$("#name").empty();
				$("#date").empty();
				$("#contents").empty(); 
				$("#title").append(detail.title);
				$("#name").append(detail.id);
				$("#date").append(detail.date);
				$("#contents").append(detail.descrip);
				getAnswerData(detail.answernum);
			}
		})
	}
	
	/* 답변이 있으면 ajax를 통해서 데이터를 가지고 오고, 없다면 no_answer div가 보인다. 
	   data는 answernum이다.
	*/
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
						$("#answer_detail_title").empty();
						$("#answer_detail_contents").empty();
						$("#answer_detail_title").text(answer.title);
						$("#answer_detail_title").attr('answernum', data);
						$("#answer_detail_contents").text(answer.descrip);
						$("#has_answer").show();
					}
			})
		
		}
	}
	/* 답변 작성 버튼 클릭  시, 답변 작성하는 부분이 보임*/
	$("#ans_writeButton").click(function(){
		$("#write_answer").show();
		$("#answer_modify").hide();
	})
	
	/* 답변 작성 */
	$("#answer_write").click(function(){
		let id = '${userinfo.id}';
		console.log(id);
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
					$("#write_answer").hide();
					getAnswerData(data);
				}
			});
		})
		/* qna 리스트로 이동 */
		$("button.movelist").click(function(){
			location.href="/qna";
		})
		/* 답변 삭제 */
		$("#DelButton").click(function(){
			let res = confirm("답변을 정말 삭제하시겠습니까?");
			if(res){
				let num = '${num}';
				$.ajax({
					url : '/answer/' + num,
					type : 'DELETE',
					dataType:'json',
					success: function(answer){
						$("#has_answer").hide();
						$("#no_answer").show();
					}
				})
			}
		})
		
		/* 답변 수정 */
		$("#ModButton").click(function(){
			$("#has_answer").hide();
			$("#write_answer").show();
			$("#answer_modify").show();
			$("#answer_write").hide();
			$("#answer_title").val($("#answer_detail_title").text());
			$("#answer_contents").val($("#answer_detail_contents").text());
		})
		
		$("#answer_modify").click(function(){
			let id = '${userinfo.id}';
			let answernum = $("#answer_detail_title").attr('answernum');
			let data = JSON.stringify({
				"id" : id,
				"num" : answernum,
				"title" : $('#answer_detail_title').text(),
				"descrip" : $('#answer_detail_contents').text()
			});
			
			$.ajax({
					url :'/answer',
					type: 'PUT',
					contentType:'application/json;charset=utf-8',
					data : data,
					success: function(data){
						getAnswerData(answernum);
						$("#has_answer").show();
						$("#write_answer").hide();
						$("#answer_modify").hide();
						$("#answer_write").hide();
						alert("수정되었습니다.");
					}
				});
		})
		
		
		
		/* 게시글 수정 버튼 눌렀을 때 수정화면 보이기*/
		$("#ans_modifyButton").click(function(){
			$("#qna_board").hide();
			$("#update_qna").show();
			$("#ans_modifyButton").hide();
			$("#confirm_ans_modifyButton").show();
			console.log($("#title").text())
			console.log($("#contents").val())
			$("#modify_qna_title").val($("#title").text());
			$("#modify_qna_contents").val($("#contents").text());
			$("#modify_name").text($("#name").text());
			$("#modify_date").text($("#date").text());
		})
		
		/* 게시글 수정 */
		$("#confirm_ans_modifyButton").click(function(){
			let id = '${userinfo.id}';
			let num = '${num}';
			console.log($('writePost [name=qna_value]').val());
			let data = JSON.stringify({
				"id" : id,
				"num" : num,
				"title" : $('#modify_qna_title').val(),
				"descrip" : $('#modify_qna_contents').val()
			});
			
			$.ajax({
					url :'/post',
					type: 'PUT',
					contentType:'application/json;charset=utf-8',
					data : data,
					success: function(data){
						getQnAData();
						$("#qna_board").show();
						$("#update_qna").hide();
						$("#ans_modifyButton").show();
						$("#confirm_ans_modifyButton").hide();
						alert("수정되었습니다.");
					}
				});
		})
		
		/* 게시글 삭제 */
		$("#ans_del_writeButton").click(function(){
			let res = confirm("게시글을 정말 삭제하시겠습니까?");
			if(res){
				let num = '${num}';
				$.ajax({
					url : '/post/' + num,
					type : 'DELETE',
					dataType:'json',
					success: function(answer){
						location.href = "/qna";
					}
				})
			}
		})
});
</script>
</head>
<body>
	<c:import url="../include/header.jsp" ></c:import>
	
	<div class="container-sm pt-5">
	<h2>QnA</h2>
	
	
	<!-- QnA detail -->
		<div class="container-sm" id="qna_board">
			<table class="table">
			  <tbody>
			    <tr>
			      <th scope="col">제목</th>
			      <td scope="col" colspan='3' id="title"></td>
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
	 	</div>
	 	
	 	  	<!-- qna 수정 폼 -->
	  	<div id="update_qna">
	  		<div class="container-sm">
				<table class="table">
				  <tbody>
				    <tr>
				      <th scope="col">제목</th>
				      <td scope="col" colspan='3' id="title">
				      	 <input type="text" class="form-control" id="modify_qna_title" name="title">
				      </td>
				    </tr>
				    <tr>
				      <th scope="col">이름</th>
				      <td id="modify_name"></td>
				      <th scope="col">날짜</th>
				      <td id="modify_date"></td>
				    </tr>
				    <tr>
				      <td style="height: 200px" colspan='4' id="contents">
				      	<textarea class="form-control" rows="5" id="modify_qna_contents" name="qna_value"></textarea>
				      </td>
				    </tr>
				  </tbody>
				</table>
				 
				
		 	</div>
	  	</div>
		
		
	 	<!-- no answer -->
	 	<div class="container-sm pt-3">
 	 	 <%-- <c:if test="${sessionScope.useinfo.isManager == 1}">   --%>
		 <span  id="no_answer">
			<button type="button" id="ans_writeButton" class="btn btn-detail btn-info write_locate_button">답변 작성</button>
		</span>
		<%-- </c:if>  --%>
		<!-- QnA 수정 삭제 -->
		
		<c:if test="${cookie.modify.value eq 'true'}"> 
			<button type="button" id="ans_modifyButton" class="btn btn-detail btn-success write_locate_button">수정</button>
			<button type="button" id="confirm_ans_modifyButton" class="btn btn-detail btn-success">수정하기</button>
		 	<button type="button" id="ans_del_writeButton" class="btn btn-detail btn-danger write_locate_button">삭제</button>
		 	<button type="button" class="btn btn-light write_locate_button btn-detail movelist">목록 이동</button>
		 	</c:if>
	  	</div>
	 	
	 	
  
		 	<!-- answer detail -->
		 	<div id="has_answer">
			 	<div class="container-sm pt-5 pb-3" >
			 	  <div id="accordion">
				    <div class="card">
				      <div class="card-header">
				        <a class="card-link" id="answer_detail_title" data-toggle="collapse" href="#collapseOne" answernum="">
				         	답변 제목
				        </a>
				      </div>
				      <div id="collapseOne" class="collapse show"  data-parent="#accordion">
				        <div class="card-body" id="answer_detail_contents">
				        	내용
				        </div>
				      </div>
				    </div>
				</div>
			</div>

			<!-- 답변 수정 삭제  -->
			 <button type="button" id="ModButton" class="btn btn-detail btn-success write_locate">수정</button>
			 <button type="button" id="DelButton" class="btn btn-detail btn-danger write_locate">삭제</button>
			 <button type="button" id="writeButton" class="btn btn-detail  btn-light write_locate movelist">목록 이동</button>
	  	</div>
	  		
	
	  	<!-- answer write -->
	  	<div id="write_answer">
	  		<div class="container-sm pt-5 pb-3" >
	  			 <form>
				    <div class="form-group">
				      <label for="answer_title">제목</label>
				      <input type="text" class="form-control" id="answer_title" placeholder="답변 제목을 입력하세요." name="answer_title">
				    </div>
				    <div class="form-group">
				      <label for="answer_contents">답변 내용</label>
				      <textarea rows="5" class="form-control" id="answer_contents" placeholder="답변 내용을 입력하세요" name="answer_contents"></textarea>
				    </div>
				    <button type="button" id="answer_write" class="btn btn-dark m-3 submit">등록</button>
				    <button type="button" id="answer_modify" class="btn btn-success m-3 submit">답글 수정</button>
				  </form>
	  		</div>
	  	</div>


	
</body>
</html>