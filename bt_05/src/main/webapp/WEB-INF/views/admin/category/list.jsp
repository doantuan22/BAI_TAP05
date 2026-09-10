<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<title>Categories</title>
</head>
<body>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h1 class="h3 mb-0">Categories</h1>
		<div class="d-flex gap-2">
			<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/categories/new">Add Category</a>
			<form method="post" action="${pageContext.request.contextPath}/logout">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<button type="submit" class="btn btn-outline-danger">Log out</button>
			</form>
		</div>
	</div>

	<c:if test="${not empty message}">
		<div class="alert alert-success" role="alert"><c:out value="${message}"/></div>
	</c:if>
	<c:if test="${not empty errorMessage}">
		<div class="alert alert-danger" role="alert"><c:out value="${errorMessage}"/></div>
	</c:if>

	<form method="get" action="${pageContext.request.contextPath}/admin/categories" class="row g-2 mb-3">
		<div class="col-sm-8 col-md-5">
			<label for="categoryKeyword" class="visually-hidden">Search by category name</label>
			<input id="categoryKeyword" class="form-control" type="search" name="keyword"
				value="<c:out value='${keyword}'/>" placeholder="Search by name">
		</div>
		<div class="col-auto"><button class="btn btn-primary" type="submit">Search</button></div>
		<c:if test="${not empty keyword}">
			<div class="col-auto"><a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/categories">Clear</a></div>
		</c:if>
	</form>

	<div class="table-responsive">
		<table class="table table-striped table-hover align-middle">
			<thead class="table-dark">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Name</th>
					<th scope="col">Description</th>
					<th scope="col">Status</th>
					<th scope="col" class="text-end">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="category" items="${categories}">
					<tr>
						<td><c:out value="${category.id}"/></td>
						<td><c:out value="${category.name}"/></td>
						<td><c:out value="${category.description}"/></td>
						<td>
							<span class="badge ${category.status ? 'text-bg-success' : 'text-bg-secondary'}">
								${category.status ? 'Active' : 'Inactive'}
							</span>
						</td>
						<td class="text-end text-nowrap">
							<a class="btn btn-primary btn-sm"
								href="${pageContext.request.contextPath}/admin/categories/${category.id}/edit">Edit</a>
							<button class="btn btn-danger btn-sm" type="button" data-bs-toggle="modal"
								data-bs-target="#deleteCategoryModal${category.id}">Delete</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty categories}">
					<tr><td colspan="5" class="text-center text-muted py-4">No categories found.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${categoryPage.totalPages > 0}">
		<nav aria-label="Category pagination">
			<ul class="pagination justify-content-center">
				<c:url var="previousUrl" value="/admin/categories">
					<c:param name="page" value="${categoryPage.number - 1}"/>
					<c:param name="keyword" value="${keyword}"/>
				</c:url>
				<li class="page-item ${categoryPage.first ? 'disabled' : ''}">
					<a class="page-link" href="${categoryPage.first ? '#' : previousUrl}">Previous</a>
				</li>
				<c:forEach var="pageNumber" begin="0" end="${categoryPage.totalPages - 1}">
					<c:url var="pageUrl" value="/admin/categories">
						<c:param name="page" value="${pageNumber}"/>
						<c:param name="keyword" value="${keyword}"/>
					</c:url>
					<li class="page-item ${categoryPage.number == pageNumber ? 'active' : ''}">
						<a class="page-link" href="${pageUrl}">${pageNumber + 1}</a>
					</li>
				</c:forEach>
				<c:url var="nextUrl" value="/admin/categories">
					<c:param name="page" value="${categoryPage.number + 1}"/>
					<c:param name="keyword" value="${keyword}"/>
				</c:url>
				<li class="page-item ${categoryPage.last ? 'disabled' : ''}">
					<a class="page-link" href="${categoryPage.last ? '#' : nextUrl}">Next</a>
				</li>
			</ul>
		</nav>
	</c:if>

	<c:forEach var="category" items="${categories}">
		<div class="modal fade" id="deleteCategoryModal${category.id}" tabindex="-1"
			aria-labelledby="deleteCategoryModalLabel${category.id}" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title fs-5" id="deleteCategoryModalLabel${category.id}">Confirm deletion</h2>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						Delete category <strong><c:out value="${category.name}"/></strong>?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						<form method="post"
							action="${pageContext.request.contextPath}/admin/categories/${category.id}/delete">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<button type="submit" class="btn btn-danger">Delete</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>
