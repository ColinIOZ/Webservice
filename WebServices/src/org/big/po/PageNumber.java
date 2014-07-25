package org.big.po;

import java.io.Serializable;

public class PageNumber implements Serializable {

	private static final long serialVersionUID = 1L;
	private String Prefix;
	private String Number;
	public String getPrefix() {
		return Prefix;
	}
	public void setPrefix(String prefix) {
		Prefix = prefix;
	}
	public String getNumber() {
		return Number;
	}
	public void setNumber(String number) {
		Number = number;
	}
	
	
	
}
