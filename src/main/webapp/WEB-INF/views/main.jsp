<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.ssafy.happyhouse.model.dto.HouseInfoDto"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
}

.header {
	width: 100%;
}

.header_td {
	width: 100%;
	table-layout: fixed;
}
</style>
<script>
    $(document).ready(function(){

		var multi = {lat: 37.5665734, lng: 126.978179};
		var map = new google.maps.Map(document.getElementById('map'), {
			center: multi, zoom: 17
		});
		var marker = new google.maps.Marker({position: multi, map: map});
    	
    	$(document).on("click", "#search", function() {
    		let registerinfo = $('#dong').val();
    		$.ajax({
				url:'${root}/maps/search/' + encodeURI(registerinfo),  
				type:'POST',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				success:function(locations) {
					$(locations).each(function(index, l){
						console.log(l.lat + " " + l.lng);
						addMarker(l.lat, l.lng);
					});
				},
				error:function(xhr,status,msg){
				}
			});
    	});

    });
    
    function addMarker(tmpLat, tmpLng) {
    	var multi = {lat: 37.5665734, lng: 126.978179};
    	var map = new google.maps.Map(document.getElementById('map'), {
			center: multi, zoom: 17
		});
		var marker = new google.maps.Marker({
			position: {lat: parseFloat(tmpLat), lng: parseFloat(tmpLng)},
			map : map
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(marker.getPosition());
		});
		map.setCenter(marker.getPosition());
		marker.setMap(map);
	}
</script>
</head>
<body>
	<c:import url="./include/header.jsp" ></c:import>
	<div class="container">
		
		</div>
</body>