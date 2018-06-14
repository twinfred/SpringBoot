<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Song</title>
</head>
<body>
	<a href="/dashboard">Dashboard</a>
	<h3>Add Song</h3>
	<form:form action="/add_song" method="post" modelAttribute="song">
	    <p>
	        <form:label path="title">Title</form:label>
	        <form:input path="title"/>
	        <form:errors path="title"/>
	    </p>
	    <p>
	        <form:label path="artist">Artist</form:label>
	        <form:input path="artist"/>
	        <form:errors path="artist"/>
	    </p>
	    <p>
	        <form:label path="rating">Rating</form:label>
	        <form:input type="number" value="1" min="1" max="10" path="rating"/>
	        <form:errors path="rating"/>
	    </p>  
	    <input type="submit" value="Submit"/>
	</form:form>
</body>
</html>