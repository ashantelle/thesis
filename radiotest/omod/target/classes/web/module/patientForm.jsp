<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<%@ include file="template/resources.jsp" %>

<openmrs:htmlInclude file="/moduleResources/radiotest/pages/patient.js" />

<html lang="en">
<head>

</head>

<body>

<div class="colmask leftmenu">
	<div class="colleft">
		<div class="col1">
		<div class="cont">		

<div id="patient">			
<form:form method="post" modelAttribute="patientModel" id="patientForm">
	
	<spring:nestedPath path="patient">
	<form:hidden path="id" />
	
	<p>
	<form:input id="firstname" cssClass="patientinput" path="firstName" />
	<form:input id="midname" cssClass="patientinput" path="middleInitial" />
	<form:input id="lastname" cssClass="patientinput" path="lastName" />
	</p>
	<br>
	</spring:nestedPath>
	
	<h2>Basic Information</h2>
	<p>
	
	<spring:nestedPath path="alias">
	<form:select id="type" cssClass="patientinput" path="category">
		<option value></option>
		<form:options items="${ categories }" itemLabel="category" itemValue="id" />
	</form:select>
	<form:input id="alias" cssClass="patientinput" path="alias" />
	</p>
	</spring:nestedPath>
	
	<spring:nestedPath path="patient">
	<p> 
	<form:input id="philhealth" cssClass="patientinput" path="philhealth" />
	</p>
	
	<p><label for="sex">Sex:</label>
	<form:radiobutton cssClass="regular-radio" path="gender" value="M" />Male
	<form:radiobutton cssClass="regular-radio" path="gender" value="F" />Female
	</p>
	
	<p> <label for="status">Civil Status:</label>
	<form:radiobutton cssClass="regular-radio" path="civilStatus" value="Single" />Single
	<form:radiobutton cssClass="regular-radio" path="civilStatus" value="Married" />Married
	<form:radiobutton cssClass="regular-radio" path="civilStatus" value="Widowed" />Widowed
	</p>
	
	<p>
	<form:input id="birthday" cssClass="patientinput" path="birthday" />
	</p>
	
	<br>
	<h2>Contact details</h2>
	<p>
	<form:input id="contactno" cssClass="patientinput" path="contactNo" />
	</p>
	<p>
	<form:input id="institution" cssClass="patientinput" path="institution" />
	</p>
	
	<br>
	<h2>Housing</h2>
	<p>
	<form:input id="region" cssClass="patientinput" path="region" />
	</p>
	<p>
	<form:input id="city" cssClass="patientinput" path="city" />
	</p>
	<p>
	<form:input id="barangay" cssClass="patientinput" path="barangay" />
	</p>
	<p>
	<form:input id="street" cssClass="patientinput" path="streetAddress" />
	</p>
	<br>
	</spring:nestedPath>
	
	<input class="buttondesign" type="submit" value="Save" />
</form:form>
</div>

</div>
</div>
<div class="col2">
<div class="sideholder">
			<!-- Column 2 start -->
			<jsp:include page="/WEB-INF/view/sidemenu.jsp"/>
</div>
</div>
</div>
</div>

</body>
</html>