<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<%@ include file="template/resources.jsp" %>
<%@ include file="template/tables.jsp" %>
<openmrs:htmlInclude file="/moduleResources/radiotest/pages/report.js" />

<div class="colmask leftmenu">
	<div class="colleft">
		<div class="col1">
		<div class="cont">
<br>
<form:form id="report" modelAttribute="report">
	Date from <form:input path="startDate" cssClass="date patientinputmedium" id="sdate" /> to <form:input path="endDate" cssClass="date patientinputmedium" id="edate" />
	<br><br>
	<div class="holder">
	<div id="patient" class="left">
	<h2>Patient</h2>
		<button type="button" id="buttondesignsmall" style="width:100px;" class="filterButton">Add Filter</button><br><br>
		<spring:nestedPath path="patient">
			<div class="entity">
				<input type="checkbox" class="general default">Full Name <br>
				<div hidden id="tab">
					
					<input type="checkbox">First Name 
					<form:input path="firstName" cssClass="filter" /><br>
					<input type="checkbox">Middle Initial 
					<form:input path="middleInitial" cssClass="filter" /><br>
					<input type="checkbox">Last Name 
					<form:input path="lastName" cssClass="filter" /><br>
					
				</div>
			</div>
			<div class="entity">
				<input type="checkbox" class="general">Address <br>
				<div hidden id="tab">
					<input type="checkbox">Street Address 
					<form:input path="streetAddress" cssClass="filter" /><br>
					<input type="checkbox">Barangay 
					<form:input path="barangay" cssClass="filter" /><br>
					<input type="checkbox">City 
					<form:input path="city" cssClass="filter" /><br>
					<input type="checkbox">Region 
					<form:input path="region" cssClass="filter" /><br>
				</div>
			</div>
			<input type="checkbox" class="default">Case Number 
			<form:input path="caseNumber" cssClass="filter" /><br>
			<input type="checkbox">Gender 
			<div class="filter">
				<spring:bind path="gender">
					<input type="radio" name="${ status.expression }" value="" checked>Both
				</spring:bind>
				<form:radiobutton path="gender" value="M" />Male
				<form:radiobutton path="gender" value="F" />Female
			</div>
			<br>
			<input type="checkbox">Civil Status 
				<form:select path="civilStatus" cssClass="patientinputmedium filter">
					<option value=""></option>
					<option value="Single">Single</option>
					<option value="Married">Married</option>
					<option value="Widowed">Widowed</option>
				</form:select>
			<br>
			<input type="checkbox">Institution 
			<form:input path="institution" cssClass="filter" /><br>
			<input type="checkbox" class="default">Philhealth 
			<form:input path="philhealth" cssClass="filter" /><br>
		</spring:nestedPath>
		<spring:nestedPath path="alias">
			<input type="checkbox" class="default">Alias 
			<form:input path="alias" cssClass="filter" /><br>
		</spring:nestedPath>
		<input type="checkbox" class="default">Category 
		<form:select path="category" cssClass="filter">
			<option value="0"></option>
			<form:options items="${ categories }" itemLabel="category" itemValue="id" />
		</form:select>
	</div>
	
	
	<div id="exam" class="left">
	<h2>Exam</h2>
		<button type="button" id="buttondesignsmall" style="width:100px;" class="filterButton">Add Filter</button> <br><br>
		<input type="checkbox" class="default">Exam Type
		<form:select path="examType" cssClass="filter">
			<option value="0"></option>
			<form:options items="${ examTypes }" itemLabel="type" itemValue="id" />
		</form:select>
		<br>
		<input type="checkbox" class="default">Exam Name
		<form:select path="exam" cssClass="filter">
			<option value="0"></option>
			<form:options items="${ exams }" itemLabel="name" itemValue="id" />
		</form:select>
		<br>
		<spring:nestedPath path="result">
			<input type="checkbox" name="fieldList" value="r.positive" class="default">Result
			<div class="filter">
				<spring:bind path="positive">
					<input type="radio" name="${ status.expression }" value="" checked>All
				</spring:bind>
				<form:radiobutton path="positive" value="true" />Positive
				<form:radiobutton path="positive" value="false" />Negative
			</div>
			<br>
			<input type="checkbox" class="default">Findings
			<form:input path="findings" cssClass="filter" /><br>
		</spring:nestedPath>
	</div>
	
	<div id="transaction" class="left">
	<h2>Transaction</h2>
		<button type="button" id="buttondesignsmall" style="width:100px;" class="filterButton">Add Filter</button> <br><br>
		<spring:nestedPath path="transaction">
			<input type="checkbox" name="fieldList" value="t.visitDate" class="default">Visit Date <br>
			<input type="checkbox" name="fieldList" value="t.visitTime">Visit Time <br>
			<input type="checkbox">Patient Type
			<form:select path="patientType" cssClass="filter">
				<option value=""></option>
				<option value="OP">OP</option>
				<option value="IN-P">IN-P</option>
			</form:select>
			<br>
			<input type="checkbox">Purpose
			<form:input path="purpose" cssClass="filter" /><br>
			<input type="checkbox" name="fieldList" value="t.paid">Paid
			<div class="filter">
				<spring:bind path="orNumber">
					<input type="radio" name="${ status.expression }" value="*" checked>All
				</spring:bind>	
				<form:radiobutton path="orNumber" value="_%" />w/ OR Number
				<form:radiobutton path="orNumber" value="_" /> w/out OR Number
			</div>
			<br>
			<input type="checkbox" name="fieldList" value="t.claimed">Claimed
			<div class="filter">
				<spring:bind path="claimed">
					<input type="radio" name="${ status.expression }" value="" checked>All
				</spring:bind>
				<form:radiobutton path="claimed" value="true" />Claimed
				<form:radiobutton path="claimed" value="false" />Not Claimed
			</div>		
			<br>
			<input type="checkbox" name="fieldList" value="t.total" class="default">Total
			<br>
			<input type="checkbox">Voided
			<div class="filter">
				<form:radiobutton path="voided" value="true" />Is voided
				<form:radiobutton path="voided" value="false" />Is NOT voided
			</div>
			<br>
		</spring:nestedPath>
		<br>
		<input type="checkbox" name="fieldList" value="n.type">Note Type
		<form:select path="noteType" cssClass="filter">
			<option value=""></option>
			<form:options items="${ noteTypes }" itemLabel="name" itemValue="id" />
			<option value="0">Others</option>
		</form:select>
		<br>
		<spring:nestedPath path="note">
			<input type="checkbox">Note
			<form:input path="note" cssClass="filter" />
		</spring:nestedPath>
	</div>
	</div>
	<br style="clear: left;" />
	<button type="button" class="buttondesign" style="width:180px;"onclick="generateReport()">Generate Report</button>
</form:form>

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