<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>New Question</title>
</head>
<body>
	<h1>What's your question?</h1>
	<form action="/questions/new" method="post">
		<table>
			<tr>
				<td>Question: </td>
				<td><textarea name="question"></textarea></td>
			</tr>
			<tr>
				<td>Tags: </td>
				<td><input type="text" name="tags"></td>
			</tr>
			<tr>
				<td></td>
				<td>Separate tags with a comma. Limited to three.</td>
			</tr>
		</table>
		<input type="submit" value="Submit">
	</form>
</body>
</html>