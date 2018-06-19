<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add a Product</title>
</head>
<body>
	<h1>New Product</h1>
	<form:form action="/products/new" method="post" modelAttribute="product">
		<table>
			<tr>
				<td><form:label path="name">Name:</form:label></td>
				<td><form:input path="name"/></td>
				<td><form:errors path="name"/></td>
			</tr>
			<tr>
				<td><form:label path="description">Description:</form:label></td>
				<td><form:input path="description"/></td>
				<td><form:errors path="description"/></td>
			</tr>
			<tr>
				<td><form:label path="price">Price:</form:label></td>
				<td><form:input type="number" step='0.01' path="price"/></td>
				<td><form:errors path="price"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Create"/></td>
			</tr>
		</table>
	</form:form>
</body>
</html>