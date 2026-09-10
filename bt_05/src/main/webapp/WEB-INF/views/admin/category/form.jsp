<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="vi">
<head>
	<title>${empty categoryForm.id ? 'Add Category' : 'Edit Category'}</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty categoryForm.id}">
			<c:url var="formAction" value="/admin/categories"/>
		</c:when>
		<c:otherwise>
			<c:url var="formAction" value="/admin/categories/${categoryForm.id}"/>
		</c:otherwise>
	</c:choose>

	<h1 class="h3 mb-4">${empty categoryForm.id ? 'Add Category' : 'Edit Category'}</h1>
	<form:form method="post" action="${formAction}" modelAttribute="categoryForm" cssClass="card card-body shadow-sm">
		<form:hidden path="id"/>
		<div class="mb-3 form-group">
			<form:label path="name" cssClass="form-label">Name</form:label>
			<form:input path="name" cssClass="form-control" maxlength="255" required="required"/>
			<form:errors path="name" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-group">
			<form:label path="description" cssClass="form-label">Description</form:label>
			<form:textarea path="description" cssClass="form-control" rows="4" maxlength="1000"/>
			<form:errors path="description" cssClass="invalid-feedback d-block"/>
		</div>

		<div class="mb-3 form-check">
			<form:checkbox path="status" cssClass="form-check-input"/>
			<form:label path="status" cssClass="form-check-label">Active</form:label>
		</div>

		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-primary">Save</button>
			<a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/categories">Cancel</a>
		</div>
	</form:form>
</body>
</html>
