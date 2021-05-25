<%@page import="com.ssafy.happyhouse.model.dto.UserDto"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.ssafy.happyhouse.model.dto.HouseInfoDto"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<head>
<meta charset='utf-8'>
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

#container {
	padding-left: 0px;
	padding-right: 0px;
	background: url('img/main.jpg');
}

.image-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

img.bookmark {
	max-width: 30%;
	height: 100%;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>




</head>
<body>
	<c:import url="./include/header.jsp"></c:import>
	<div class="container-fluid" id="container">
		<div style="height: 200px;"></div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-2">
				<form class="form">
					<select name="sido" id="sido" class="custom-select">

					</select>
				</form>

			</div>
			<div class="col-sm-2">
				<form class="form">
					<select name="gugun" id="gugun" class="custom-select">
						<option value="0">선택</option>
					</select>
				</form>
			</div>
			<div class="col-sm-2">
				<form class="form">
					<select name="dong" id="dong" class="custom-select">
						<option value="0">선택</option>
					</select>
				</form>
			</div>
			<div class="col-sm-2">
				<button type="button" id="dongCode_search" class="btn btn-dark">검색</button>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-8"></div>
			<div class="col-sm-4">
				<label class="form-check-label" for="bookmark"> <input
					type="checkbox" class="form-check-input" id="bookmark"
					name="bookmark" value="something" checked=false>즐겨찾기 추가
				</label>
			</div>
		</div>
		<!-- 			<div style="height: 5%;"></div> -->
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-1" id="boomark_img_div">
				<img class="bookmark" src="${root}/img/bookmark.png">
			</div>
			<div class="col-sm-6" id="favorite">
				<script>
				$(document).ready(function() {
					$.ajax({
						url :'/deal/fsearch',
						type: 'GET',
						dataType:'json',
						success: function(data){
							$("#favorite").empty();
							if(data != null){
							    $(data).each(function(index, cur){
						    		let str = 
								    	`<div class="${'${cur.code}'}">
											<button type="button" class="btn btn-info btn-sm favorite_search">${'${cur.dong}'}</button>
											<button type="button" class="btn btn-danger btn-sm delete">X</button>
										</div>
										<br>`;
								    $("#favorite").append(str);
						    	})//each;
							}//if
						}//success
					});//ajax
					$(document).on("click", ".delete", function(){
						$.ajax({
							url : '/deal/' + $(this).parent().attr('class'),
							type: 'DELETE',
							success: function(data) {
								$(this).parent().remove();
								$("#favorite").empty();
								if(data != null){
								    $(data).each(function(index, cur){
							    		let str = 
									    	`<div class="${'${cur.code}'}">
												<button type="button" class="btn btn-info btn-sm favorite_search">${'${cur.dong}'}</button>
												<button type="button" class="btn btn-danger btn-sm delete">X</button>
											</div>
											<br>`;
									    $("#favorite").append(str);
							    	})//each;
								}//if
							}//success
						});//ajax
					});//on
					$(document).on("click", ".favorite_search", function(){
						$.ajax({
							url : '/maps/search/' + $(this).parent().attr('class'),
							type: 'GET',
							success: function(data) {
								$("#table_list").show();
								$("#aptlist_table_data").empty();
								let avg_lat = 0;
								let avg_lng = 0;
								let cnt = data.length;
							    $(data).each(function(index, data){
							    	let price;
							    	if(data.rentMoney == 0){
							    		price = '전세 ' + data.dealAmount;
							    	}else{
							    		price = '월세 ' + data.dealAmount + "/" + data.rentMoney;	
							    	}
							    	console.log(typeof data.lat);
							    	avg_lat += parseFloat(data.lat);
							    	avg_lng += parseFloat(data.lng);
							    	let str = ` <tr>
							            <td>${'${index+1}'}</td>
							            <td>${'${data.aptName}'}</td>
							            <td>${'${price}'}</td>
							            <td>${'${data.floor}'}</td>
							            <td>${'${data.area'}}m^2</td>
							          </tr>
							    	`
							    	$("#aptlist_table_data").append(str);
							    })
							    
							    
							   showKakaoMap(data, avg_lat/cnt, avg_lng/cnt); 
							}//success
						});//ajax
					})//on;
				});//ready
				</script>
			</div>

		</div>
		<div style="height: 50px;"></div>
	
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div id="map" style="width: 100%; height: 500px;"></div>
			</div>
		</div>
		<div style="height: 15%;"></div>
	</div>
	<div style="background-color: #6F4E37;" class="container-fluid">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<table class="table table-hover" id="table_list">
					<thead>
						<tr>
							<th>인덱스</th>
							<th>이름</th>
							<th>가격</th>
							<th>층 수</th>
							<th>면적</th>
						</tr>
					</thead>
					<tbody id="aptlist_table_data">
					</tbody>
				</table>
			</div>
		</div>
		</div>
</body>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93658c6b7f4593d6432bd13294164f05&libraries=services"></script>
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
										$("#dong").empty();
										$("#dong").append('<option value="0">선택</option>');
										$.each(data, function(index, vo) {
											$("#dong").append("<option value='"+vo.dongcode+"'>"+vo.dong+"</option>");
										});//each
									}//function
									, "json"
							);//get
						});//change
					});//ready
