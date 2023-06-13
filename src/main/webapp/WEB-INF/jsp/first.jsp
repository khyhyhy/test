<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table{
		width: 600px;
		border: 1px solid black;
		border-collapse: collapse;
	}
	table th, table td{
		border: 1px solid black;
		padding: 4px;
	}
	table thead tr{
		background-color: #dedede;
	}

    .marker{
        height: 20px;
        background: #00bfff;
        color: #fff;
        line-height: 20px;
        border-radius: 4px;
        text-align: center;
        padding: 6px 0px;
        margin: 0;
        font-size: 12px;
    }
	</style>
</head>
<body>
	<header>
		<h1>지도 연습</h1>
	</header>
	<article>	
		<table>
			<colgroup>
				<col width="100px"/>
				<col width="*"/>
			</colgroup>			
			<tbody>			
				<tr>
					<td>지역명</td>
					<td>
                        <input type="text" id="loc" />
                    </td>					
				</tr>
			</tbody>
		</table>
        <div id="map" style="width:500px;height:400px;"></div>
	
	</article>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=250e4200a7b1356e59f1fde1429d448a&libraries=services"></script>
	<script>
        // 카카오 지도 표현하기 -------------------------
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
        // -----------------------------------------------
        
        // 주소 - 좌표 변환 객체 생성
        var geocoder = new kakao.maps.services.Geocoder();
        /*
        var callback = function(result, status) {

            // 정상적으로 검색이 완료됐다면...
            if (status === kakao.maps.services.Status.OK) {
                // console.log(result);

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킨다.
                map.setCenter(coords);
            }
        };

        geocoder.addressSearch('해남군 송지면', callback);
        */
        geocoder.addressSearch('관악구 시흥대로 552', function(result, status) {

            // 정상적으로 검색이 완료됐다면...
            if (status === kakao.maps.services.Status.OK) {
                // console.log(result);

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                /*
                // 결과값으로 받은 위치를 마커 생성하기
                var marker = new kakao.maps.Marker({
                    position: coords
                });
                marker.setMap(map); //마커 표현하기
                */
                var marker = new kakao.maps.Marker({
                    position: coords,
                    map: map
                });

                //인포윈도우로 장소에 대한 설명을 표시한다.
                /*
                var infowindow = new kakao.maps.InfoWindow({
                    map: map, // 인포윈도우가 표시될 지도
                    position : coords, 
                    content : '<div class="marker">(주)인크레파스</div>',
                    removable : false
                });
                */
                var infowindow = new kakao.maps.InfoWindow({
                    content : '<div class="marker">(주)인크레파스</div>',
                });
                infowindow.open(map, marker);
/*
                kakao.maps.event.addListener(marker, 'click', function() {
                    // 마커 위에 인포윈도우를 표시합니다
                    infowindow.open(map, marker); 

                });
*/

                // 지도의 중심을 결과값으로 받은 위치로 이동시킨다.
                map.setCenter(coords);

                // style강제 적용
                // 우선 class="market"인 요소들 모두 찾아내야 한다.
                let marker_ar = document.querySelectorAll(".marker");

                marker_ar.forEach(function(e){
                    // 여기는 검색된 요소들의 수만큼 수행하는 곳!
                    let w = e.offsetWidth + 10;
                    let ml = w/2;
                    e.parentElement.style.top = "80px";
                    e.parentElement.style.marginLeft = -ml+"px";
                    e.parentElement.style.width = w+"px";
                    e.parentElement.previousElementSibling.style.display = "none";
                    e.parentElement.parentElement.style.border = "0px";
                    e.parentElement.parentElement.style.background = "none";
                    e.parentElement.style.left = "50%";
                });
            }
        });
	</script>
</body>
</html>