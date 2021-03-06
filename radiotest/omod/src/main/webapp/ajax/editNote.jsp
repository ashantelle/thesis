<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<c:set var="n" value="${ note }" />
<div id="note">
	<c:choose>
		<c:when test="${ empty n.type.id }">
			${ n.description }
		</c:when>
		<c:otherwise>
			${ n.type.name }
		</c:otherwise>
	</c:choose>
	<br>
	${ n.note }
	<br>
	${ n.date }
	<br>
	<br>
</div>