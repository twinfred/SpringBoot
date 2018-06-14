<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><c:out value="${language.name}"/></title>
</head>
<body>
	<a href="/languages">Dashboard</a>
	<h1><c:out value="${language.name}"/></h1>
	<h4><c:out value="${language.creator}"/></h4>
	<h4><c:out value="${language.version}"/></h4>
	<a href="/languages/edit/${language.id}">Edit</a>
	<a href="/languages/delete/${language.id}">Delete</a>
</body>
</html>