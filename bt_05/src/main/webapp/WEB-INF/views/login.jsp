<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Admin Login</title>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
		crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminlte.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shopbanhang-admin.css">
</head>
<body class="login-page bg-body-secondary">
	<main class="login-box">
		<h1 class="login-logo">
			<a href="${pageContext.request.contextPath}/login"><b>ShopBanHang</b> Admin</a>
		</h1>
		<div class="card card-outline card-primary shadow">
			<div class="card-body login-card-body">
				<p class="login-box-msg">Sign in to manage the store</p>

				<c:if test="${param.error != null}">
					<div class="alert alert-danger" role="alert">
						<i class="bi bi-exclamation-triangle-fill me-2"></i>Invalid username or password.
					</div>
				</c:if>
				<c:if test="${param.logout != null}">
					<div class="alert alert-success" role="alert">
						<i class="bi bi-check-circle-fill me-2"></i>You have been logged out.
					</div>
				</c:if>

				<form method="post" action="${pageContext.request.contextPath}/login">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<label class="visually-hidden" for="username">Username</label>
					<div class="input-group mb-3">
						<input id="username" name="username" type="text" class="form-control"
							placeholder="Username" autocomplete="username" required autofocus>
						<div class="input-group-text"><span class="bi bi-person-fill"></span></div>
					</div>

					<label class="visually-hidden" for="password">Password</label>
					<div class="input-group mb-3">
						<input id="password" name="password" type="password" class="form-control"
							placeholder="Password" autocomplete="current-password" required>
						<div class="input-group-text"><span class="bi bi-lock-fill"></span></div>
					</div>

					<div class="d-grid">
						<button type="submit" class="btn btn-primary">
							<i class="bi bi-box-arrow-in-right me-1"></i>Sign In
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminlte.js"></script>
</body>
</html>
