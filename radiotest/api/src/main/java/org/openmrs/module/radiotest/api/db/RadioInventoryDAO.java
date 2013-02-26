package org.openmrs.module.radiotest.api.db;

import java.util.List;

import org.openmrs.api.db.DAOException;
import org.openmrs.module.radiotest.RadioItem;
import org.openmrs.module.radiotest.RadioItemType;
import org.openmrs.module.radiotest.RadioTransItem;

public interface RadioInventoryDAO {

	public RadioItemType saveItemType(RadioItemType type) throws DAOException;
	public RadioItemType getItemType(Integer typeId) throws DAOException;
	public List<RadioItemType> getAllItemTypes(boolean includeVoided) throws DAOException;
	public void deleteItemType(RadioItemType type) throws DAOException;
	
	public RadioItem saveItem(RadioItem item) throws DAOException;
	public RadioItem getItem(Integer itemId) throws DAOException;
	public List<RadioItem> getItemByType(RadioItemType type) throws DAOException;
	public List<RadioItem> getAllItems(boolean includeVoided) throws DAOException;
	public void deleteItem(RadioItem item) throws DAOException;
	
	public RadioTransItem saveTransItem(RadioTransItem item) throws DAOException;
	public RadioTransItem getTransItem(Integer id) throws DAOException;
}