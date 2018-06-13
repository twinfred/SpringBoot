<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book <c:out value="${book.title}"/></title>
</head>
<body>
	<h1><c:out value="${book.title}"/></h1>
	<h4>Description: <c:out value="${book.description}"/></h4>
	<h4>Language: <c:out value="${book.language}"/></h4>
	<h4>Number of Pages: <c:out value="${book.numberOfPages}"/></h4>
	<a href='/books/<c:out value="${book.id}"/>/delete'><button>Delete</button></a>
</body>
</html>