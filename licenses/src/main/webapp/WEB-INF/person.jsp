<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Profile Page</title>
</head>
<body>
	<h1>${person.fname} ${person.lname}</h1>
	<h4>License Number: ${person.getLicense().number}</h4>
	<h4>State: ${person.getLicense().state}</h4>
	<h4>Expiration Date: ${person.license.expiration_date}</h4>
</body>
</html>