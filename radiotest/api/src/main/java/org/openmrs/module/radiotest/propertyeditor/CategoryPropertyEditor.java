package org.openmrs.module.radiotest.propertyeditor;

import java.beans.PropertyEditorSupport;

import org.openmrs.api.context.Context;
import org.openmrs.module.radiotest.RadioCategory;
import org.openmrs.module.radiotest.api.RadioTestService;

public class CategoryPropertyEditor extends PropertyEditorSupport {
	
	public void setAsText(String text) throws IllegalArgumentException {
		Integer cid = Integer.valueOf(text);
		System.out.println(text);
		setValue(Context.getService(RadioTestService.class).getCategory(cid));
	}
	
	public String getAsText() {
		RadioCategory category = (RadioCategory) getValue();
		return category != null? category.getCategory() : "";
	}
}
