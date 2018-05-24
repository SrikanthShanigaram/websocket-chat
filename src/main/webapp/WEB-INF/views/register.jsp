<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<title>Spring Boot WebSocket Chat Application</title>
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	<noscript>
		<h2>Sorry! Your browser doesn't support Javascript</h2>
	</noscript>

	<div id="username-page">
		<div class="username-page-container">
			<h1 class="title">Type your username</h1>
			<form id="usernameForm" name="usernameForm" action="/register"
				method="post">
				<div class="form-group">
					<input type="text" name="userName"
						placeholder="Username" autocomplete="off" class="form-control" />
				</div>
				<div class="form-group">
					<input type="text" name="password"
						placeholder="Password" autocomplete="off" class="form-control" />
				</div>
				<c:if test="${not empty alreadyRegisteredMessage}">
    				<div class="alert">
  						<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  						${alreadyRegisteredMessage}
					</div>
				</c:if>
				<c:if test="${not empty confirmationMessage}">
    				<div class="success">
  						<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  						<strong>Success!</strong> ${confirmationMessage}
					</div>
				</c:if>
				<div class="form-group">
					<button type="submit" class="accent username-submit">Create
						Account</button>
					<a href="/login">Login</a>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>
</body>
</html>