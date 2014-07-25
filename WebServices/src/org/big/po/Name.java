package org.big.po;

import java.io.Serializable;

public class Name implements Serializable {

	private static final long serialVersionUID = 1L;
	private String NameBankID ;
	private String NameConfirmed ;
	public String getNameBankID() {
		return NameBankID;
	}
	public void setNameBankID(String nameBankID) {
		NameBankID = nameBankID;
	}
	public String getNameConfirmed() {
		return NameConfirmed;
	}
	public void setNameConfirmed(String nameConfirmed) {
		NameConfirmed = nameConfirmed;
	}
	
	
	
	
	
}
