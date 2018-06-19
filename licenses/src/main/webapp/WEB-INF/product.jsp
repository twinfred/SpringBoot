<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><c:out value="${product.name}"/></title>
</head>
<body>
	<h1><c:out value="${product.name}"/></h1>
	<table>
		<tr>
			<td>
				<h3>Categories:</h3>
				<ul>
					<c:forEach items="${product.categories}" var="category">
						<li>${category.name}</li>
					</c:forEach>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
				<form action="/products/addcat/${product.id}" method="post">
					<table>
						<tr>
							<td>Add Category:</td>
							<td>
								<select name="category_id">
									<c:forEach items="${categories}" var="category">
										<option value="${category.id}" label="${category.name}"></option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" value="Add"></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
</body>
</html>