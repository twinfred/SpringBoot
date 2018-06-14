<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Top Songs</title>
</head>
<body>
	<a href="/dashboard">Dashboard</a>
	<h1>Top 10 Songs</h1>
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