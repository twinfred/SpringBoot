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
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121649556-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'UA-121649556-1');
	</script>
	<script>
		$(document).ready(function() {

			var searchData;
			var searchResults = [];
			
			function makeApiRequest(thisQuery){
				searchData = {};
				$.get("https://api.scryfall.com/cards/search?order=released&q="+thisQuery, function(data) {
					searchData = data;
					console.log("Results:", data);
				}).then(
					function(){
						for(var i = 0; i < 10; i++) {
							searchResults.push(searchData.data[i].name);
						}
						$("#searchBox").autocomplete({
							source: searchResults
						})
					}
				)
			}
			
			$("#searchBox").keyup(function(){
				searchResults = [];
				var searchField = $("#searchBox").val();
				if(searchField.length > 2) {
					makeApiRequest(searchField);	
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
	<title>Magic Reviewer | Fan ratings and reviews for Magic: The Gathering cards</title>
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
			        <li class="active"><a href="/">Home</a></li>
			        <li><a href="/leaderboard">Top Scores</a></li>
			        <li><a href="/search?q=magic">Search</a></li>
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
			<div class="col-sm-9 text-left"> 
				<h1>Welcome to Magic Reviewer!</h1>
				<p>Review your favorite Magic: The Gathering cards and earn points to top the charts and become a MTG master reviewer.</p>
				<hr>
				<h4>How it Works:</h4>
				<ol>
					<li>Search for your favorite cards</li>
					<li>Write reviews</li>
					<li>Earn 5-10 points for each review</li>
					<li>Become a top reviewer and earn Magic Reviewer bragging rights</li>
				</ol>
				<hr>
				<h4>Start Searching:</h4>
				<form action="/search">
					<input type="text" name="q" id="searchBox" placeholder="Search for a card">
					<input class="btn btn-primary btn-sm" type="submit" value="Search">
				</form>
				<hr>
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
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<p>The literal and graphical information presented on this site about Magic: The Gathering, including card images, the mana symbols, and Oracle text, is copyright Wizards of the Coast, LLC, a subsidiary of Hasbro, Inc. This website is not produced by, endorsed by, supported by, or affiliated with Wizards of the Coast.</p>
				<p>All other content © 2018 <a href="http://timwinfred.com" target="_blank">TimWinfred.com</a></p>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</footer>
</body>
</html>