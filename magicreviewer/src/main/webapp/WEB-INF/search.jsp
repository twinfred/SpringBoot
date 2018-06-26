<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
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
							var cardUrlName = searchData.data[i].name;
							console.log(cardUrlName);
							while(cardUrlName.indexOf("'") > -1){
								var apsIdx = cardUrlName.indexOf("'");
								console.log(apsIdx);
								var newName = cardUrlName.slice(0, apsIdx) + "%27" + cardUrlName.slice(apsIdx+1);
								cardUrlName = newName;
								console.log(cardUrlName);
							}
							searchResults += "<a href='/card?name=" + cardUrlName + "'>"
							if(searchData.data[i].image_uris){
								searchResults += "<img style='width: 200px' src='"+searchData.data[i].image_uris.art_crop+"'>";
							}else if(searchData.data[i].card_faces){
								searchResults += "<img style='width: 200px' src='"+searchData.data[i].card_faces[0].image_uris.art_crop+"'>";
							}else{
								searchResults += "<img style='width: 200px' src='https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png'>";
							}
							searchResults += "</a><h3><a href='/card?name=" + cardUrlName + "'>" + searchData.data[i].name + "</h3></a>";
							if(searchData.data[i].flavor_text){
								var flavorText = searchData.data[i].flavor_text;
								if(searchData.data[i].flavor_text.length > 100) {
									flavorText = searchData.data[i].flavor_text.slice(0, 100);
									flavorText += "...";
								}
								searchResults += "<p>" + flavorText + "</p>";
							}else if(searchData.data[i].oracle_text){
								var oracleText = searchData.data[i].oracle_text;
								if(searchData.data[i].oracle_text.length > 100) {
									oracleText = searchData.data[i].oracle_text.slice(0, 100);
									oracleText += "...";
								}
								searchResults += "<p>" + oracleText + "</p>";
							}else if(searchData.data[i].type_line){
								var typeText = searchData.data[i].type_line;
								if(searchData.data[i].type_line.length > 100) {
									typeText = searchData.data[i].type_line.slice(0, 100);
									typeText += "...";
								}
								searchResults += "<p>" + typeText + "</p>";
							}
						}
						$("#searchResults").html('<h2>' + searchData.total_cards + ' search results for "' + thisQuery + '"</h2>' + searchResults)
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
		})
	</script>
	<title>Results for "<c:out value="${searchQuery}"/>" | Magic Reviewer Search</title>
</head>
<body>
	<form action="/search">
		<input type="text" name="q" value="<c:out value="${searchQuery}"/>" id="searchBox">
		<input type="submit" value="Search">
	</form>
	<div id="searchResults"></div>
</body>
</html>