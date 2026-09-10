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

	<div class="row">
		<div class="col-12 col-xl-8">
			<form:form method="post" action="${formAction}" modelAttribute="categoryForm"
				cssClass="card card-primary card-outline">
				<div class="card-header">
					<h2 class="card-title">
						<i class="bi ${empty categoryForm.id ? 'bi-plus-circle' : 'bi-pencil-square'} me-2"></i>
						${empty categoryForm.id ? 'Category information' : 'Edit category information'}
					</h2>
				</div>
				<div class="card-body">
					<form:hidden path="id"/>
					<div class="mb-3 form-group">
						<form:label path="name" cssClass="form-label">Name</form:label>
						<form:input path="name" cssClass="form-control" cssErrorClass="form-control is-invalid"
							maxlength="255" required="required"/>
						<form:errors path="name" cssClass="invalid-feedback d-block"/>
					</div>

					<div class="mb-3 form-group">
						<form:label path="description" cssClass="form-label">Description</form:label>
						<form:textarea path="description" cssClass="form-control" cssErrorClass="form-control is-invalid"
							rows="4" maxlength="1000"/>
						<form:errors path="description" cssClass="invalid-feedback d-block"/>
					</div>

					<div class="form-check form-switch">
						<form:checkbox path="status" cssClass="form-check-input" role="switch"/>
						<form:label path="status" cssClass="form-check-label">Active</form:label>
					</div>
				</div>
				<div class="card-footer d-flex gap-2">
					<button type="submit" class="btn btn-primary"><i class="bi bi-floppy-fill me-1"></i>Save</button>
					<a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/categories">
						<i class="bi bi-x-circle me-1"></i>Cancel
					</a>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>
