<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Top <c:out value="${number}"/> Scores</title>
</head>
<body>
	<h1>Top <c:out value="${number}"/> Scores</h1>
	<p>Search for a card to review and earn more points:</p>
	<form action="/search">
		<input type="text" name="q" id="searchBox">
		<input type="submit" value="Search">
	</form>
	<table>
		<tr>
			<th></th>
			<th>Username</th>
			<th>Score</th>
		</tr>
		<c:forEach items="${topUsers}" var="user" varStatus="loop">
			<tr>
				<td><c:out value="${loop.index +1}"/>. </td>
				<td><c:out value="${user.username}"/></td>
				<td><c:out value="${user.points}"/></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>