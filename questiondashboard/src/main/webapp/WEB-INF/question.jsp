<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><c:out value="${question.question}" /></title>
</head>
<body>
	<h1><c:out value="${question.question}" /></h1>
	<h4>Tags:</h4>
	<ul>
		<c:forEach items="${tags}" var="tag">
			<li><c:out value="${tag.name}"/></li>
		</c:forEach>
	</ul>
	<h3>Answers:</h3>
	<ul>
		<c:forEach items="${answers}" var="answer">
			<li><c:out value="${answer.answer}"/>
		</c:forEach>
	</ul>
	<h3>Add Your Answer:</h3>
	<form action="/questions/answer/${question.id}" method="post">
		<table>
			<tr>
				<td>
					<textarea name="answer"/></textarea>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="Add Answer"></td>
			</tr>
		</table>
	</form>
</body>
</html>