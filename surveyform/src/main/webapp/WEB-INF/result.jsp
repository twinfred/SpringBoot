<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Survey Answers</title>
</head>
<body>
	<h2>Submitted Info</h2>
	<table>
		<tr>
			<td>Name: </td>
			<td><c:out value="${name}" /></td>
		</tr>
		<tr>
			<td>Dojo Location: </td>
			<td><c:out value="${location}" /></td>
		</tr>
		<tr>
			<td>Favorite Language: </td>
			<td><c:out value="${language}" /></td>
		</tr>
		<tr>
			<td>Comment: </td>
			<td><c:out value="${comment}" /></td>
		</tr>
	</table>
</body>
</html>