package org.big.po;

import java.io.Serializable;

public class Author implements Serializable {

	private static final long serialVersionUID = 1L;
	private String CreatorID;
	private String Name;
	private String Role;
	private String Unit;
	private String Location;
	private String Dates;
	private String Numeration;
	private String Title;
	private String FullerForm;
	
	
	public String getCreatorID() {
		return CreatorID;
	}
	public void setCreatorID(String creatorID) {
		CreatorID = creatorID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getRole() {
		return Role;
	}
	public void setRole(String role) {
		Role = role;
	}
	public String getUnit() {
		return Unit;
	}
	public void setUnit(String unit) {
		Unit = unit;
	}
	public String getLocation() {
		return Location;
	}
	public void setLocation(String location) {
		Location = location;
	}
	public String getDates() {
		return Dates;
	}
	public void setDates(String dates) {
		Dates = dates;
	}
	public String getNumeration() {
		return Numeration;
	}
	public void setNumeration(String numeration) {
		Numeration = numeration;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getFullerForm() {
		return FullerForm;
	}
	public void setFullerForm(String fullerForm) {
		FullerForm = fullerForm;
	}

	
	
}
