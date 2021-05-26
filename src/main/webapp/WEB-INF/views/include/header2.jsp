<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>HappyHouse</title>
<style type="text/css">
@font-face {
	src: url('fonts/NanumBarunGothic.ttf');
	font-family: "NanumBarunGothic";
}

@font-face {
	src: url('fonts/NanumSquareRoundB.ttf');
	font-family: "NanumSquareRoundB";
}

html, body {
	font-family: 'NanumBarunGothic';
}

a {
	text-decoration: none;
}

  #mainNav .navbar-brand {
    color: rgba(0, 0, 0, 0.7);
  }
  #mainNav .navbar-brand:hover {
    color: #000;
  }
  #mainNav .navbar-nav .nav-item .nav-link {
    color: rgba(0, 0, 0, 0.7);
    padding: 0 1rem;
  }
  #mainNav .navbar-nav .nav-item .nav-link:hover {
    color: #fff;
  }
  #mainNav .navbar-nav .nav-item:last-child .nav-link {
    padding-right: 0;
  }
  #mainNav.navbar-shrink {
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    background-color: #fff;
  }
  #mainNav.navbar-shrink .navbar-brand {
    color: #212529;
  }
  #mainNav.navbar-shrink .navbar-brand:hover {
    color: #f4623a;
  }
  #mainNav.navbar-shrink .navbar-nav .nav-item .nav-link {
    color: #212529;
  }
  #mainNav.navbar-shrink .navbar-nav .nav-item .nav-link:hover {
    color: #f4623a;
  }


</style>
<script>
	$(document).ready(function() {
		$("#login").click(function() {
			if ($("#mbr_id_header").val() == "")
				alert("아이디입력");
			else if ($("#mbr_pwd_header").val() == "")
				alert("비밀번호입력");
			else {
				let loginData = JSON.stringify({
					"id" : $("#mbr_id_header").val(),
					"pwd" : $("#mbr_pwd_header").val()
				});

				$.ajax({
					url : '/user',
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					dataType : 'json',
					data : loginData,
					success : function(msg) {
						if (msg) {
							alert("로그인 성공");
							$("#exampleModal").modal('hide');
							location.href = '/';
						} else {
							alert("아이디 또는 비밀번호가 틀렸습니다.")
						}
					}

				});
			}

		})
		$("#signup").click(function() {
			window.location = "user/signup";
		});

		$("#mypage").click(function() {
			window.location = "user/mypage";
		});

		$("#logout").click(function() {
			window.location = "/logout";
		});
		$("#QnAButton").click(function() {
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
				<form action="" method="post" id="loginForm">
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
	
	<div class="bgc">
		  <nav class="navbar navbar-expand-lg navbar-dark fixed-top py-3" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/">For Single</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" id="QnAButton">QnA</a></li>
                    <c:if test="${userinfo eq null}">
                    	<li class="nav-item">${userinfo.name }</li>
                        <li class="nav-item"><a class="nav-link" id="signup">Sign up</a></li>
                        <li class="nav-item"><a class="nav-link" data-toggle="modal" data-target="#exampleModal">Login</a></li>
                        </c:if>
					<c:if test="${userinfo ne null}">
						  <li class="nav-item"><a class="nav-link" id="mypage">${userinfo.name }님반갑습니다.</a></li>
                        <li class="nav-item"><a class="nav-link" id="logout">Logout</a></li>
					</c:if>                     
                        
                    </ul>
                </div>
            </div>
        </nav>
	
	</div>

</body>

</html>