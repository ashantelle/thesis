<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<script>
var modulePath = openmrsContextPath + "/module/radiotest";
var addExamPath = modulePath + "/addExam.htm select:first-child";
var getExamsPath = modulePath + "/getExams.htm select:last-child";
var transExamPath = modulePath + "/transExamForm.htm";
var saveNotePath = modulePath + "/saveNote.htm"
var transPath = modulePath + "/transactionForm.htm";
var examIndex = 0;
var examIndexLabel = 1;
function addNewExam(){
	examIndex++;
	
	var $examDiv = $j("<div id='exams" + examIndex + "'> Exam " + examIndexLabel +"</div>");
	var $typeDiv = $j("<div id='type'></div>");
	var postObj = { index : examIndex };
	
	$typeDiv.load(addExamPath, postObj, function(data){
		$typeDiv.children('select').change(getExamsEvent);
		$typeDiv.appendTo($examDiv);
		$examDiv.appendTo("#transExam");
		updateDeleteButton();
	});
	
	examIndexLabel++;
}

function deleteExam(){
	$j("div#exams" + examIndex).remove();
	examIndex--;
	examIndexLabel--;
	updateDeleteButton();
}

function getExamsEvent(){
	var currIndex = $j(this).attr("name").match(/\d+/)[0];
	var $examDiv = $j("<div id='exam'></div>");
	var postObj = {
		index : currIndex,
		type : $j(this).val()
	};
	
	$examDiv.load(getExamsPath, postObj, function(data){
		var $exam = $j("div#exams" + currIndex);
		var $existing = $j("div#exam", $exam);
		$j("select", $examDiv).addClass("patientinput");
		if($existing.size()){
			$existing.replaceWith($examDiv);
		} else {
			$exam.append($examDiv);
		}
	});
}

function updateDeleteButton(){
	var $delete = $j("button#delete");
	var disabledState = examIndex == 0;
	var isDisabled = $delete.attr("disabled");
	
	if(disabledState != isDisabled){
		if(disabledState){
			$delete.attr("disabled", "disabled");
		} else {
			$delete.removeAttr("disabled");
		}
	}
}

function summarize(){
	$j.post(transExamPath, $j("#transExam").serialize(), function(data){
		$trans = $j("#transaction", $j(data));
		$j("#transaction").replaceWith($trans);
		$j("#transExam *").attr("disabled", "disabled");
	});
}

function saveNote(){
	$j.post(saveNotePath, $j("#noteForm").serialize(), function(data){
		var $note = $j("#note", $j(data));
		$note.unwrap();
		$j("#notes").prepend($note);
	});
}

function noteTypesEvent(){
	var $desc = $j("#desc");
	var isHidden = $desc.attr("hidden");
	var others = $j("#noteType").val() == 0;
	
	if (others == isHidden){
		if (isHidden){
			$desc.removeAttr("hidden");
		} else {
			$desc.attr("hidden", "hidden");
		}
	}
}

function addPayment(){
	console.log($j("#payment").serialize());
	$j.post(transPath, $j("#payment").serialize(), function(data){
		alert("Payment added");
	});
}

$j(function(){
	$j("select").change(getExamsEvent);
});
</script>

<div class="colmask leftmenu">
	<div class="colleft">
		<div class="col1">
<br/><br/>
<div class="info">
<form:form method="post" modelAttribute="transModel" id="transExam">
	<br>
	<spring:bind path="transaction.patient">
		<input type="hidden" name="${ status.expression }" value="${ patient.id }">
	</spring:bind>
	<spring:nestedPath path="exams[0]">
		<div id="exams0">
			<div id="type">
				Category: <form:select cssClass="patientinput" path="exam.type">
					<option value="0"></option>
					<form:options items="${ examTypes }" itemLabel="type" itemValue="id" />
				</form:select>
			</div>
		</div>
	</spring:nestedPath>
	<br/>
</div>
	<br/><br/>
	<button class="buttondesign" type="button" id="add" onclick="addNewExam()">Add Exam</button>
	<button class="buttondesign" type="button" id="delete" onclick="deleteExam()" disabled>Delete Exam</button>
	<button class="buttondesign" type="submit">Done</button>
</form:form>

</div>
<div class="col2">
			<!-- Column 2 start -->
			<jsp:include page="/WEB-INF/view/sidemenu.jsp"/>
		</div>
</div></div>


<%@ include file="/WEB-INF/template/footer.jsp"%>