<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			// review character count
			$("#review").keyup(function(){
				var charCount = $("#review").val().length;
				console.log(charCount);
				if(charCount < 20){
					$("#charCount").text("Review too short: " + Math.abs(charCount-20) + " characters remaining.");
				}else{
					$("#charCount").text("");
				}
			})
		})
	</script>
	<title>Edit your review for <c:out value="${cardName}"/></title>
</head>
<body>
	<h2>Update your review for <c:out value="${cardName}"/></h2>
	<p>Reminder: Reviews require a title and the review should be at least 20 characters long.</p>
	<p><form:errors path="review.*"/></p>
    <form:form method="post" action="/review/edit/${thisReview.id}" modelAttribute="thisReview">
    <c:if test="${error != null}"><p class="error"><c:out value="${error}"/></p></c:if>
    	<table>
    		<tr>
    			<td><form:label path="rating"/>Rating: </td>
    			<td>
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
    			<td><form:label path="title"/>Title: </td>
    			<td><form:input path="title"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="review"/>Review: </td>
    			<td><form:textarea path="review"/></td>
    		</tr>
    		<tr>
    			<td></td>
    			<td id="charCount"></td>
    		</tr>
    	</table>
        <input type="submit" value="Update"/>
    </form:form>
</body>
</html>