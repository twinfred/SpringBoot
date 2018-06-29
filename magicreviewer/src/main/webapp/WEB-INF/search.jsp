<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function() {
			var searchQuery = $("#searchBox").val();
			console.log("Search:", searchQuery);
			
			function makeApiRequest(thisQuery){
				var searchData;
				$.get("https://api.scryfall.com/cards/search?order=released&q="+thisQuery, function(data) {
					searchData = data;
					console.log("Results:", data);
				}).then(
					function(){
						var searchResults = '';
						for(var i = 0; i < searchData.data.length; i++) {
							searchResults += '<div class="row searchResult">'
							var cardUrlName = searchData.data[i].name;
							console.log(cardUrlName);
							while(cardUrlName.indexOf("'") > -1){
								var apsIdx = cardUrlName.indexOf("'");
								console.log(apsIdx);
								var newName = cardUrlName.slice(0, apsIdx) + "%27" + cardUrlName.slice(apsIdx+1);
								cardUrlName = newName;
								console.log(cardUrlName);
							}
							// Result Image
							searchResults += "<div class='searchCardImg col-sm-3'><a href='/card?name=" + cardUrlName + "'>"
							if(searchData.data[i].image_uris){
								searchResults += "<img style='width: 100%' src='"+searchData.data[i].image_uris.art_crop+"'>";
							}else if(searchData.data[i].card_faces){
								searchResults += "<img style='width: 100%' src='"+searchData.data[i].card_faces[0].image_uris.art_crop+"'>";
							}else{
								searchResults += "<img style='width: 100%' src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";
							}
							searchResults += "</a></div>";
							// Card Info
							searchResults += "<div class='searchCardInfo col-sm-9'>";
							searchResults += "<h3><a href='/card?name=" + cardUrlName + "'>" + searchData.data[i].name + "</h3></a>";
							if(searchData.data[i].flavor_text){
								var flavorText = searchData.data[i].flavor_text;
								if(searchData.data[i].flavor_text.length > 100) {
									flavorText = searchData.data[i].flavor_text.slice(0, 120);
									flavorText += "...";
								}
								searchResults += "<p>" + flavorText + "</p>";
							}else if(searchData.data[i].oracle_text){
								var oracleText = searchData.data[i].oracle_text;
								if(searchData.data[i].oracle_text.length > 100) {
									oracleText = searchData.data[i].oracle_text.slice(0, 120);
									oracleText += "...";
								}
								searchResults += "<p>" + oracleText + "</p>";
							}else if(searchData.data[i].type_line){
								var typeText = searchData.data[i].type_line;
								if(searchData.data[i].type_line.length > 100) {
									typeText = searchData.data[i].type_line.slice(0, 120);
									typeText += "...";
								}
								searchResults += "<p>" + typeText + "</p>";
							}
							searchResults += "</div></div>"
						}
						$("#searchResults").html('<h2>' + searchData.total_cards + ' search results for "' + thisQuery + '"</h2><hr>' + searchResults)
					}, function(){
						$("#searchResults").html('<h2>0 search results for "' + thisQuery + '"</h2>')
					}
				)
			}
			
			makeApiRequest(searchQuery);
			
			$("#searchBox").keyup(function(){
				$("#searchResults").html('');
				var searchField = $("#searchBox").val();
				if(searchField.length > 2) {
					makeApiRequest(searchField);	
				}else{
					makeApiRequest(searchQuery);
				}
			})
			
			// get recent reviews images
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
						cardImg += "<a href='/card?name="+cardUrlName+"'><img class='sidebarCard' src='"+ data.data[0].image_uris.normal +"'></a>";
					}else if(data.data[0].card_faces){
						cardImg += "<a href='/card?name="+cardUrlName+"'><img class='sidebarCard' src='"+ data.data[0].card_faces[0].image_uris.normal +"'></a>";
					}else{ 
						cardImg += "<img class='sidebarCard' src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";	
					}
					$('.cardImg[cardname="'+ data.data[0].name +'"]').html(cardImg);
				})
			}
		})
	</script>
	<title>Results for "<c:out value="${searchQuery}"/>" | Magic Reviewer Search</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
			    	<span class="icon-bar"></span>
			    	<span class="icon-bar"></span>
			    	<span class="icon-bar"></span>                        
				</button>
				<a class="navbar-brand" href="/">Magic Reviewer</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
		    	<ul class="nav navbar-nav">
			        <li><a href="/">Home</a></li>
			        <li><a href="/leaderboard">Top Scores</a></li>
			        <li class="active"><a href="/search?q=magic">Search</a></li>
		    	</ul>
		    	<c:choose>
			  	<c:when test = "${user != null}">
			  		<ul class="nav navbar-nav navbar-right">
						<li><a href="/account">My Account</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="nav navbar-nav navbar-right">
        				<li><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        				<li><a href="/registration"><span class="glyphicon glyphicon-log-in"></span> Register</a></li>
      				</ul>	      
				</c:otherwise>
		    	</c:choose>
			</div>
		</div>
	</nav>
	  
	<div class="container-fluid text-center">    
		<div class="row content">
			<div class="col-sm-9 text-left" id="body-content"> 
				<form action="/search">
					<input type="text" name="q" value="<c:out value="${searchQuery}"/>" id="searchBox">
					<input class="btn btn-primary btn-sm" type="submit" value="Search">
				</form>
				<div id="searchResults"></div>
			</div>
			<div class="col-sm-3 sidenav">
				<h4 id="reviewCount" reviewcount="<c:out value="${recentReviews.size()}"/>">Recent reviews:</h4>
				<c:forEach items="${recentReviews}" var="review" varStatus="loop">
					<div class="well">
						<h4><a href="/card?name=<c:out value="${review.card.name}"/>"><c:out value="${review.card.name}"/></a></h4>
						<div id="cardImg${loop.index}" class="cardImg" cardname="<c:out value="${review.card.name}"/>"></div>
						<h4><c:out value="${review.title}"/></h4>
						<c:if test="${review.rating == 1}">
							<img class="starsGiven starsGivenSidebar" src="/img/5_Star_Rating_System_1_star.png">
						</c:if>
						<c:if test="${review.rating == 2}">
							<img class="starsGiven starsGivenSidebar" src="/img/5_Star_Rating_System_2_stars.png">
						</c:if>
						<c:if test="${review.rating == 3}">
							<img class="starsGiven starsGivenSidebar" src="/img/5_Star_Rating_System_3_stars.png">
						</c:if>
						<c:if test="${review.rating == 4}">
							<img class="starsGiven starsGivenSidebar" src="/img/5_Star_Rating_System_4_stars.png">
						</c:if>
						<c:if test="${review.rating == 5}">
							<img class="starsGiven starsGivenSidebar" src="/img/5_Star_Rating_System_5_stars.png">
						</c:if>
						<c:if test="${review.review.length() > 140}">
							<p><span style="font-weight: bold"><c:out value="${review.user.username}"/> says:</span> <c:out value="${review.review.substring(0, 141)}"/>...</p>
						</c:if>
						<c:if test="${review.review.length() < 141}">
							<p><span style="font-weight: bold"><c:out value="${review.user.username}"/> says:</span> <c:out value="${review.review}"/></p>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<footer class="container-fluid text-center">
		<p>Site created by <a href="http://timwinfred.com" target="_blank">Tim Winfred</a></p>
	</footer>
</body>
</html>