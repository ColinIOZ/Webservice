package org.big.po;

import java.io.Serializable;

public class Page implements Serializable {

	private static final long serialVersionUID = 1L;
	private String PageID;
	private String ItemID;
	private String Volume;
	private String Year;
	private String PageUrl;
	private String ThumbnailUrl;
	private String FullSizeImageUrl;
	private String OcrUrl;
	
	public String getPageID() {
		return PageID;
	}
	public void setPageID(String pageID) {
		PageID = pageID;
	}
	public String getItemID() {
		return ItemID;
	}
	public void setItemID(String itemID) {
		ItemID = itemID;
	}
	public String getVolume() {
		return Volume;
	}
	public void setVolume(String volume) {
		Volume = volume;
	}
	public String getYear() {
		return Year;
	}
	public void setYear(String year) {
		Year = year;
	}
	public String getPageUrl() {
		return PageUrl;
	}
	public void setPageUrl(String pageUrl) {
		PageUrl = pageUrl;
	}
	public String getThumbnailUrl() {
		return ThumbnailUrl;
	}
	public void setThumbnailUrl(String thumbnailUrl) {
		ThumbnailUrl = thumbnailUrl;
	}
	public String getFullSizeImageUrl() {
		return FullSizeImageUrl;
	}
	public void setFullSizeImageUrl(String fullSizeImageUrl) {
		FullSizeImageUrl = fullSizeImageUrl;
	}
	public String getOcrUrl() {
		return OcrUrl;
	}
	public void setOcrUrl(String ocrUrl) {
		OcrUrl = ocrUrl;
	}
	
	
}
