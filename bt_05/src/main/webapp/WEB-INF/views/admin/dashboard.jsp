<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
	<title>Dashboard</title>
</head>
<body>
	<div class="row">
		<div class="col-md-6 mb-3">
			<div class="info-box shadow-sm">
				<span class="info-box-icon text-bg-primary"><i class="bi bi-tags-fill"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">Category management</span>
					<a href="${pageContext.request.contextPath}/admin/categories" class="text-decoration-none">
						Open categories <i class="bi bi-arrow-right"></i>
					</a>
				</div>
			</div>
		</div>
		<div class="col-md-6 mb-3">
			<div class="info-box shadow-sm">
				<span class="info-box-icon text-bg-success"><i class="bi bi-people-fill"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">User management</span>
					<a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none">
						Open users <i class="bi bi-arrow-right"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
