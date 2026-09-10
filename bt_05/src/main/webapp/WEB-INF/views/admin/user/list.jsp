<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<title>Users</title>
</head>
<body>
	<div class="card card-primary card-outline">
		<div class="card-header">
			<h2 class="card-title"><i class="bi bi-people-fill me-2"></i>User list</h2>
			<div class="card-tools">
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/admin/users/new">
					<i class="bi bi-person-plus-fill me-1"></i>Add User
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

			<form method="get" action="${pageContext.request.contextPath}/admin/users"
				class="row g-2 align-items-center mb-3">
				<div class="col-sm-8 col-lg-5">
					<label for="userKeyword" class="visually-hidden">Search by username or email</label>
					<div class="input-group">
						<span class="input-group-text"><i class="bi bi-search"></i></span>
						<input id="userKeyword" class="form-control" type="search" name="keyword"
							value="<c:out value='${keyword}'/>" placeholder="Search by username or email">
					</div>
				</div>
				<div class="col-auto">
					<button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>Search</button>
				</div>
				<c:if test="${not empty keyword}">
					<div class="col-auto">
						<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">
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
							<th scope="col">Username</th>
							<th scope="col">Full name</th>
							<th scope="col">Email</th>
							<th scope="col">Phone</th>
							<th scope="col">Role</th>
							<th scope="col">Status</th>
							<th scope="col" class="text-end table-actions">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${users}">
							<tr>
								<td><c:out value="${user.id}"/></td>
								<td><c:out value="${user.username}"/></td>
								<td><c:out value="${user.fullName}"/></td>
								<td><c:out value="${user.email}"/></td>
								<td><c:out value="${user.phone}"/></td>
								<td><span class="badge text-bg-info"><c:out value="${user.role}"/></span></td>
								<td>
									<span class="badge ${user.status ? 'text-bg-success' : 'text-bg-secondary'}">
										${user.status ? 'Active' : 'Inactive'}
									</span>
								</td>
								<td class="text-end text-nowrap">
									<a class="btn btn-primary btn-sm"
										href="${pageContext.request.contextPath}/admin/users/${user.id}/edit">
										<i class="bi bi-pencil-square me-1"></i>Edit
									</a>
									<button class="btn btn-danger btn-sm" type="button" data-bs-toggle="modal"
										data-bs-target="#deleteUserModal${user.id}">
										<i class="bi bi-trash3 me-1"></i>Delete
									</button>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty users}">
							<tr><td colspan="8" class="text-center text-body-secondary py-4">No users found.</td></tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<c:if test="${userPage.totalPages > 0}">
			<div class="card-footer clearfix">
				<nav aria-label="User pagination">
					<ul class="pagination pagination-sm m-0 float-end">
						<c:url var="previousUrl" value="/admin/users">
							<c:param name="page" value="${userPage.number - 1}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:url>
						<li class="page-item ${userPage.first ? 'disabled' : ''}">
							<a class="page-link" href="${userPage.first ? '#' : previousUrl}" aria-label="Previous">
								<i class="bi bi-chevron-left"></i><span class="d-none d-sm-inline ms-1">Previous</span>
							</a>
						</li>
						<c:forEach var="pageNumber" begin="0" end="${userPage.totalPages - 1}">
							<c:url var="pageUrl" value="/admin/users">
								<c:param name="page" value="${pageNumber}"/>
								<c:param name="keyword" value="${keyword}"/>
							</c:url>
							<li class="page-item ${userPage.number == pageNumber ? 'active' : ''}">
								<a class="page-link" href="${pageUrl}">${pageNumber + 1}</a>
							</li>
						</c:forEach>
						<c:url var="nextUrl" value="/admin/users">
							<c:param name="page" value="${userPage.number + 1}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:url>
						<li class="page-item ${userPage.last ? 'disabled' : ''}">
							<a class="page-link" href="${userPage.last ? '#' : nextUrl}" aria-label="Next">
								<span class="d-none d-sm-inline me-1">Next</span><i class="bi bi-chevron-right"></i>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</c:if>
	</div>

	<c:forEach var="user" items="${users}">
		<div class="modal fade" id="deleteUserModal${user.id}" tabindex="-1"
			aria-labelledby="deleteUserModalLabel${user.id}" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-danger text-white">
						<h2 class="modal-title fs-5" id="deleteUserModalLabel${user.id}">
							<i class="bi bi-exclamation-triangle-fill me-2"></i>Confirm deletion
						</h2>
						<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">Delete user <strong><c:out value="${user.username}"/></strong>?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						<form method="post" action="${pageContext.request.contextPath}/admin/users/${user.id}/delete">
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
