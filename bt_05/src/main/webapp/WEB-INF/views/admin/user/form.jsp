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

	<h1 class="h3 mb-4">${empty userForm.id ? 'Add User' : 'Edit User'}</h1>
	<form:form method="post" action="${formAction}" modelAttribute="userForm" cssClass="card card-body shadow-sm">
		<form:hidden path="id"/>
		<div class="mb-3 form-group">
			<form:label path="username" cssClass="form-label">Username</form:label>
			<form:input path="username" cssClass="form-control" maxlength="100" required="required" autocomplete="username"/>
			<form:errors path="username" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="password" cssClass="form-label">Password</form:label>
			<form:password path="password" cssClass="form-control" maxlength="72" autocomplete="new-password"/>
			<c:if test="${not empty userForm.id}"><div class="form-text">Leave blank to keep the current password.</div></c:if>
			<form:errors path="password" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="fullName" cssClass="form-label">Full name</form:label>
			<form:input path="fullName" cssClass="form-control" maxlength="255"/>
			<form:errors path="fullName" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="email" cssClass="form-label">Email</form:label>
			<form:input path="email" type="email" cssClass="form-control" maxlength="255" required="required"/>
			<form:errors path="email" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="phone" cssClass="form-label">Phone</form:label>
			<form:input path="phone" type="tel" cssClass="form-control" maxlength="20"/>
			<form:errors path="phone" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="role" cssClass="form-label">Role</form:label>
			<form:select path="role" cssClass="form-select">
				<form:option value="ADMIN">ADMIN</form:option>
				<form:option value="USER">USER</form:option>
			</form:select>
			<form:errors path="role" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-check">
			<form:checkbox path="status" cssClass="form-check-input"/>
			<form:label path="status" cssClass="form-check-label">Active</form:label>
		</div>

		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-primary">Save</button>
			<a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/users">Cancel</a>
		</div>
	</form:form>
</body>
</html>
