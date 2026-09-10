<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="vi">
<head>
	<title>${empty userForm.id ? 'Add User' : 'Edit User'}</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty userForm.id}">
			<c:url var="formAction" value="/admin/users"/>
		</c:when>
		<c:otherwise>
			<c:url var="formAction" value="/admin/users/${userForm.id}"/>
		</c:otherwise>
	</c:choose>

	<div class="row">
		<div class="col-12 col-xl-9">
			<form:form method="post" action="${formAction}" modelAttribute="userForm"
				cssClass="card card-primary card-outline">
				<div class="card-header">
					<h2 class="card-title">
						<i class="bi ${empty userForm.id ? 'bi-person-plus-fill' : 'bi-person-gear'} me-2"></i>
						${empty userForm.id ? 'User information' : 'Edit user information'}
					</h2>
				</div>
				<div class="card-body">
					<form:hidden path="id"/>
					<div class="row">
						<div class="col-md-6 mb-3 form-group">
							<form:label path="username" cssClass="form-label">Username</form:label>
							<form:input path="username" cssClass="form-control" cssErrorClass="form-control is-invalid"
								maxlength="100" required="required" autocomplete="username"/>
							<form:errors path="username" cssClass="invalid-feedback d-block"/>
						</div>

						<div class="col-md-6 mb-3 form-group">
							<form:label path="password" cssClass="form-label">Password</form:label>
							<form:password path="password" cssClass="form-control" cssErrorClass="form-control is-invalid"
								maxlength="72" autocomplete="new-password"/>
							<c:if test="${not empty userForm.id}">
								<div class="form-text">Leave blank to keep the current password.</div>
							</c:if>
							<form:errors path="password" cssClass="invalid-feedback d-block"/>
						</div>

						<div class="col-md-6 mb-3 form-group">
							<form:label path="fullName" cssClass="form-label">Full name</form:label>
							<form:input path="fullName" cssClass="form-control" cssErrorClass="form-control is-invalid"
								maxlength="255"/>
							<form:errors path="fullName" cssClass="invalid-feedback d-block"/>
						</div>

						<div class="col-md-6 mb-3 form-group">
							<form:label path="email" cssClass="form-label">Email</form:label>
							<form:input path="email" type="email" cssClass="form-control" cssErrorClass="form-control is-invalid"
								maxlength="255" required="required"/>
							<form:errors path="email" cssClass="invalid-feedback d-block"/>
						</div>

						<div class="col-md-6 mb-3 form-group">
							<form:label path="phone" cssClass="form-label">Phone</form:label>
							<form:input path="phone" type="tel" cssClass="form-control" cssErrorClass="form-control is-invalid"
								maxlength="20"/>
							<form:errors path="phone" cssClass="invalid-feedback d-block"/>
						</div>

						<div class="col-md-6 mb-3 form-group">
							<form:label path="role" cssClass="form-label">Role</form:label>
							<form:select path="role" cssClass="form-select" cssErrorClass="form-select is-invalid">
								<form:option value="ADMIN">ADMIN</form:option>
								<form:option value="USER">USER</form:option>
							</form:select>
							<form:errors path="role" cssClass="invalid-feedback d-block"/>
						</div>
					</div>

					<div class="form-check form-switch">
						<form:checkbox path="status" cssClass="form-check-input" role="switch"/>
						<form:label path="status" cssClass="form-check-label">Active</form:label>
					</div>
				</div>
				<div class="card-footer d-flex gap-2">
					<button type="submit" class="btn btn-primary"><i class="bi bi-floppy-fill me-1"></i>Save</button>
					<a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/users">
						<i class="bi bi-x-circle me-1"></i>Cancel
					</a>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>
