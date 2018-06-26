<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
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
							var displayCard = '';
							// get card image
							if(searchData.data[0].image_uris){
								displayCard += "<img src='"+ searchData.data[0].image_uris.normal +"'>";
							}else if(searchData.data[0].card_faces){
								displayCard += "<img src='"+ searchData.data[0].card_faces[0].image_uris.normal +"'><img src='"+ searchData.data[0].card_faces[1].image_uris.normal +"'>";
							}else{ 
								displayCard += "<img src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";	
							}
							// get card name
							displayCard += "<h1>" + searchData.data[0].name + "</h1>";
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
									displayCard += "<img id='manaImg' src='/img/"+manaCost[i]+".png'>"
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
									displayCard += "<img style='width: 25px' src='/img/"+manaCost[i]+".png'>"
								}
							}else{ 
								displayCard += "<p>No mana cost</p>";	
							}
							// get card type
							displayCard += "<p>"+searchData.data[0].type_line+"</p>";
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
							$("#cardResults").html(displayCard);
						}
					}
				)
			}
			
			makeApiRequest(searchQuery, false);
			
			// show card star ratings
			var avgRating = $("#avgRating").attr("avgRating");
			console.log("avgRating", avgRating);
			if(avgRating){
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
				var searchField = $("#searchBox").attr('avgRating');
				if(searchField.length > 2) {
					makeApiRequest(searchField, true);	
				}
			})
		})
	</script>
	<title><c:out value="${cardName}"/></title>
</head>
<body>
	<form action="/search">
		<input type="text" name="q" value="<c:out value="${cardName}"/>" id="searchBox">
		<input type="submit" value="Search">
	</form>
	<div id="cardResults"></div>
	<h2>Add A Review:</h2>
	<c:choose>
		<c:when test="${user != null}">
			<p><form:errors path="review.*"/></p>
			<form:form method="POST" action="/review?cardName=${cardName}" modelAttribute="thisReview">
		    	<table>
		    		<tr>
		    			<td>
		    				<form:label path="rating">Rating: </form:label>
			    			<form:select path="rating">
			    				<form:option value="1">1 star</form:option>
			    				<form:option value="2">2 stars</form:option>
			    				<form:option value="3">3 stars </form:option>
			    				<form:option value="4">4 stars</form:option>
			    				<form:option value="5">5 stars</form:option>
			    			</form:select>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td><form:input path="title" placeholder="Review Title"/></td>
		    		</tr>
		    		<tr>
		    			<td><form:textarea path="review" placeholder="Write your review..."/></td>
		    		</tr>
		    	</table>
		        <input type="submit" value="Add Review"/>
		    </form:form>
		</c:when>
		<c:otherwise>
			<p>If you would like to write a review of this card, you need to <a href="/">login</a> or <a href="/registration">register</a>.</p>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${reviews != null}">
			<h2 id="avgRating" avgRating="${avgRating}">Card Rating:</h2>
			<div id="starRating"></div>
			<c:if test="${ratingCount > 0}">
				<c:if test="${ratingCount == 1 }">
					<div id="starRatingCount"><p><c:out value="${ratingCount}"/> review</p></div>
				</c:if>
				<c:if test="${ratingCount != 1 }">
					<div id="starRatingCount"><p><c:out value="${ratingCount}"/> reviews</p></div>
				</c:if>
			</c:if>
			<h2>Recent Reviews:</h2>
			<c:forEach items="${reviews}" var="review">
				<h3><c:out value="${review[2]}"/></h3>
				<p><fmt:formatDate value="${review[5]}" pattern="MMMMMMMMMM dd, yyyy"/></p>
				<p><span style="font-weight: bold">Rating:</span></p>
				<c:if test="${review[1] == 1}">
					<img class="starsGiven" src="/img/5_Star_Rating_System_1_star.png">
				</c:if>
				<c:if test="${review[1] == 2}">
					<img class="starsGiven" src="/img/5_Star_Rating_System_2_stars.png">
				</c:if>
				<c:if test="${review[1] == 3}">
					<img class="starsGiven" src="/img/5_Star_Rating_System_3_stars.png">
				</c:if>
				<c:if test="${review[1] == 4}">
					<img class="starsGiven" src="/img/5_Star_Rating_System_4_stars.png">
				</c:if>
				<c:if test="${review[1] == 5}">
					<img class="starsGiven" src="/img/5_Star_Rating_System_5_stars.png">
				</c:if>
				<p><c:out value="${review[3]}"/></p>
				<p><span style="font-weight: bold">Review by:</span> <c:out value="${review[7]}"></c:out></p>
				<p><c:if test="${review[6] == user.id || user.user_level == 9}"><a href="/review/delete/<c:out value="${review[0]}"/>"><button>Delete Review</button></a></c:if><c:if test="${review[6] == user.id}"> <a href="/review/edit/<c:out value="${review[0]}"/>"><button>Edit Review</button></a></</c:if></p>
				<hr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<h2>Recent Reviews:</h2>
			<p>This card doesn't have any reviews yet. <span style="font-weight: bold">Be the first to review <c:out value="${cardName }"></c:out> and get 10 points!</span></p>
		</c:otherwise>
	</c:choose>
</body>
</html>