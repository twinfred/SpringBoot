<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Register | Magic Reviewer</title>
</head>
<body>
	<h2>Register</h2>
    <p><form:errors path="user.*"/></p>
    <form:form method="POST" action="/registration" modelAttribute="user">
    	<table>
    		<tr>
    			<td><form:input path="username" placeholder="Username"/></td>
    		</tr>
    		<tr>
    			<td><form:input type="email" path="email" placeholder="Email"/></td>
    		</tr>
    		<tr>
    			<td><form:password path="password" placeholder="Password"/></td>
    		</tr>
    		<tr>
    			<td><form:password path="passConf" placeholder="Confirm Password"/></td>
    		</tr>
    	</table>
        <input type="submit" value="Register"/>
    </form:form>
</body>
</html>