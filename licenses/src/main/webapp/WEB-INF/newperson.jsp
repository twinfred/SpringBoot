<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add a Person</title>
</head>
<body>
	<h1>New Person</h1>
	<form:form action="/persons/new" method="post" modelAttribute="person">
		<table>
			<tr>
				<td><form:label path="fname">First Name</form:label></td>
				<td><form:input path="fname"/></td>
				<td><form:errors path="fname"/></td>
			</tr>
			<tr>
				<td><form:label path="lname">Last Name</form:label></td>
				<td><form:input path="lname"/></td>
				<td><form:errors path="lname"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Submit"/></td>
			</tr>
		</table>
	</form:form>
</body>
</html>