</script>
<script>

/* function addMarker(data){
	console.log(map);
	
} */

$(document).ready(function(){
	$("#table_list").hide();
	$("#dongCode_search").click(function(){
		if($('#bookmark').is(":checked") == true) {
			console.log('checked');
			if('${userinfo}'){
			}
			$.ajax({
				url: '/deal',
				type: 'POST',
				contentType: 'application/json', // 이거 안했어서 415 에러뜸.
				data: JSON.stringify({
					"dong": $("#dong option:selected").text(),
					"code": $("#dong").val(),
					"userid": '${userinfo.id}'
				}),
				success: function(data){
					console.log('success');
					$("#favorite").empty();
					if(data != null){
					    $(data).each(function(index, cur){
				    		let str = 
						    	`<div class="${'${cur.code}'}">
									<button type="button" class="btn btn-info btn-sm favorite_search">${'${cur.dong}'}</button>
									<button type="button" class="btn btn-danger btn-sm delete">X</button>
								</div>
								<br>`;
						    $("#favorite").append(str);
				    	})//each;
					}//if
				}//success
			})//ajax;
		}//if
		let dongcode = $("#dong").val();
		console.log(dongcode);
		$.ajax({
			url :'/maps/search/' + dongcode,
			type: 'GET',
			dataType:'json',
			success: function(data){
				$("#table_list").show();
				$("#aptlist_table_data").empty();
				let avg_lat = 0;
				let avg_lng = 0;
				let cnt = data.length;
			    $(data).each(function(index, data){
			    	let price;
			    	if(data.rentMoney == 0){
			    		price = '전세 ' + data.dealAmount;
			    	}else{
			    		price = '월세 ' + data.dealAmount + "/" + data.rentMoney;	
			    	}
			    	console.log(typeof data.lat);
			    	avg_lat += parseFloat(data.lat);
			    	avg_lng += parseFloat(data.lng);
			    	let str = ` <tr>
			            <td>${'${index+1}'}</td>
			            <td>${'${data.aptName}'}</td>
			            <td>${'${price}'}</td>
			            <td>${'${data.floor}'}</td>
			            <td>${'${data.area'}}m^2</td>
			          </tr>
			    	`
			    	$("#aptlist_table_data").append(str);
			    })
			    
			    
			   showKakaoMap(data, avg_lat/cnt, avg_lng/cnt); 
/* 			    let lat = avg_lat/cnt;
			    let lng = avg_lng/cnt;

			   
					var container = document.getElementById('map');
					var options = {
						center: new kakao.maps.LatLng(lat, lng),
						level: 2
					};

					var map = new kakao.maps.Map(container, options); */
					
					/* data.forEach(function(element){
						console.log(element);
						let marker = new kakao.maps.Marker({
							position : new kakao.maps.LatLng(element.lat, element.lng)
						})
						marker.setMap(map);
					})
					/* addMarker(data); */
				 } 

			
		});
	})
});
</script>
<script>
  function showKakaoMap(data, lat, lng){
	  let moveLoc = new kakao.maps.LatLng(lng, lat);
	  container.style.display = 'block';
 	  setTimeout(function(){
		  console.log("works?");
		  map.relayout(); 
	  }, 1000);
	
	  let positions= [];
	  
		data.forEach(function(element){
			let obj = {
					title : element.aptName,
					latlng : new kakao.maps.LatLng(element.lng, element.lat)
			}
			positions.push(obj);
			/* let marker = new kakao.maps.Marker({
				position : new kakao.maps.LatLng(element.lat, element.lng)
			});
			marker.setMap(map); */
		})
		console.log(positions);
		for(let i=0; i< positions.length; i++)
		{
			let marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			})
			
		}
		
		map.panTo(moveLoc);
	}
  

	   var container = document.getElementById('map');
	  	 container.style.display = 'none';
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 6
		};
		
	  var map = new kakao.maps.Map(container, options);
	
</script>
