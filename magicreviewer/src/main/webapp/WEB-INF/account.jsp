<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			console.log($(".cardImg").attr("cardname"))
			var cardNames = [];
			var reviewCount = $("#reviewCount").attr("reviewcount");
			var loopIdx;
			for(var i = 0; i < reviewCount; i++) {
				var cardName = $("#cardImg" + i).attr("cardname");
				$.get("https://api.scryfall.com/cards/search?order=released&q="+cardName, function(data) {
					var cardImg = '';
					console.log("Results:", data);
					var cardUrlName = data.data[0].name;
					console.log(cardUrlName);
					while(cardUrlName.indexOf("'") > -1){
						var apsIdx = cardUrlName.indexOf("'");
						console.log(apsIdx);
						var newName = cardUrlName.slice(0, apsIdx) + "%27" + cardUrlName.slice(apsIdx+1);
						cardUrlName = newName;
						console.log(cardUrlName);
					}
					if(data.data[0].image_uris){
						cardImg += "<a href='/card?name="+cardUrlName+"'><img src='"+ data.data[0].image_uris.normal +"'></a>";
					}else if(data.data[0].card_faces){
						cardImg += "<a href='/card?name="+cardUrlName+"'><img src='"+ data.data[0].card_faces[0].image_uris.normal +"'></a>";
					}else{ 
						cardImg += "<img src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";	
					}
					$('.cardImg[cardname="'+ data.data[0].name +'"]').html(cardImg);
				})
			}
		})
	</script>
	<title><c:out value="${user.username}"/>'s Dashboard</title>
</head>
<body>
	<h1>Hey there, <c:out value="${user.username}"/></h1>
	<h3>Your Score: <c:out value="${user.points}"/></h3>
	<p>Search for a card to review and earn more points:</p>
	<form action="/search">
		<input type="text" name="q" id="searchBox">
		<input type="submit" value="Search">
	</form>
	<h3 id="reviewCount" reviewcount="<c:out value="${reviews.size()}"/>">Your reviews:</h3>
	<table>
		<c:forEach items="${reviews}" var="review" varStatus="loop">
			<tr>
				<td>
					<a href="/card?name=<c:out value="${review[1]}"/>"><c:out value="${review[1]}"/></a>
					<div id="cardImg${loop.index}" class="cardImg" cardname="<c:out value="${review[1]}"/>"></div>
				</td>
				<td>
					<h4><c:out value="${review[3]}"/></h4>
					<c:if test="${review[2] == 1}">
						<img class="starsGiven" src="/img/5_Star_Rating_System_1_star.png">
					</c:if>
					<c:if test="${review[2] == 2}">
						<img class="starsGiven" src="/img/5_Star_Rating_System_2_stars.png">
					</c:if>
					<c:if test="${review[2] == 3}">
						<img class="starsGiven" src="/img/5_Star_Rating_System_3_stars.png">
					</c:if>
					<c:if test="${review[2] == 4}">
						<img class="starsGiven" src="/img/5_Star_Rating_System_4_stars.png">
					</c:if>
					<c:if test="${review[2] == 5}">
						<img class="starsGiven" src="/img/5_Star_Rating_System_5_stars.png">
					</c:if>
					<p><c:out value="${review[4]}"/></p>
					<a href="/review/edit/<c:out value="${review[0]}"/>">Edit</a>
					<a href="/review/delete/<c:out value="${review[0]}"/>">Delete</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>