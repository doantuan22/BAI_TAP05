<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>500 - Server error</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">
	<main class="container py-5 text-center">
		<h1 class="display-1 fw-bold">500</h1>
		<p class="lead">An unexpected error occurred. Please try again later.</p>
		<a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/dashboard">Back to dashboard</a>
	</main>
</body>
</html>
