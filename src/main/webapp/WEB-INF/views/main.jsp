<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.ssafy.happyhouse.model.dto.HouseInfoDto"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<style>
html, body {
	width: 100%;
	height: 100%;
	background: url('img/main.jpg');
}

.header {
	width: 100%;
}

.header_td {
	width: 100%;
	table-layout: fixed;
}

#container{
	padding-left: 0px;
	padding-right: 0px;
}
.image-thumbnail {
	 width:100%;
    height:100%;
    object-fit:cover;
}
img.bookmark{
	max-width: 30%; 
	height: auto;
	 position:absolute;
    top:50%; left:50%;
    transform: translate(-50%, -50%);
}

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93658c6b7f4593d6432bd13294164f05&libraries=services,clusterer,drawing"></script>
<script>
	window.onload = function(){
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	}
	</script>
	
<script>
$(document).ready(function(){
						$.get("${pageContext.request.contextPath}/maps"
							,{act:"sido"}
							,function(data, status){
								$("#sido").empty();
								$("#sido").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
								});//each
							}//function
							, "json"
						);//get
					});//ready
					$(document).ready(function(){
						$("#sido").change(function() {
							$.get("${pageContext.request.contextPath}/maps"
									,{act:"gugun", sido:$("#sido").val()}
									,function(data, status){
										$("#gugun").empty();
										$("#gugun").append('<option value="0">선택</option>');
										$.each(data, function(index, vo) {
											$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
										});//each
									}//function
									, "json"
							);//get
						});//change
						$("#gugun").change(function() {
							console.log($("#gugun").val());
							$.get("${pageContext.request.contextPath}/maps"
									,{act:"dong", gugun:$("#gugun").val()}
									,function(data, status){
										console.log(data);
										$("#dong").empty();
										$("#dong").append('<option value="0">선택</option>');
										$.each(data, function(index, vo) {
											$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
										});//each
									}//function
									, "json"
							);//get
						});//change
					});//ready
</script>

</head>
<body>
	<c:import url="./include/header.jsp" ></c:import>
		<div class="container" id="container">
			<div style="height: 200px;"></div>
	 		<div class="row">	
	 			<div class="col-sm-3">
	 			<form class="form">
						  <select name="sido" id="sido" class="custom-select">
						   
						  </select>
						</form>

					</div>
					<div class="col-sm-3">
						<form class="form">
							  <select name="gugun" id="gugun"class="custom-select">
							   	<option value="0">선택</option>
							  </select>
						</form>
					</div>
					<div class="col-sm-3">
						<form class="form">
						  <select name="dong" id="dong"  class="custom-select">
						  	<option value="0">선택</option>
						  </select>
						  </form>
					</div>	
					<div class="col-sm-3">
						<button type="button" class="btn btn-dark">검색</button>
					</div>	
			</div>
			<div class="row">
				<div class="col-sm-7"></div>
				<div class="col-sm-4">
					 <label class="form-check-label" for="bookmark">
				        <input type="checkbox" class="form-check-input" id="bookmark" name="bookmark" value="something" checked>즐겨찾기 추가
				     </label>
				</div>
			</div>
<!-- 			<div style="height: 5%;"></div> -->
			<div class="row">
				<div class="col-sm-1">
					
				</div>
				<div class="col-sm-1" id="boomark_img_div">
					<img class="bookmark" src="${root}/img/bookmark.png">
				</div>
				<div class="col-sm-6">
					<button type="button" class="btn btn-info btn-sm">button</button>
					<button type="button" class="btn btn-info btn-sm">button</button>
					<button type="button" class="btn btn-info btn-sm">button</button>
				</div>

			</div>
			<div style="height: 100px;"></div>
		</div>
		<div class="container">
			<div id="map" style="width:500px;height:400px;"></div>
		
		</div>
</body>