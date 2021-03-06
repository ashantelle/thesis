package org.openmrs.module.radiotest.api;

import java.util.List;

import org.openmrs.api.APIException;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.radiotest.RadioExam;
import org.openmrs.module.radiotest.RadioExamType;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface RadioExamService extends OpenmrsService {
	
	public RadioExamType saveExamType(RadioExamType type) throws APIException;
	
	@Transactional(readOnly = true)
	public List<RadioExamType> getAllExamTypes() throws APIException;
	
	@Transactional(readOnly = true)
	public List<RadioExamType> getAllExamTypes(boolean includeVoided) throws APIException;
	
	@Transactional(readOnly = true)
	public RadioExamType getExamType(Integer typeId) throws APIException;
	
	public void deleteExamType(RadioExamType type) throws APIException;
	
	public RadioExam saveExam(RadioExam exam) throws APIException;
	
	@Transactional(readOnly = true)
	public List<RadioExam> getAllExams() throws APIException;
	
	@Transactional(readOnly = true)
	public List<RadioExam> getAllExams(boolean includeVoided) throws APIException;
	
	@Transactional(readOnly = true)
	public RadioExam getExam(Integer examId) throws APIException;
	
	@Transactional(readOnly = true)
	public RadioExam updateExam(RadioExam exam) throws APIException;
	
	@Transactional(readOnly = true)
	public List<RadioExam> getExamByType(RadioExamType type) throws APIException;
	
	public void deleteExam(RadioExam exam) throws APIException;

}
