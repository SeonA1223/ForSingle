<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.ssafy.happyhouse.model.dto.HouseInfoDto"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.0/dist/chart.min.js"></script>
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
	 <!-- 각 아파트에 자세 내용 -->
  <div class="modal fade" id="aptModal">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="container">
        	<div class="row">
	        	<div class="col-sm-5">
		          <div id="map2" style="width:500px; height: 400px;"> </div>
		          </div>
        	</div>
        	<div class="row">
        	<br>
        		<div class="col-sm-12">
        			 <table class="table">
					  <tbody>
					      <tr>
					        <th>주소</th>
					        <td id="d_address"></td>
					      </tr>
					      <tr>
					        <th>전용면적</th>
					        <td id="d_area"></td>
					      </tr>
					      <tr>
					        <th>건축일자</th>
					        <td id="d_date"></td>
					      </tr>
					      <tr>
					        <th>마지막 거래일 </th>
					        <td id="d_deal"></td>
					      </tr>
					       <tr>
					        <th>가격</th>
					        <td id="d_price"></td>
					      </tr>
					      <tr>
					        <th>해당 층:</th>
					        <td id="d_floor"></td>
					      </tr>
					      <tr></tr>
					    </tbody>
		  </table>
        		</div>
        	</div>
          </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  </div>
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
					name="bookmark" value="something" checked>즐겨찾기 추가
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
		<div class="row mt-4">
			<div class="col-sm-4"></div>
			<div class="col-sm-6" style="height: 50px;" id="noAPT"></div>
		</div>

		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div id="map" style="width: 100%; height: 500px;"></div>
				<div id="noMap" style="width: 100%; height: 500px;"></div>
			</div>
		</div>
		<div style="height: 15%;"></div>
	</div>
	</div>
	<div style="background-color: #6F4E37;" class="container-fluid">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6" id="main_pg">
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
	$("#main_pg").hide();
	
	$("#dongCode_search").click(function(){
		if('${userinfo}'){
			if($('#bookmark').is(":checked") == true) {
				console.log('checked');
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
            success: function (data) {
            	if(data.length != 0){
                $("#main_pg").show();
                $("#noMap").hide();
                $("#noAPT").empty();
                $("#aptlist_table_data").empty();
                let avg_lat = 0;
                let avg_lng = 0;
                let cnt = data.length;
                $(data).each(function (index, data) {
                    let price;
                    if (data.rentMoney == 0) {
                        price = '전세 ' + data.dealAmount;
                    } else {
                        price = '월세 ' + data.dealAmount + "/" + data.rentMoney;
                    }
                    console.log(data);
                    avg_lat += parseFloat(data.lat);
                    avg_lng += parseFloat(data.lng);
                    let str = `<tr class="houseinfo" data-toggle="modal" data-target="#aptModal"
                    aptName="${'${data.aptName}'}" area="${'${data.area}'}"  buildYear="${'${data.buildYear}'}" 
                    dealAmount = "${'${data.dealAmount}'}"  dealDay = "${'${data.dealDay}'}" dealMonth = "${'${data.dealMonth}'}"
                    	dealYear = "${'${data.dealYear}'}"
                    		dong = "${'${data.dong}'}"
                    			floor = "${'${data.floor}'}"
                    				jibun = "${'${data.jibun}'}"
                    					lat = "${'${data.lat}'}"
                    						lng = "${'${data.lng}'}"
                    							rentMoney = "${'${data.rentMoney}'}"
                    >
			            <td>${'${index+1}'}</td>
			            <td>${'${data.aptName}'}</td>
			            <td>${'${price}'}</td>
			            <td>${'${data.floor}'}</td>
			            <td>${'${data.area}'}m²</td>
			          </tr>`;
			    	
                    $("#aptlist_table_data").append(str);
                });
			   showKakaoMap(data, avg_lat/cnt, avg_lng/cnt); 
            	
            }else{
            	 container.style.display = 'none';
            	let str = `<h2>해당 지역에는 전월세 매물이 존재하지 않습니다.</h2>`;
            	$("#noAPT").append(str);
            	$("#main_pg").hide();
            	$("#noMap").show();
            }
            }    
			    
		});
		}else{
			alert("로그인 후 이용해주세요!");
		}
	});

	
});
</script>
<script>
  function showKakaoMap(data, lat, lng){ 	
	  let moveLoc = new kakao.maps.LatLng(lng, lat);
	  map.setCenter(moveLoc); 
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
	 	map.setCenter(moveLoc);
		 
	}
	  var container = document.getElementById('map');
	  container.style.display = 'none';
		var options = {
			center: new kakao.maps.LatLng(33.4832653996197, 126.482300576388),
			level: 6
		};
		
	var map = new kakao.maps.Map(container, options);

	
</script>
<script>
	/* 해당 위치에 존재하는 전월세 표 각각을 클릭하는 함수 */
	$(document).on("click", ".houseinfo", function(){
		console.log("click?");
		let aptName = $(this).attr('aptName');
		let lat = $(this).attr('lat');
		let lng = $(this).attr('lng');
		let area = $(this).attr('area');
		let buildYear = $(this).attr('buildYear');
		let dealAmount = $(this).attr('dealAmount');
		let dealDay = $(this).attr('dealDay');
		let dealMonth = $(this).attr('dealMonth');
		let dealYear = $(this).attr('dealYear');
		let dong = $(this).attr('dong');
		let floor = $(this).attr('floor');
		let jibun = $(this).attr('jibun');
		let rentMoney = $(this).attr('rentMoney');
		console.log(aptName);
		console.log(dong);
		let address = `${dong} ${jibun}`;
		console.log(address);
		 let price;
         if (rentMoney == 0) {
             price = '전세 ' + dealAmount;
         } else {
             price = '월세 ' + dealAmount + "/" + rentMoney;
         }
		showKakaoDetailMap(lat, lng);
		$(".modal-title").text(aptName);
		$("#d_address").text(dong + " " + jibun);
		$("#d_area").text(area + "m²");
		$("#d_date").text(buildYear + "년");
		$("#d_deal").text(dealYear + "년 " + dealMonth + "월 " + dealDay + "일 ");
		$("#d_price").text(price + "만원");
		$("#d_floor").text(floor + "층");
		
	})
	


  function showKakaoDetailMap(lat, lng){
		  let moveLoc = new kakao.maps.LatLng(lng, lat);
		  map2.setCenter(moveLoc); 
 	  setTimeout(function(){
		  console.log("second Maps work??");
		  map2.relayout(); 
	  }, 800); 
 	  
		let markerP = new kakao.maps.LatLng(lng, lat);
		let marker = new kakao.maps.Marker({
			position: markerP
		});
		
		 marker.setMap(map2); 
			let bounds = new kakao.maps.LatLngBounds();
			bounds.extend( new kakao.maps.LatLng(lng, lat));
		 	  map2.setCenter(moveLoc);  
			map2.setBounds(bounds);
	}

	
	 var container2 = document.getElementById('map2');
	 var options2 = {
			center: new kakao.maps.LatLng(33.4832653996197, 126.482300576388),
			level:5
		};
			
	var map2 = new kakao.maps.Map(container2, options2);
	
</script>
