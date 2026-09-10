<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<title>Categories</title>
</head>
<body>
	<div class="card card-primary card-outline">
		<div class="card-header">
			<h2 class="card-title"><i class="bi bi-tags-fill me-2"></i>Category list</h2>
			<div class="card-tools">
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/admin/categories/new">
					<i class="bi bi-plus-lg me-1"></i>Add Category
				</a>
			</div>
		</div>
		<div class="card-body">
			<c:if test="${not empty message}">
				<div class="alert alert-success alert-dismissible fade show" role="alert">
					<i class="bi bi-check-circle-fill me-2"></i><c:out value="${message}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<i class="bi bi-exclamation-triangle-fill me-2"></i><c:out value="${errorMessage}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>

			<form method="get" action="${pageContext.request.contextPath}/admin/categories"
				class="row g-2 align-items-center mb-3">
				<div class="col-sm-8 col-lg-5">
					<label for="categoryKeyword" class="visually-hidden">Search by category name</label>
					<div class="input-group">
						<span class="input-group-text"><i class="bi bi-search"></i></span>
						<input id="categoryKeyword" class="form-control" type="search" name="keyword"
							value="<c:out value='${keyword}'/>" placeholder="Search by name">
					</div>
				</div>
				<div class="col-auto">
					<button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>Search</button>
				</div>
				<c:if test="${not empty keyword}">
					<div class="col-auto">
						<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/categories">
							<i class="bi bi-x-lg me-1"></i>Clear
						</a>
					</div>
				</c:if>
			</form>

			<div class="table-responsive">
				<table class="table table-bordered table-striped table-hover align-middle mb-0">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Name</th>
							<th scope="col">Description</th>
							<th scope="col">Status</th>
							<th scope="col" class="text-end table-actions">Actions</th>
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
										href="${pageContext.request.contextPath}/admin/categories/${category.id}/edit">
										<i class="bi bi-pencil-square me-1"></i>Edit
									</a>
									<button class="btn btn-danger btn-sm" type="button" data-bs-toggle="modal"
										data-bs-target="#deleteCategoryModal${category.id}">
										<i class="bi bi-trash3 me-1"></i>Delete
									</button>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty categories}">
							<tr><td colspan="5" class="text-center text-body-secondary py-4">No categories found.</td></tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<c:if test="${categoryPage.totalPages > 0}">
			<div class="card-footer clearfix">
				<nav aria-label="Category pagination">
					<ul class="pagination pagination-sm m-0 float-end">
						<c:url var="previousUrl" value="/admin/categories">
							<c:param name="page" value="${categoryPage.number - 1}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:url>
						<li class="page-item ${categoryPage.first ? 'disabled' : ''}">
							<a class="page-link" href="${categoryPage.first ? '#' : previousUrl}" aria-label="Previous">
								<i class="bi bi-chevron-left"></i><span class="d-none d-sm-inline ms-1">Previous</span>
							</a>
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
							<a class="page-link" href="${categoryPage.last ? '#' : nextUrl}" aria-label="Next">
								<span class="d-none d-sm-inline me-1">Next</span><i class="bi bi-chevron-right"></i>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</c:if>
	</div>

	<c:forEach var="category" items="${categories}">
		<div class="modal fade" id="deleteCategoryModal${category.id}" tabindex="-1"
			aria-labelledby="deleteCategoryModalLabel${category.id}" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-danger text-white">
						<h2 class="modal-title fs-5" id="deleteCategoryModalLabel${category.id}">
							<i class="bi bi-exclamation-triangle-fill me-2"></i>Confirm deletion
						</h2>
						<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						Delete category <strong><c:out value="${category.name}"/></strong>?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						<form method="post" action="${pageContext.request.contextPath}/admin/categories/${category.id}/delete">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<button type="submit" class="btn btn-danger"><i class="bi bi-trash3 me-1"></i>Delete</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>
