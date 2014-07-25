package org.big.po;

import java.io.Serializable;

public class Title implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String TitleID;
	private String BibliographicLevel;
	private String FullTitle;
	private String ShortTitle;
	private String SortTitle;
	private String PublisherPlace;
	private String PublisherName;
	private String PublicationDate;
	private String PartNumber;
	private String PartName;
	private String Edition;
	private String TitleUrl;
	private String CallNumber;
	
	public String getTitleID() {
		return TitleID;
	}
	public void setTitleID(String titleID) {
		TitleID = titleID;
	}
	public String getBibliographicLevel() {
		return BibliographicLevel;
	}
	public void setBibliographicLevel(String bibliographicLevel) {
		BibliographicLevel = bibliographicLevel;
	}
	public String getFullTitle() {
		return FullTitle;
	}
	public void setFullTitle(String fullTitle) {
		FullTitle = fullTitle;
	}
	public String getShortTitle() {
		return ShortTitle;
	}
	public void setShortTitle(String shortTitle) {
		ShortTitle = shortTitle;
	}
	public String getSortTitle() {
		return SortTitle;
	}
	public void setSortTitle(String sortTitle) {
		SortTitle = sortTitle;
	}
	public String getPublisherPlace() {
		return PublisherPlace;
	}
	public void setPublisherPlace(String publisherPlace) {
		PublisherPlace = publisherPlace;
	}
	public String getPublisherName() {
		return PublisherName;
	}
	public void setPublisherName(String publisherName) {
		PublisherName = publisherName;
	}
	public String getPublicationDate() {
		return PublicationDate;
	}
	public void setPublicationDate(String publicationDate) {
		PublicationDate = publicationDate;
	}
	public String getPartNumber() {
		return PartNumber;
	}
	public void setPartNumber(String partNumber) {
		PartNumber = partNumber;
	}
	public String getPartName() {
		return PartName;
	}
	public void setPartName(String partName) {
		PartName = partName;
	}
	public String getEdition() {
		return Edition;
	}
	public void setEdition(String edition) {
		Edition = edition;
	}
	public String getTitleUrl() {
		return TitleUrl;
	}
	public void setTitleUrl(String titleUrl) {
		TitleUrl = titleUrl;
	}
	public String getCallNumber() {
		return CallNumber;
	}
	public void setCallNumber(String callNumber) {
		CallNumber = callNumber;
	}
	
	

	
	
}
