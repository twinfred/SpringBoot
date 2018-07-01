<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121649556-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'UA-121649556-1');
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/style.css">
	<title>Admin Portal</title>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
			    	<span class="icon-bar"></span>
			    	<span class="icon-bar"></span>
			    	<span class="icon-bar"></span>                        
				</button>
				<a class="navbar-brand" href="/">Magic Reviewer</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
		    	<ul class="nav navbar-nav">
			        <li class="active"><a href="/">Home</a></li>
			        <li><a href="/leaderboard">Top Scores</a></li>
			        <li><a href="/search?q=magic">Search</a></li>
		    	</ul>
			  	<ul class="nav navbar-nav navbar-right">
			  		<li class="active"><a href="/admin">Admin</a></li>
					<li><a href="/account">My Account</a></li>
				</ul>
			</div>
		</div>
	</nav>
	  
	<div class="container-fluid text-center">    
		<div class="row content">
			<div class="col-md-7 text-left">
				<h3>Recent Reviews</h3>
				<table class="table">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Card</th>
							<th scope="col">Rating</th>
							<th scope="col">Title</th>
							<th scope="col">Review</th>
							<th scope="col"></th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allReviews}" var="review">
							<tr>
								<td><c:out value="${review.card.getName()}"/></td>
								<td><c:out value="${review.rating}"/></td>
								<td><c:out value="${review.title}"/></td>
								<td><c:out value="${review.review}"/></td>
								<td><a href="/review/delete/<c:out value="${review.id}"/>"><button class="btn btn-danger btn-xs">Delete</button></a></td>
								<td><a href="/review/edit/<c:out value="${review.id}"/>"><button class="btn btn-primary btn-xs">Edit</button></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-md-5 text-left">
				<h3>All Users</h3>
				<table class="table">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Username</th>
							<th scope="col">Email</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allUsers}" var="user">
							<tr>
								<td><c:out value="${user.username}"/></td>
								<td><c:out value="${user.email}"/></td>
								<td>
									<c:if test="${user.user_level != 9}">
										<a href="/user/delete/<c:out value="${user.id}"/>"><button class="btn btn-danger btn-xs">Delete</button></a>	
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<footer class="container-fluid text-center">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<p>The literal and graphical information presented on this site about Magic: The Gathering, including card images, the mana symbols, and Oracle text, is copyright Wizards of the Coast, LLC, a subsidiary of Hasbro, Inc. This website is not produced by, endorsed by, supported by, or affiliated with Wizards of the Coast.</p>
				<p>All other content © 2018 <a href="http://timwinfred.com" target="_blank">TimWinfred.com</a></p>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</footer>
</body>
</html>