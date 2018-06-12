<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Survey</title>
</head>
<body>
	<form action="/submit" method="POST">
		<table>
			<tr>
				<td>Your Name: </td>
				<td><input type="text" name="name" placeholder="Tim"></td>
			</tr>
			<tr>
				<td>Dojo Location: </td>
				<td>
					<select name="location">
						<option value="Burbank">Burbank</option>
						<option value="San Jose">San Jose</option>
						<option value="Chicago">Chicago</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Favorite Language: </td>
				<td>
					<select name="language">
						<option value="Java">Java</option>
						<option value="Python">Python</option>
						<option value="JavaScript">JavaScript</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Comment (optional):</td>
			</tr>
		</table>
		<textarea name="comment" placeholder="I love the dojo!"></textarea>
		<input type="submit" value="Submit">
	</form>
</body>
</html>