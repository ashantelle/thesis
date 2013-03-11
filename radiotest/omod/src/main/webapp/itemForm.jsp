<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="template/resources.jsp" %>

<script type="text/javascript">
<!--
var modulePath = openmrsContextPath + "/module/radiotest";
var formPath = modulePath + "/itemForm.htm";
var nullPath = modulePath + "/nullItem.htm";
var editPath = modulePath + "/editItem.htm";

function post(divId, obj, path, callback){
	$j.post(path, obj, function(data){
		var $divElem = $j(divId);
		var $updatedDiv = $j(divId, $j(data));
		if ($updatedDiv.length){
			$divElem.replaceWith($updatedDiv);
		} else {
			$divElem.remove();
		}
		if (callback){
			callback();
		}
	});
}

function saveItem(){
	var divId = "#items";
	var $form = $j("#itemForm");
	var obj = $form.serialize();
	var path = $form.attr("action", formPath);
		
	post(divId, obj, path, focus);
}

function voidItem(id){
	var divId = "#item" + id;
	var obj = {
		iid : id,
		action : "void"
	};
	
	post(divId, obj, nullPath);
}

function deleteItem(id){
	var divId = "#item" + id;
	var obj = {
		iid : id,
		action : "delete"
	};
	
	function clean(){
		$j("div h4:only-child")
			.parent()
			.remove();
	}
	
	if (confirm("Are you sure you want to delete?")){
		post(divId, obj, nullPath, clean);
	}
}

function editItem(id){
	var formId = "#itemForm";
	var obj = {
		iid : id
	};
	
	post(formId, obj, editPath);
}

$j(function(){	
	GeneralUtils.addPlaceholderById("itemname", "Enter Item Name");
	GeneralUtils.addPlaceholderById("unit", "Enter the Unit");
});
//-->
</script>
<div class="colmask leftmenu">
	<div class="colleft">
		<div class="col1">
<br>
<h2>Items</h2>
<form:form method="post" modelAttribute="item" id="itemForm">
	<p>
	<form:hidden path="id" />
	<label>Item Type</label>
	<form:select cssClass="patientinput" path="type">
		<option value="0"></option>
		<form:options items="${ itemTypes }" itemLabel="name" itemValue="id" />
	</form:select>
	</p>
	
	<p>
	<form:input id="itemname" cssClass="patientinput" path="name" />
	</p>
	
	<p>
	<form:input id="unit" cssClass="patientinput" path="unit" />
	</p>
	
	<p>
	<label>Threshold</label>
	<c:set var="t" value="${ item.threshold }" />
	<c:set var="pt" value="${ item.percentThreshold }" />
	<c:set var="threshold" value="${ t > pt? t : pt }" />
	<input type="text" name="limit" value="${ threshold }">
	<select name="limitType">
		<option value="1">units</option>
		<option value="2" 
		<c:if test="${ pt > t }">
			selected
		</c:if>
		>%</option>
	</select>
	</p>
	<button class="buttondesign" type="button" onclick="saveItem()">Save</button>
</form:form>
<br>
<hr>
<br>
<h2>Existing Items</h2>
<div id="items">
	<c:forEach var="itemMap" items="${ items }">
		<c:set var="type" value="${ itemMap.key }" />
		<c:set var="list" value="${ itemMap.value }" />
		<div id="type${ type.id }">
			<h4>${ type.name }</h4>
			<c:forEach var="i" items="${ list }">
				<c:set var="id" value="${ i.id }" />
				<div id="item${ id }">
					Name: ${ i.name } <br>
					Unit: ${ i.unit } <br>
					Threshold:
					<c:choose>
						<c:when test="${ i.percentThreshold == 0 }">
							${ i.threshold } ${ i.unit }
						</c:when>
						<c:otherwise>
							${ i.percentThreshold }%
						</c:otherwise>
					</c:choose>
					<br>
					Voided:
					<c:choose>
						<c:when test="${ i.voided }">
							YES
						</c:when>
						<c:otherwise>
							NO
						</c:otherwise>
					</c:choose>
					<button type="button" onclick="voidItem(${ id })"></button>
					<br>
					<button type="button" onclick="deleteItem(${ id })">Delete</button>
					<button type="button" onclick="editItem(${ id })">Edit</button>
				</div>
			</c:forEach>
		</div>
	</c:forEach>
</div>
</div>
<div class="col2">
			<!-- Column 2 start -->
			<jsp:include page="/WEB-INF/view/sidemenu.jsp"/>
		</div>
</div></div>