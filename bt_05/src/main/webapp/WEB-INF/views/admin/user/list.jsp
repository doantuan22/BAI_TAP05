<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
	<title>Users</title>
</head>
<body>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h1 class="h3 mb-0">Users</h1>
		<div class="d-flex gap-2">
			<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/users/new">Add User</a>
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

	<form method="get" action="${pageContext.request.contextPath}/admin/users" class="row g-2 mb-3">
		<div class="col-sm-8 col-md-5">
			<label for="userKeyword" class="visually-hidden">Search by username or email</label>
			<input id="userKeyword" class="form-control" type="search" name="keyword"
				value="<c:out value='${keyword}'/>" placeholder="Search by username or email">
		</div>
		<div class="col-auto"><button class="btn btn-primary" type="submit">Search</button></div>
		<c:if test="${not empty keyword}">
			<div class="col-auto"><a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">Clear</a></div>
		</c:if>
	</form>

	<div class="table-responsive">
		<table class="table table-striped table-hover align-middle">
			<thead class="table-dark">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Username</th>
					<th scope="col">Full name</th>
					<th scope="col">Email</th>
					<th scope="col">Phone</th>
					<th scope="col">Role</th>
					<th scope="col">Status</th>
					<th scope="col" class="text-end">Actions</th>
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
						<td><c:out value="${user.role}"/></td>
						<td>
							<span class="badge ${user.status ? 'text-bg-success' : 'text-bg-secondary'}">
								${user.status ? 'Active' : 'Inactive'}
							</span>
						</td>
						<td class="text-end text-nowrap">
							<a class="btn btn-primary btn-sm"
								href="${pageContext.request.contextPath}/admin/users/${user.id}/edit">Edit</a>
							<button class="btn btn-danger btn-sm" type="button" data-bs-toggle="modal"
								data-bs-target="#deleteUserModal${user.id}">Delete</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty users}">
					<tr><td colspan="8" class="text-center text-muted py-4">No users found.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${userPage.totalPages > 0}">
		<nav aria-label="User pagination">
			<ul class="pagination justify-content-center">
				<c:url var="previousUrl" value="/admin/users">
					<c:param name="page" value="${userPage.number - 1}"/>
					<c:param name="keyword" value="${keyword}"/>
				</c:url>
				<li class="page-item ${userPage.first ? 'disabled' : ''}">
					<a class="page-link" href="${userPage.first ? '#' : previousUrl}">Previous</a>
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
					<a class="page-link" href="${userPage.last ? '#' : nextUrl}">Next</a>
				</li>
			</ul>
		</nav>
	</c:if>

	<c:forEach var="user" items="${users}">
		<div class="modal fade" id="deleteUserModal${user.id}" tabindex="-1"
			aria-labelledby="deleteUserModalLabel${user.id}" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title fs-5" id="deleteUserModalLabel${user.id}">Confirm deletion</h2>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						Delete user <strong><c:out value="${user.username}"/></strong>?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						<form method="post"
							action="${pageContext.request.contextPath}/admin/users/${user.id}/delete">
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
