package org.openmrs.module.radiotest.web.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.openmrs.api.context.Context;
import org.openmrs.module.radiotest.RadioItem;
import org.openmrs.module.radiotest.RadioItemType;
import org.openmrs.module.radiotest.RadioStockListing;
import org.openmrs.module.radiotest.api.RadioInventoryService;
import org.openmrs.module.radiotest.model.RadioStockModel;
import org.openmrs.module.radiotest.propertyeditor.RadioComparator;
import org.openmrs.module.radiotest.propertyeditor.RadioItemPropertyEditor;
import org.openmrs.module.radiotest.propertyeditor.RadioItemTypePropertyEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RadioStockController {
	
	private final String INVENTORY_PAGE = "/module/radiotest/inventory";
	private final String LISTINGS_PAGE = "/module/radiotest/listings";
	private final String STOCK_PAGE = "/module/radiotest/stock";
	
	@InitBinder
	public void initBinder(WebRequest request, WebDataBinder binder){
		binder.registerCustomEditor(RadioItemType.class, new RadioItemTypePropertyEditor());
		binder.registerCustomEditor(RadioItem.class, new RadioItemPropertyEditor());
	}
	
	@ModelAttribute("itemTypes")
	public List<RadioItemType> getItemTypes(){
		return Context.getService(RadioInventoryService.class).getAllItemTypes();
	}
	
	@ModelAttribute("stockModel")
	public RadioStockModel getStockModel(){
		return new RadioStockModel();
	}
	
	@RequestMapping(value = INVENTORY_PAGE, method = RequestMethod.GET)
	public void showInventory(ModelMap model){
		RadioInventoryService is = Context.getService(RadioInventoryService.class);
		
		HashMap<RadioItemType, List<RadioItem>> itemMap = new HashMap<RadioItemType, List<RadioItem>>();
		List<RadioItemType> itemTypes = is.getAllItemTypes();
		for(RadioItemType type : itemTypes){
			itemMap.put(type, is.getItemByType(type));
		}
		
		model.addAttribute("items", itemMap);
	}
	
	@RequestMapping(value = LISTINGS_PAGE, method = RequestMethod.GET)
	public void showListings(ModelMap model){
		List<RadioStockListing> listings = Context.getService(RadioInventoryService.class).getAllListings();
		Collections.sort(listings, Collections.reverseOrder(new RadioComparator()));
		
		RadioStockListing latest = listings.get(0);
		model.addAttribute("listings", listings);
		model.addAttribute("updateDate", latest.getListingDate());
	}
	
	@RequestMapping(value = STOCK_PAGE, method = RequestMethod.GET)
	public void showForm(){
		
	}
	
	@RequestMapping(value = STOCK_PAGE, method = RequestMethod.POST)
	public ModelAndView saveListings(@ModelAttribute("stockModel") RadioStockModel sm, ModelMap model){
		RadioInventoryService is = Context.getService(RadioInventoryService.class);

		List<RadioStockListing> listings = sm.getFullListings();
		is.saveListings(listings);
		
		for(RadioStockListing list : listings){
			RadioItem item = list.getItem();
			item.addStock(list.getQuantity());
			is.saveItem(item);
		}
		
		return new ModelAndView(redirect(INVENTORY_PAGE));
	}
	
	@RequestMapping(value = "/module/radiotest/getItems", method = RequestMethod.POST)
	public ModelAndView getItemsByType(@RequestParam("type") RadioItemType type, WebRequest request, ModelMap model){
		List<RadioItem> itemList = Context.getService(RadioInventoryService.class).getItemByType(type);
		
		model.addAttribute("index", request.getParameter("index"));
		model.addAttribute("items", itemList);
		model.addAttribute("itemType", type);
		
		return new ModelAndView("/module/radiotest/ajax/addListing", model);
	}
	
	private String redirect(String url){
		return "redirect:" + url + ".htm";
	}
}
