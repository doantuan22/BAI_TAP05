<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!doctype html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ShopBanHang Admin - <sitemesh:write property="title"/></title>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/styles/overlayscrollbars.min.css"
		crossorigin="anonymous">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
		crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminlte.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shopbanhang-admin.css">
	<sitemesh:write property="head"/>
</head>
<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
	<div class="app-wrapper">
		<nav class="app-header navbar navbar-expand bg-body">
			<div class="container-fluid">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link" data-lte-toggle="sidebar" href="#" role="button" aria-label="Toggle sidebar">
							<i class="bi bi-list"></i>
						</a>
					</li>
					<li class="nav-item d-none d-md-block">
						<a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a>
					</li>
				</ul>
				<ul class="navbar-nav ms-auto align-items-center">
					<li class="nav-item d-none d-sm-block">
						<span class="nav-link text-body-secondary">
							<i class="bi bi-person-circle me-1"></i>${pageContext.request.userPrincipal.name}
						</span>
					</li>
					<li class="nav-item">
						<form method="post" action="${pageContext.request.contextPath}/logout" class="m-0">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<button type="submit" class="btn btn-outline-danger btn-sm">
								<i class="bi bi-box-arrow-right me-1"></i>Log out
							</button>
						</form>
					</li>
				</ul>
			</div>
		</nav>

		<aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
			<div class="sidebar-brand">
				<a href="${pageContext.request.contextPath}/admin/dashboard" class="brand-link">
					<i class="brand-image bi bi-bag-check-fill fs-4 opacity-75"></i>
					<span class="brand-text fw-light">ShopBanHang</span>
				</a>
			</div>
			<div class="sidebar-wrapper">
				<nav class="mt-2" aria-label="Admin navigation">
					<ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" data-accordion="false">
						<li class="nav-item">
							<a href="${pageContext.request.contextPath}/admin/categories"
								class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/categories') ? 'active' : ''}">
								<i class="nav-icon bi bi-tags-fill"></i>
								<p>Category</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${pageContext.request.contextPath}/admin/users"
								class="nav-link ${fn:contains(pageContext.request.requestURI, '/admin/users') ? 'active' : ''}">
								<i class="nav-icon bi bi-people-fill"></i>
								<p>User</p>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</aside>

		<main class="app-main">
			<div class="app-content-header">
				<div class="container-fluid">
					<h1 class="mb-0 fs-3"><sitemesh:write property="title"/></h1>
				</div>
			</div>
			<div class="app-content">
				<div class="container-fluid">
					<sitemesh:write property="body"/>
				</div>
			</div>
		</main>

		<footer class="app-footer">
			<div class="float-end d-none d-sm-inline">Administration</div>
			<strong>&copy; ShopBanHang.</strong> All rights reserved.
		</footer>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminlte.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			const sidebarWrapper = document.querySelector('.sidebar-wrapper');
			const overlayScrollbars = window.OverlayScrollbarsGlobal?.OverlayScrollbars;
			if (sidebarWrapper && overlayScrollbars && window.innerWidth > 992) {
				overlayScrollbars(sidebarWrapper, {
					scrollbars: { theme: 'os-theme-light', autoHide: 'leave', clickScroll: true }
				});
			}
		});
	</script>
</body>
</html>
