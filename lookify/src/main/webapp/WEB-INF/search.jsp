<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
</head>
<body>
	<a href="/dashboard">Dashboard</a>
	<h1>Songs by <c:out value="${artist}"/></h1>
	<form action="/search" method="POST">
		<table>
			<tr>
				<td><input type="text" name="artist" placeholder="Search for an artist"></td>
				<td><input type="submit" value="Search Artists"></td>
			</tr>
		</table>
	</form>
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Rating</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${songs}" var="song">
			<tr>
	            <td><a href="/songs/${song.id}">${song.title}</a></td>
	            <td><c:out value="${song.rating}"/></td>
	            <td><a href="/songs/delete/${song.id}">Delete</a></td>
        	</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>