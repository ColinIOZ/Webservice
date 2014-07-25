package org.big.po;

import java.io.Serializable;

public class Identifier implements Serializable {

	private static final long serialVersionUID = 1L;
	private String IdentifierName;
	private String IdentifierValue;
	public String getIdentifierName() {
		return IdentifierName;
	}
	public void setIdentifierName(String identifierName) {
		IdentifierName = identifierName;
	}
	public String getIdentifierValue() {
		return IdentifierValue;
	}
	public void setIdentifierValue(String identifierValue) {
		IdentifierValue = identifierValue;
	}
	
	
	
	
}
