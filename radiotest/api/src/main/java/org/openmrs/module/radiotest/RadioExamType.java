package org.openmrs.module.radiotest;

import org.openmrs.BaseOpenmrsMetadata;

public class RadioExamType extends BaseOpenmrsMetadata {
	
	private Integer id;
	private String type;
	
	private Boolean voided = Boolean.FALSE;

	@Override
	public Integer getId() {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public void setId(Integer id) {
		// TODO Auto-generated method stub
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Boolean getVoided() {
		return voided;
	}

	public void setVoided(Boolean voided) {
		this.voided = voided;
	}

}
