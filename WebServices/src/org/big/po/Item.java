package org.big.po;

import java.io.Serializable;

public class Item implements Serializable {

	private static final long serialVersionUID = 1L;
	private String ItemID;
	private String PrimaryTitleID;
	private String ThumbnailPageID;
	private String Volume;
	private String Contributor;
	private String ItemUrl;
	public String getItemID() {
		return ItemID;
	}
	public void setItemID(String itemID) {
		ItemID = itemID;
	}
	public String getPrimaryTitleID() {
		return PrimaryTitleID;
	}
	public void setPrimaryTitleID(String primaryTitleID) {
		PrimaryTitleID = primaryTitleID;
	}
	public String getThumbnailPageID() {
		return ThumbnailPageID;
	}
	public void setThumbnailPageID(String thumbnailPageID) {
		ThumbnailPageID = thumbnailPageID;
	}
	public String getVolume() {
		return Volume;
	}
	public void setVolume(String volume) {
		Volume = volume;
	}
	public String getContributor() {
		return Contributor;
	}
	public void setContributor(String contributor) {
		Contributor = contributor;
	}
	public String getItemUrl() {
		return ItemUrl;
	}
	public void setItemUrl(String itemUrl) {
		ItemUrl = itemUrl;
	}
	
	
}
