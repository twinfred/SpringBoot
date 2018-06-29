<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
			var imgIdx = '';
			var searchData;
			var searchResults = [];
			
			function makeApiRequest(thisQuery, search){
				searchData = {};
				$.get("https://api.scryfall.com/cards/search?order=released&q="+thisQuery, function(data) {
					searchData = data;
					console.log("Results:", searchData);
				}).then(
					function(){
						if(search) {
							for(var i = 0; i < 6; i++) {
								searchResults.push(searchData.data[i].name);
							}
							$("#searchBox").autocomplete({
								source: searchResults
							})
						}else{
							console.log("This card's info has been loaded.")
							var displayCard = '<div class="row">';
							// get card image
							displayCard += '<div class="col-sm-5">';
							if(searchData.data[0].image_uris){
								displayCard += "<img class='cardResultsImg' src='"+ searchData.data[0].image_uris.normal +"'>";
							}else if(searchData.data[0].card_faces){
								displayCard += "<img class='cardResultsImg' id='flipImg' flipimg='"+ searchData.data[0].card_faces[1].image_uris.normal+ "' src='"+ searchData.data[0].card_faces[0].image_uris.normal +"'>";
								displayCard += "<p style='text-align: center; font-weight: bold; margin-bottom: 20px;'>This is a flip card: Click image to see the other side</p>"
							}else{ 
								displayCard += "<img class='cardResultsImg' src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";	
							}
							displayCard += '</div><div class="col-sm-7">';
							// get card mana cost
							var manaCost = [];
							if(searchData.data[0].mana_cost){ // single-sided card
								var mana = '';
								for(var i = 0; i < searchData.data[0].mana_cost.length; i++){
									if(searchData.data[0].mana_cost[i] != "{" && searchData.data[0].mana_cost[i] != " " && searchData.data[0].mana_cost[i] != "}" && searchData.data[0].mana_cost[i] != "/"){
										console.log(searchData.data[0].mana_cost[i]);
										mana += searchData.data[0].mana_cost[i];
									}else if(searchData.data[0].mana_cost[i] == "}"){
										manaCost.push(mana);
										mana = '';
									}
								}
								console.log("manaCost:", manaCost);
								for(var i = 0; i < manaCost.length; i++){
									displayCard += "<img class='manaImg' src='/img/"+manaCost[i]+".png'>"
								}
							}else if(searchData.data[0].card_faces){ // double-sided card
								var mana = '';
								for(var i = 0; i < searchData.data[0].card_faces[0].mana_cost.length; i++){
									if(searchData.data[0].card_faces[0].mana_cost[i] != "{" && searchData.data[0].card_faces[0].mana_cost[i] != " " && searchData.data[0].card_faces[0].mana_cost[i] != "}" && searchData.data[0].card_faces[0].mana_cost[i] != "/"){
										console.log(searchData.data[0].card_faces[0].mana_cost[i]);
										mana += searchData.data[0].card_faces[0].mana_cost[i];
									}else if(searchData.data[0].card_faces[0].mana_cost[i] == "}"){
										manaCost.push(mana);
										mana = '';
									}
								}
								console.log("manaCost:", manaCost);
								for(var i = 0; i < manaCost.length; i++){
									displayCard += "<img class='manaImg' src='/img/"+manaCost[i]+".png'>"
								}
							}else{ 
								displayCard += "<p>No mana cost</p>";	
							}
							// get card type
							displayCard += "<p style='font-weight: bold'>"+searchData.data[0].type_line+"</p>";
							// get card text (single-sided card)
							if(searchData.data[0].oracle_text && searchData.data[0].flavor_text){ // single-sided cards
								displayCard += "<p><span style='font-weight: bold'>Oracle Text:</span> "+searchData.data[0].oracle_text+"</p>";
								displayCard += "<p><span style='font-weight: bold'>Flavor Text:</span> "+searchData.data[0].flavor_text+"</p>";
							}else if(searchData.data[0].oracle_text && !searchData.data[0].flavor_text){
								displayCard += "<p><span style='font-weight: bold'>Oracle Text:</span> "+searchData.data[0].oracle_text+"</p>";
							}else if(!searchData.data[0].oracle_text && searchData.data[0].flavor_text){
								displayCard += "<p><span style='font-weight: bold'>Flavor Text:</span> "+searchData.data[0].flavor_text+"</p>";
							}
							// get card power & toughness (single-sided card)
							if(searchData.data[0].power && searchData.data[0].toughness){
								displayCard += "<p><span style='font-weight: bold'>Power/Toughness:</span> "+searchData.data[0].power+"/"+searchData.data[0].toughness+"</p>";
							}
							// get card text (double-sided card)
							if(searchData.data[0].card_faces){ // double-sided cards
								for(var i = 0; i < searchData.data[0].card_faces.length; i++){
									var side;
									if(i == 0){
										side = "Front";
									}else{
										side = "Back";
									}
									if(searchData.data[0].card_faces[i].oracle_text && searchData.data[0].card_faces[i].flavor_text){
										displayCard += "<p><span style='font-weight: bold'>Oracle Text ("+side+" Side):</span> "+searchData.data[0].card_faces[i].oracle_text+"</p>";
										displayCard += "<p><span style='font-weight: bold'>Flavor Text ("+side+" Side):</span> "+searchData.data[0].card_faces[i].flavor_text+"</p>";
									}else if(searchData.data[0].card_faces[i].oracle_text && !searchData.data[0].card_faces[i].flavor_text){
										displayCard += "<p><span style='font-weight: bold'>Oracle Text ("+side+" Side):</span> "+searchData.data[0].card_faces[i].oracle_text+"</p>";
									}else if(!searchData.data[0].card_faces[i].oracle_text && searchData.data[0].card_faces[i].flavor_text){
										displayCard += "<p><span style='font-weight: bold'>Flavor Text ("+side+" Side):</span> "+searchData.data[0].card_faces[i].flavor_text+"</p>";
									}
									// get card power & toughness (double-sided card)
									if(searchData.data[0].card_faces[i].power && searchData.data[0].card_faces[i].toughness){
										displayCard += "<p><span style='font-weight: bold'>Power/Toughness ("+side+" Side):</span> "+searchData.data[0].card_faces[i].power+"/"+searchData.data[0].card_faces[i].toughness+"</p>";
									}
								}
							}
							displayCard += "</div></div>";
							$("#cardResults").html(displayCard);
						}
					}
				)
			}
			
			makeApiRequest(searchQuery, false);
			
			// if two-sided card, show backside image when clicked
			$(document).on('click', '#flipImg', function(){
				var flipimg = $('#flipImg').attr('flipimg');
				console.log(flipimg);
				var temp = $('#flipImg').attr('src');
				console.log(temp);
				$('#flipImg').attr('flipimg', temp);
				$('#flipImg').attr('src', flipimg);
			})
			
			// show card star ratings
			var avgRating = $("#starRating").attr("avgRating");
			console.log("avgRating", avgRating);
			if(avgRating != null){
				if(avgRating < 1.25){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_1_star.png'>");
				}else if(avgRating < 1.75){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_1_and_a_half_stars.png'>");
				}else if(avgRating < 2.25){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_2_stars.png'>");
				}else if(avgRating < 2.75){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_2_and_a_half_stars.png'>");
				}else if(avgRating < 3.25){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_3_stars.png'>");
				}else if(avgRating < 3.75){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_3_and_a_half_stars.png'>");
				}else if(avgRating < 4.25){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_4_stars.png'>");
				}else if(avgRating < 4.75){
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_4_and_a_half_stars.png'>");
				}else{
					$("#starRating").html("<img id='starImg' src='/img/5_Star_Rating_System_5_stars.png'>");
				}
			}
			
			// search box autofill
			
			$("#searchBox").keyup(function(){
				searchResults = [];
				var searchField = $("#searchBox").val();
				if(searchField.length > 2) {
					makeApiRequest(searchField, true);	
				}
			})
			
			// review box character count
			$("#review").keyup(function(){
				var charCount = $("#review").val().length;
				console.log(charCount);
				if(charCount < 20){
					$("#charCount").text("Review too short: " + Math.abs(charCount-20) + " characters remaining.");
				}else{
					$("#charCount").text("");
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
	<title><c:out value="${cardName}"/></title>
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
					<input type="text" name="q" value="<c:out value="${cardName}"/>" id="searchBox">
					<input class="btn btn-primary btn-sm" type="submit" value="Search">
				</form>
				<hr>
				<h1><c:out value="${cardName}"/></h1>
				<c:if test="${reviews.size() != 0 && reviews != null}">
					<div id="starRating" class="d-inline-block addRightMargin" avgRating="${avgRating}"></div>
					<c:if test="${ratingCount > 0}">
						<c:if test="${ratingCount == 1 }">
							<div class="d-inline-block" id="starRatingCount"><p><c:out value="${ratingCount}"/> review</p></div>
						</c:if>
						<c:if test="${ratingCount != 1 }">
							<div class="d-inline-block" id="starRatingCount"><p><c:out value="${ratingCount}"/> reviews</p></div>
						</c:if>
					</c:if>
				</c:if>
				<div id="cardResults"></div>
				<hr>
				<div class="row">
					<div class="col-sm-4" id="addReviewBox">
						<h2>Add A Review:</h2>
						<c:choose>
							<c:when test="${user != null}">
								<p>Your review must be at least 20 characters long.</p>
								<form:form method="POST" action="/card?name=${cardName}" modelAttribute="thisReview">
									<c:if test="${error != null}"><p class="error"><c:out value="${error}"/></p></c:if>
							    		<div class="form-group">
							    			<form:label path="rating">Rating: </form:label>
									    	<form:select class="form-control" path="rating">
									    		<form:option value="1">1 star</form:option>
									    		<form:option value="2">2 stars</form:option>
									    		<form:option value="3">3 stars </form:option>
									    		<form:option value="4">4 stars</form:option>
									    		<form:option value="5">5 stars</form:option>
									    	</form:select>
								    	</div>
								    	<div class="form-group">
							    			<form:input class="textInputBox form-control" path="title" placeholder="Review Title"/>
							    		</div>
							    		<div class="form-group">
								    		<form:textarea class="form-control" path="review" placeholder="Write your review..."/>
								    		<p style="font-size: 12px" id="charCount"></p>
							    		</div>
							        <input class="btn btn-primary" type="submit" value="Add Review"/>
							    </form:form>
							</c:when>
							<c:otherwise>
								<p>If you would like to write a review of this card, you need to <a href="/login">login</a> or <a href="/registration">register</a>.</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-sm-8">
						<c:choose>
							<c:when test="${reviews.size() != 0 && reviews != null}">
								<h3>Recent Reviews of <c:out value="${cardName }"/>:</h3>
								<c:forEach items="${reviews}" var="review">
									<div class="well">
										<p><fmt:formatDate value="${review[5]}" pattern="MMMMMMMMMM dd, yyyy"/></p>
										<h3><c:out value="${review[2]}"/></h3>
										<c:if test="${review[1] == 1}">
											<img class="starsGiven starsGivenReview" src="/img/5_Star_Rating_System_1_star.png">
										</c:if>
										<c:if test="${review[1] == 2}">
											<img class="starsGiven starsGivenReview" src="/img/5_Star_Rating_System_2_stars.png">
										</c:if>
										<c:if test="${review[1] == 3}">
											<img class="starsGiven starsGivenReview" src="/img/5_Star_Rating_System_3_stars.png">
										</c:if>
										<c:if test="${review[1] == 4}">
											<img class="starsGiven starsGivenReview" src="/img/5_Star_Rating_System_4_stars.png">
										</c:if>
										<c:if test="${review[1] == 5}">
											<img class="starsGiven starsGivenReview" src="/img/5_Star_Rating_System_5_stars.png">
										</c:if>
										<p><c:out value="${review[3]}"/></p>
										<p><span style="font-weight: bold">Review by:</span> <c:out value="${review[7]}"></c:out></p>
										<p><c:if test="${review[6] == user.id || user.user_level == 9}"><a href="/review/delete/<c:out value="${review[0]}"/>"><button class="btn btn-danger btn-xs">Delete Review</button></a></c:if><c:if test="${review[6] == user.id}"> <a href="/review/edit/<c:out value="${review[0]}"/>"><button class="btn btn-primary btn-xs">Edit Review</button></a></</c:if></p>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h2>Recent Reviews:</h2>
								<p>This card doesn't have any reviews yet.</p>
								<p style="font-weight: bold">Be the first to review <c:out value="${cardName }"></c:out> and add 10 points to your score!</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
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