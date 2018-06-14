<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit <c:out value="${language.name}"/></title>
</head>
<body>
	<a href="/languages">Dashboard</a>
	<h1>Edit <c:out value="${language.name}"/></h1>
	<form:form action="/languages/${language.id}" method="post" modelAttribute="language">
	    <input type="hidden" name="_method" value="put">
	    <p>
	        <form:label path="name">Name</form:label>
	        <form:input path="name"/>
	        <form:errors path="name"/>
	    </p>
	    <p>
	        <form:label path="creator">Creator</form:label>
	        <form:textarea path="creator"/>
	        <form:errors path="creator"/>
	    </p>
	    <p>
	        <form:label path="version">Version</form:label>
	        <form:input path="version"/>
	        <form:errors path="version"/>
	    </p>  
	    <input type="submit" value="Submit"/>
	</form:form>
</body>
</html>