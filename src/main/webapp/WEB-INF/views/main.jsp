<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.ssafy.happyhouse.model.dto.HouseInfoDto"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@3.3.0/dist/chart.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
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
	background: url('img/background2.jpg');
}

.image-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

img.bookmark {
	max-width: 10%;
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
								<div id="map2" style="width: 450px; height: 400px;"></div>
							</div>
							<div class="col-sm-7">
								<canvas id="shopchart"></canvas>
							</div>
						</div>
						<div class="row">
							<br>
							<div class="col-sm-12">
								<br>
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
											<th>마지막 거래일</th>
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
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
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
				<%-- <img class="bookmark" src="${root}/img/bookmark.png"> --%>
			</div> 
			<div class="col-sm-7" id="favorite">
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
						    		let str = `<span dongcode="${'${cur.code}'}" class="p-1">
											<button type="button" class="btn btn-info btn-sm" fav="favorite_search">${'${cur.dong}'}</button>
											<button type="button" class="btn btn-danger btn-sm" del="delete">X</button>
										</span>`;
										
								    $("#favorite").append(str);
						    	})//each;
							}//if
						}//success
					});//ajax
					$(document).on("click", "[del]", function(){
						$.ajax({
							url : '/deal/' + $(this).parent().attr('dongcode'),
							type: 'DELETE',
							success: function(data) {
								$(this).parent().remove();
								$("#favorite").empty();
								if(data != null){
								    $(data).each(function(index, cur){
							    		let str = 
									    	`<span dongcode="${'${cur.code}'}" class="p-1">
												<button type="button" class="btn btn-info btn-sm" fav="favorite_search">${'${cur.dong}'}</button>
												<button type="button" class="btn btn-danger btn-sm" del="delete">X</button>
											</span>`;
									    $("#favorite").append(str);
							    	})//each;
								}//if
							}//success
						});//ajax
					});//on
					$(document).on("click", "[fav]", function(){
						console.log($(this).parent().attr('dongcode'));
						var fdong_code = $(this).parent().attr('dongcode');
						$.ajax({
							url : '/maps/search/' + $(this).parent().attr('dongcode'),
							type: 'GET',
							success: function(data) {
								if(data.length != 0){
									$("#crimeDiv").show();
					            	$("#crimeDiv").empty();
					            	let ct = `
					            		<canvas id="crimeChart" style="background-color: #FFFFFF;"></canvas>
					    				<br>
					    				<canvas id="populChart" style="background-color: #FFFFFF;"></canvas>
					    				`;
					            	$("#crimeDiv").append(ct);
					            	// 인구수 단위 변경 생각해보기. - 만 단위로 나눠보자. => 너무 작아진다. 백 단위로 변경
					            	// 범죄 기록 없는 지역 검색 시 널체크. - ㅇㅋ...
					            	// favorite에도 기능 넣기.
					        				
					            	console.log("favorite crime 검색 : " + fdong_code);
					            	
					            	$.ajax({
					            		url :'/cp/' + fdong_code,
					        			type: 'GET',
					        			dataType:'json',
					        			success: function(data){
					        				// 우선 컨텍스트를 가져옵니다. 
					        				
					        				var ctx = document.getElementById("crimeChart").getContext('2d');
					        				/*
					        				- Chart를 생성하면서, 
					        				- ctx를 첫번째 argument로 넘겨주고, 
					        				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
					        				*/
					        				
					        				let str = $("#gugun option:selected").val() + "";
					        				console.log(str);        				
					        				let left2 = str.substring(0, 2);
					        				console.log(left2);
					        				let gugun_name = "";
					        				if(left2 == "11" || left2 == "26" || left2 == "27" || 
					        						left2 == "28" || left2 == "29" || left2 == "30" || 
					        						left2 == "31" || left2 == "36"){
					        					gugun_name = $("#sido option:selected").text();
					        				}else {
					        					gugun_name = $("#gugun option:selected").text();
					        				}
					        				var config = {
					        						type: 'bar',
					            				    data: {
					            				        labels: [ data.siname + " 주요 범죄 건수", data.siname + " 인구수(백 단위)"],
					            				        datasets: [{
					            				        	label: '개수',
					            				            data: [data.crime, data.popul/100],
					            				            backgroundColor: [
					            				                'rgba(255, 99, 132, 0.2)',
					            				                'rgba(54, 162, 235, 0.2)'
					            				            ],
					            				            borderColor: [
					            				                'rgba(255,99,132,1)',
					            				                'rgba(54, 162, 235, 1)'
					            				            ],
					            				            borderWidth: 1
					            				        }]
					            				    },
					            				    options: {
					            				        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
					            				        scales: {
					            				            yAxes: [{
					            				                ticks: {
					            				                    beginAtZero:true
					            				                }
					            				            }]
					            				        }
					            				    }
					        				};

					        				var Chart1 = new Chart(ctx, config);

					        				// 우선 컨텍스트를 가져옵니다. 
					        				var ctx2 = document.getElementById("populChart").getContext('2d');
					        				/*
					        				- Chart를 생성하면서, 
					        				- ctx를 첫번째 argument로 넘겨주고, 
					        				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
					        				*/
					        				
					        				var Chart2 = new Chart(ctx2, {
					        				    type: 'bar',
					        				    data: {
					        				        labels: ["전국 주요 범죄 건수", "전국 인구수(백 단위)"],
					        				        datasets: [{
					        				        	label: '개수',
					        				            data: [468470, 51779203/100],
					        				            backgroundColor: [
					        				                'rgba(255, 99, 132, 0.2)',
					        				                'rgba(54, 162, 235, 0.2)'
					        				            ],
					        				            borderColor: [
					        				                'rgba(255,99,132,1)',
					        				                'rgba(54, 162, 235, 1)'
					        				            ],
					        				            borderWidth: 1
					        				        }]
					        				    },
					        				    options: {
					        				        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
					        				        scales: {
					        				            yAxes: [{
					        				                ticks: {
					        				                    beginAtZero:true
					        				                }
					        				            }]
					        				        }
					        				    }
					        				});
					        			},
					        			error:function(request,status,error){
					        		        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					        		    }
					            	});
									
									
								$("#table_list").show();
								$("#main_pg").show();
								$("#noMap").hide();
								$("#noAPT").empty();
								$("#aptlist_table_data").empty();
								let avg_lat = 0;
								let avg_lng = 0;
								let cnt = data.length;
							    $(data).each(function(index, data){
							    	console.log("check" + data);
							    	let price;
							    	if(data.rentMoney == 0){
							    		price = '전세 ' + data.dealAmount;
							    	}else{
							    		price = '월세 ' + data.dealAmount + "/" + data.rentMoney;	
							    	}
							    	console.log(typeof data.lat);
							    	console.log(data.rentMoney);
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
						                    							rentMoney = "${'${data.rentMoney}'}">
									            <td>${'${index+1}'}</td>
									            <td>${'${data.aptName}'}</td>
									            <td>${'${price}'}</td>
									            <td>${'${data.floor}'}</td>
									            <td>${'${data.area}'}m²</td>
									          </tr>`;
									    	
						                    $("#aptlist_table_data").append(str);
							    })
					
							   showKakaoMap(data, avg_lat/cnt, avg_lng/cnt); 
								}else{
									$("#crimeDiv").hide();
					            	 container.style.display = 'none';
					            	 $("#noAPT").empty();
					            	let str = `<h2>해당 지역에는 전월세 매물이 존재하지 않습니다.</h2>`;
					            	$("#noAPT").append(str);
					            	$("#main_pg").hide();
					            	$("#noMap").show();
					            }
							    
							    
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
			<div id="crimeDiv" class="col-sm-3" style="width: 100%; height: 500px;">
				<!-- 주요 범죄 발생 건수 -->
				
			</div>
		</div>
		<div style="height: 10%;"></div>
	</div>
	</div>
	<div style="background-color: #FFCFDA;" class="container-fluid">
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
							    	`<span dongcode="${'${cur.code}'}" class="p-1">
										<button type="button" class="btn btn-info btn-sm" fav="favorite_search">${'${cur.dong}'}</button>
										<button type="button" class="btn btn-danger btn-sm" del ="delete">X</button>
									</span>`;
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
            	
            		$("#crimeDiv").show();
                	$("#crimeDiv").empty();
                	let ct = `
                		<canvas id="crimeChart" style="background-color: #FFFFFF;"></canvas>
        				<br>
        				<canvas id="populChart" style="background-color: #FFFFFF;"></canvas>
        				`;
                	$("#crimeDiv").append(ct);
                	// 인구수 단위 변경 생각해보기. - 만 단위로 나눠보자. => 너무 작아진다. 백 단위로 변경
                	// 범죄 기록 없는 지역 검색 시 널체크. - ㅇㅋ...
                	// favorite에도 기능 넣기.
            			
                	$.ajax({
                		url :'/cp/' + $("#gugun").val(),
            			type: 'GET',
            			dataType:'json',
            			success: function(data){
            				// 우선 컨텍스트를 가져옵니다. 
            				
            				var ctx = document.getElementById("crimeChart").getContext('2d');
            				/*
            				- Chart를 생성하면서, 
            				- ctx를 첫번째 argument로 넘겨주고, 
            				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
            				*/
            				
            				var config = {
            						type: 'bar',
                				    data: {
                				        labels: [data.siname + " 주요 범죄 건수", data.siname + " 인구수(백 단위)"],
                				        datasets: [{
                				        	label: '개수',
                				            data: [data.crime, data.popul/100],
                				            backgroundColor: [
                				                'rgba(255, 99, 132, 0.2)',
                				                'rgba(54, 162, 235, 0.2)'
                				            ],
                				            borderColor: [
                				                'rgba(255,99,132,1)',
                				                'rgba(54, 162, 235, 1)'
                				            ],
                				            borderWidth: 1
                				        }]
                				    },
                				    options: {
                				        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
                				        scales: {
                				            yAxes: [{
                				                ticks: {
                				                    beginAtZero:true
                				                }
                				            }]
                				        }
                				    }
            				};

            				var Chart1 = new Chart(ctx, config);

            				// 우선 컨텍스트를 가져옵니다. 
            				var ctx2 = document.getElementById("populChart").getContext('2d');
            				/*
            				- Chart를 생성하면서, 
            				- ctx를 첫번째 argument로 넘겨주고, 
            				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
            				*/
            				
            				var Chart2 = new Chart(ctx2, {
            				    type: 'bar',
            				    data: {
            				        labels: ["전국 주요 범죄 건수", "전국 인구수(백 단위)"],
            				        datasets: [{
            				        	label: '개수',
            				            data: [468470, 51779203/100],
            				            backgroundColor: [
            				                'rgba(255, 99, 132, 0.2)',
            				                'rgba(54, 162, 235, 0.2)'
            				            ],
            				            borderColor: [
            				                'rgba(255,99,132,1)',
            				                'rgba(54, 162, 235, 1)'
            				            ],
            				            borderWidth: 1
            				        }]
            				    },
            				    options: {
            				        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
            				        scales: {
            				            yAxes: [{
            				                ticks: {
            				                    beginAtZero:true
            				                }
            				            }]
            				        }
            				    }
            				});
            			},
            			error:function(request,status,error){
            		        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
            		    }
                	});	
            		
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
                    let str = `<tr class="houseinfo" no="${'${data.no}'}" data-toggle="modal" data-target="#aptModal"
                    aptName="${'${data.aptName}'}" area="${'${data.area}'}"  buildYear="${'${data.buildYear}'}" 
                    dealAmount = "${'${data.dealAmount}'}"  dealDay = "${'${data.dealDay}'}" dealMonth = "${'${data.dealMonth}'}"
                    	dealYear = "${'${data.dealYear}'}"
                    		dong = "${'${data.dong}'}"
                    			floor = "${'${data.floor}'}"
                    				jibun = "${'${data.jibun}'}"
                    					lat = "${'${data.lat}'}"
                    						lng = "${'${data.lng}'}"
                    							rentMoney = "${'${data.rentMoney}'}">
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
            	$("#crimeDiv").hide();
            	 container.style.display = 'none';
            	 $("#noAPT").empty();
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
	 
	  container.style.display = 'block';
	
	  let positions= [];
	  
		data.forEach(function(element){
			let obj = {
					id : element,
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
			
			kakao.maps.event.addListener(marker, 'click', makeTriggertoOpenModal(positions[i].id));
			
		}
	 	map.setCenter(moveLoc);
	 	
	 	  setTimeout(function(){
			  console.log("second Maps work??");
			  map.relayout(); 
			  map.setCenter(moveLoc);
		  }, 500); 
		 
	}
  
  function makeTriggertoOpenModal(data){
		  return function(){
			  $("#aptModal").modal("show");
				 console.log("click?");
				let aptName = data.aptName;
				let lat = data.lat;
				let lng = data.lng;
				let area = data.area;
				let buildYear = data.buildYear;
				let dealAmount = data.dealAmount;
				let dealDay = data.dealDay;
				let dealMonth = data.dealMonth;
				let dealYear = data.dealYear;
				let dong = data.dong;
				let floor = data.floor;
				let jibun = data.jibun;
				let rentMoney = data.rentMoney;
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
				makeDetailGraph(lat, lng);
				$(".modal-title").text(aptName);
				$("#d_address").text(dong + " " + jibun);
				$("#d_area").text(area + "m²");
				$("#d_date").text(buildYear + "년");
				$("#d_deal").text(dealYear + "년 " + dealMonth + "월 " + dealDay + "일 ");
				$("#d_price").text(price + "만원");
				$("#d_floor").text(floor + "층"); 
		  }
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
	$(document).on("click", ".houseinfo", makeDetail)
	
	function makeDetail(){
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
		makeDetailGraph(lat, lng);
		$(".modal-title").text(aptName);
		$("#d_address").text(dong + " " + jibun);
		$("#d_area").text(area + "m²");
		$("#d_date").text(buildYear + "년");
		$("#d_deal").text(dealYear + "년 " + dealMonth + "월 " + dealDay + "일 ");
		$("#d_price").text(price + "만원");
		$("#d_floor").text(floor + "층");
	}
	

	function makeDetailGraph(lat, lng){
		console.log(lat + "makeDetail");
		$.ajax({
			url :'/detail_info/' + lat + '/' + lng,
			type: 'GET',
			dataType:'json',
			success: function(data){
				let bank = data.bank;
				let chicken = data.chicken;
				let coinLaundry = data.coinLaundry;
				let convenience = data.convenience;
				let mart = data.mart;
				let pharmacy = data.pharmacy;
				let subway = data.subway;
				
				new Chart(document.getElementById("shopchart"), {
				    type: 'horizontalBar',
				    data: {
				        labels: ['은행', '치킨집', '코인세탁소', '편의점', '대형마트', '약국', '지하철역'],
				        datasets: [{
				            label: '근처 상권 정보 (근처 15개 이상의 상권 데이터가 있을 시 15개로 표현합니다.)',
				            data: [bank, chicken, coinLaundry, convenience, mart, pharmacy, subway],
				           
				            backgroundColor: [
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(255, 159, 64, 0.2)',
				                'rgba(255, 205, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				                'rgba(201, 203, 207, 0.2)'
				            ],
				            fill: false,
				        }]
				    },
				    options: {
				        responsive: true,
				        title: {
				            display: true,
				            text: '상권정보'
				        },
				        tooltips: {
				            mode: 'index',
				            intersect: true,
				        },
				        hover: {
				            mode: 'nearest',
				            intersect: false,
				        },
/* 				        scales: {
				            xAxes: [{
				                display: true,
				                scaleLabel: {
				                    display: true,
				                    labelString: 'x축'
				                },
				            }],
				            yAxes: [{
				                display: true,
				                ticks: {
				                    autoSkip: false,
				                },
				                scaleLabel: {
				                    display: true,
				                    labelString: 'y축'
				                }
				            }]
				        } */
				    }
				});

			}
		});
		
	}

  function showKakaoDetailMap(lat, lng){
		  let moveLoc = new kakao.maps.LatLng(lng, lat);
		  map2.setCenter(moveLoc); 

 	  
		let markerP = new kakao.maps.LatLng(lng, lat);
		let marker = new kakao.maps.Marker({
			position: markerP
		});
		
		 marker.setMap(map2); 
			let bounds = new kakao.maps.LatLngBounds();
			bounds.extend( new kakao.maps.LatLng(lng, lat));
		 	
			map2.setBounds(bounds);
			
			let markerPosition = marker.getPosition();
		 	  setTimeout(function(){
				  console.log("second Maps work??");
				  map2.relayout(); 
				  map2.setCenter(markerPosition);
			  }, 500); 
	}

	
	 var container2 = document.getElementById('map2');
	 var options2 = {
			center: new kakao.maps.LatLng(33.4832653996197, 126.482300576388),
			level:5
		};
			
	var map2 = new kakao.maps.Map(container2, options2);
	
</script>
