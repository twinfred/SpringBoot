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
			
			var searchData;
			var searchResults = [];
			
			function makeApiRequest(thisQuery){
				searchData = {};
				$.get("https://api.scryfall.com/cards/search?order=released&q="+thisQuery, function(data) {
					searchData = data;
					console.log("Results:", data);
				}).then(
					function(){
						for(var i = 0; i < 6; i++) {
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
		})
	</script>
	<title>Magic Reviewer | Fan ratings and reviews for Magic: The Gathering cards</title>
</head>
<body>
	<c:choose>
		<c:when test = "${user != null}">
			<p>Hey there, <c:out value="${user.username}"/></p>
			<p>Your Score: <c:out value="${user.points}"/></p>
			<a href="/logout">Logout</a>
		</c:when>
		<c:otherwise>
			<p><c:out value="${error}" /></p>
		    <form method="post" action="/login">
		        <table>
		        	<tr>
		        		<td><input type="text" name="email" placeholder="Email"/></td>
		        	</tr>
		            <tr>
		            	<td><input type="password" name="password" placeholder="Password"/></td>
		            </tr>
		            
		        </table>
		        <input type="submit" value="Login"/>
		    </form>
		    <p>Don't have an account yet? <a href="/registration">Register</a></p>
		</c:otherwise>
	</c:choose>
	<form action="/search">
		<input type="text" name="q" placeholder="Search for a card's name" id="searchBox">
		<input type="submit" value="Search">
	</form>
</body>
</html>