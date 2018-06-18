<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a License</title>
</head>
<body>
	<h1>New License</h1>
	<form:form action="/licenses/new" method="post" modelAttribute="license">
		<table>
			<tr>
				<td><form:label path="person">Person</form:label></td>
				<td>
					<form:select path="person">
						<c:forEach items="${people}" var="person">
							<form:option value="${person}" label="${person.fname} ${person.lname}"></form:option>
						</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr>
				<td><form:label path="state">State</form:label></td>
				<td><form:input path="state"/></td>
				<td><form:errors path="state"/></td>
			</tr>
			<tr>
				<td><form:label path="expiration_date">Exp Date</form:label></td>
				<td><form:input path="expiration_date"/></td>
				<td><form:errors path="expiration_date"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Submit"/></td>
			</tr>
		</table>
	</form:form>
</body>
</html>