package org.big.po;

import java.io.Serializable;

public class Collection implements Serializable {

	private static final long serialVersionUID = 1L;
	private String CollectionID;
	private String CollectionName;
	private String CanContainTitles;
	private String CanContainItems;
	public String getCollectionID() {
		return CollectionID;
	}
	public void setCollectionID(String collectionID) {
		CollectionID = collectionID;
	}
	public String getCollectionName() {
		return CollectionName;
	}
	public void setCollectionName(String collectionName) {
		CollectionName = collectionName;
	}
	public String getCanContainTitles() {
		return CanContainTitles;
	}
	public void setCanContainTitles(String canContainTitles) {
		CanContainTitles = canContainTitles;
	}
	public String getCanContainItems() {
		return CanContainItems;
	}
	public void setCanContainItems(String canContainItems) {
		CanContainItems = canContainItems;
	}
	
	
}
