<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ShopBanHang Admin - <sitemesh:write property="title"/></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
	<sitemesh:write property="head"/>
</head>
<body class="bg-body-tertiary d-flex flex-column min-vh-100">
	<header class="navbar navbar-dark bg-dark px-3">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">ShopBanHang Admin</a>
	</header>

	<div class="container-fluid flex-grow-1">
		<div class="row h-100">
			<aside class="col-12 col-md-3 col-lg-2 bg-white border-end p-3">
				<nav class="nav nav-pills flex-column gap-2">
					<a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Category</a>
					<a class="nav-link" href="${pageContext.request.contextPath}/admin/users">User</a>
				</nav>
			</aside>
			<main class="col-12 col-md-9 col-lg-10 p-4">
				<sitemesh:write property="body"/>
			</main>
		</div>
	</div>

	<footer class="bg-dark text-white-50 text-center py-3">
		<small>&copy; ShopBanHang Administration</small>
	</footer>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
