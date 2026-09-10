<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Admin Login</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">
	<main class="container py-5">
		<div class="row justify-content-center">
			<div class="col-sm-10 col-md-6 col-lg-4">
				<div class="card shadow-sm">
					<div class="card-body p-4">
						<h1 class="h3 text-center mb-4">ShopBanHang Admin</h1>
						<c:if test="${param.error != null}">
							<div class="alert alert-danger" role="alert">Invalid username or password.</div>
						</c:if>
						<c:if test="${param.logout != null}">
							<div class="alert alert-success" role="alert">You have been logged out.</div>
						</c:if>
						<form method="post" action="${pageContext.request.contextPath}/login">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<div class="mb-3">
								<label for="username" class="form-label">Username</label>
								<input id="username" name="username" type="text" class="form-control"
									autocomplete="username" required autofocus>
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Password</label>
								<input id="password" name="password" type="password" class="form-control"
									autocomplete="current-password" required>
							</div>
							<button type="submit" class="btn btn-primary w-100">Log in</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>
