<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Welcome</title>
</head>
<body>
	<h2>Register</h2>
    
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
    	<table>
    		<tr>
    			<td><form:input path="fname" placeholder="First Name"/></td>
    		</tr>
    		<tr>
    			<td><form:input path="lname" placeholder="Last Name"/></td>
    		</tr>
    		<tr>
    			<td><form:input type="email" path="email" placeholder="Email"/></td>
    		</tr>
    		<tr>
    			<td><form:input path="city" placeholder="City"/></td>
    		</tr>
    		<tr>
    			<td>
    				<form:select path="state">
    					<form:option value="" label="State"></form:option>
    					<c:forEach items="${states}" var="state">
    						<form:option value="${state}" label="${state}"></form:option>
    					</c:forEach>
    				</form:select>
    			</td>
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
    <h2>Login</h2>
    <p><c:out value="${error}" /></p>
    <form method="post" action="/login">
        <table>
        	<tr>
        		<td><input type="text" name="email" placeholder="Email"/></td>
        	</tr>
            <tr>
            	<td><input type="password" name="password" placeholder="Password"/></td>
            </tr>
            
        </table>
        <input type="submit" value="Login"/>
    </form>  
</body>
</html>