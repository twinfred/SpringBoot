<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Events</title>
</head>
<body>
	<a href="/logout">Logout</a>
	<h1>Welcome, <c:out value="${user.fname}" />!</h1>
	<h2>Upcoming Events in Your State:</h2>
	<table>
		<tr>
			<td>Event</td>
			<td>Date</td>
			<td>Location</td>
			<td>Host</td>
			<td>Action</td>
		</tr>
		<c:forEach items="${inState}" var="event">
		<c:set var="owner" value="false"/>
		<tr>
			<td>${event[0]}</td>
			<td><fmt:formatDate value="${event[1]}" pattern="MMMMMMMMMM dd, yyyy"/></td>
			<td>${event[2]}</td>
			<td>${event[3]}</td>
			<c:if test="${event[4] == user.id}">
				<td><a href="/events/${event[5]}/edit">Edit</a> <a href="/events/${event[5]}/delete">Delete</a></td>
				<c:set var="owner" value="true"/>
			</c:if>
			<c:if test="${!owner}">
				<c:forEach items="${rsvps}" var="rsvp">
				<c:set var="joined" value="false"/>
				<c:if test="${rsvp == event[5] }">
					<c:set var="joined" value="true"/>
				</c:if>
				<c:if test="${joined}">
					<td>Joined</td>
				</c:if>
				<c:if test="${!joined}">
					<td>Join</td>
				</c:if>
			</c:forEach>
			</c:if>
		</tr>
		</c:forEach>
	</table>
	<h2>Out of State Events:</h2>
	<table>
		<tr>
			<td>Event</td>
			<td>Date</td>
			<td>City</td>
			<td>State</td>
			<td>Host</td>
			<td>Action</td>
		</tr>
		<c:forEach items="${outState}" var="event">
		<c:set var="owner" value="false"/>
		<tr>
			<td>${event[0]}</td>
			<td><fmt:formatDate value="${event[1]}" pattern="MMMMMMMMMM dd, yyyy"/></td>
			<td>${event[2]}</td>
			<td>${event[3]}</td>
			<td>${event[4]}</td>
			<c:if test="${event[5] == user.id}">
				<c:set var="owner" value="true"/>
				<td><a href="/events/${event[6]}/edit">Edit</a> <a href="/events/${event[6]}/delete">Delete</a></td>
			</c:if>
			<c:if test="${!owner}">
				<c:forEach items="${rsvps}" var="rsvp">
					<c:set var="joined" value="false"/>
					<c:if test="${rsvp == event[6] }">
						<c:set var="joined" value="true"/>
					</c:if>
					<c:if test="${joined}">
						<td>Joined</td>
					</c:if>
					<c:if test="${!joined}">
						<td>Join</td>
					</c:if>
				</c:forEach>
			</c:if>
		</tr>
		</c:forEach>
	</table>
	<h2>Events:</h2>
	<p><form:errors path="event.*"/>
	<form:form method="POST" action="/events" modelAttribute="event">
		<table>
			<tr>
				<td><form:label path="name">Event Name: </form:label></td>
				<td><form:input path="name"></form:input></td>
			</tr>
			<tr>
				<td><form:label path="date">Event Date: </form:label></td>
				<td><form:input path="date" placeholder="MM/DD/YYYY"></form:input></td>
			</tr>
			<tr>
				<td><form:label path="name">Event City: </form:label></td>
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
    			<td><form:label path="city">Event City: </form:label></td>
	    		<td><form:input path="city"/></td>
	    	</tr>
		</table>
		<input type="submit" value="Add Event"/>
	</form:form>
</body>
</html>