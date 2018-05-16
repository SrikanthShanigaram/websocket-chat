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
			<form id="usernameForm" name="usernameForm" autocomplete="off"
				action="#" th:action="@{/register}" th:object="${user}"
				method="post" class="m-t" role="form" data-toggle="validator">
				<div th:if="${confirmationMessage}" class="alert alert-success"
					role="alert" th:text=${confirmationMessage}></div>

				<div th:if="${errorMessage}" class="alert alert-danger" role="alert"
					th:text="${errorMessage}"></div>

				<div class="form-group">
					<input type="text" th:field="*{userName}"
						placeholder="Username" autocomplete="off" class="form-control" />
				</div>
				<div class="form-group">
					<input type="text" th:field="*{password}"
						placeholder="Password" autocomplete="off" class="form-control" />
				</div>
				<div class="form-group">
					<button type="submit" class="accent username-submit">Create
						Account</button>
				</div>
				<input type="text" th:field="*{userId}"
						autocomplete="off" />
				<input type="text" th:field="*{role}"
						autocomplete="off" />
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>
</body>
</html>