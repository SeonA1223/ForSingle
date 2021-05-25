<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HappyHouse</title>
<style type="text/css">
a{
	text-decoration : none;
}
</style>
<script>
            $(document).ready(function(){
            	$("#login").click(function(){
            		if($("#mbr_id_header").val() == "") alert("아이디입력");
            		else if($("#mbr_pwd_header").val() == "") alert("비밀번호입력");
            		else{
            		let loginData = JSON.stringify({
            			"id" : $("#mbr_id_header").val(),
            			"pwd" : $("#mbr_pwd_header").val()
            		});
            		
            		$.ajax({
            			url : '/user',
            			type : 'POST',
            			contentType : 'application/json;charset=utf-8',
        				dataType:'json',
        				data: loginData,
        				success: function(msg){
        					if(msg){
        						alert("로그인 성공");
        						$("#exampleModal").modal('hide');
        						location.href = '/';
        					}else{
        						alert("아이디 또는 비밀번호가 틀렸습니다.")
        					}
        				}
        					
            		});
            		}
            		
            	})
                $("#signup").click(function(){
                    window.location="user/signup";
                });

                
                $("#mypage").click(function(){
                	window.location="user/mypage";
                });
                
                $("#logout").click(function(){
                	window.location="/logout";
                });
                $("#QnAButton").click(function(){
                	window.location = "/qna";
                })
                
            });
</script>
</head>
<body>
	<!-- header -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="" method="post" id = "loginForm">
					<div class="modal-body">

						<div class="form-group">
							<label for="mbr_id_header">ID:</label> <input type="text"
								id="mbr_id_header" name="id" class="form-control"
								placeholder="Enter ID">
						</div>
						<div class="form-group">
							<label for="mbr_pwd_header">Password:</label> <input
								type="password" id="mbr_pwd_header" class="form-control"
								name="pwd" placeholder="Enter Password">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="login">로그인</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="header"
		style="background-color: rgb(61, 61, 61); height: 70px; vertical-align: middle;">
		<table class="header">
			<tr class="header">
				<td style="width: 80px;" class="header">
					<div style="padding: 10px 10px 10px 10px; width: 80px;">
						<a href="/"> <img src="${root}/img/ssayy_logo.png"
							style="width: 65px; height: 50px; vertical-align: middle;">
						</a>
					</div>
				</td>
				<td class="header_td">
					<div style="vertical-align: middle;">
						<h3 class="text-center" onclick="main" style="color: white; float: left;">For Single<h3>
					</div>
				</td>


				<td style="width: 400px;" class="header_td">
					<table style="width: 400px; border-spacing: 10px; float: right;">
						<tr>
							<td>
								<div >
									<button type="button" class=" btn" id="QnAButton"
										style="color: white;">QnA</button>
								</div>
							</td>
							<c:if test="${userinfo eq null}">
								<p> ${userinfo.name } </p>
								<td>
									<div >
										<button type="button" class="btn"
											style="color: white;"
											id="signup">Sign Up</button>
									</div>
								</td>
								<td>
									<div style="padding: 10px 10px 10px 10px;">
										<button type="button" class="btn"
											data-toggle="modal"
											style="color: white;"
											data-target="#exampleModal">Login</button>
									</div>
								</td>
							</c:if>

							<c:if test="${userinfo ne null}">
								<td>
									<div>
										<button type="button" class="btn"
											style="color: white;"
											id="mypage">${userinfo.name }님 반갑습니다.</button>
									</div>
								</td>
								<td>
									<div style="padding: 10px 10px 5px 10px;">
										<button type="button" class="btn"
											style="color: white;"
											id="logout">Logout</button>

									</div>
								</td>
							</c:if>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</body>

</html>