<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Books</title>
</head>
<body>
	<h1>All Books</h1>
	<table>
    	<thead>
        	<tr>
            	<th>Title</th>
            	<th>Description</th>
            	<th>Language</th>
            	<th>Number of Pages</th>
        	</tr>
    	</thead>
    	<tbody>
        	<c:forEach items="${books}" var="book">
        	<tr>
            	<td><a href="/books/${book.id}">${book.title}</a></td>
            	<td><c:out value="${book.description}"/></td>
            	<td><c:out value="${book.language}"/></td>
            	<td><c:out value="${book.numberOfPages}"/></td>
        	</tr>
        	</c:forEach>
    	</tbody>
	</table>
	<a href="/books/new"><button>New Book</button></a>
</body>
</html>