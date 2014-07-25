package org.big.util;

import org.gbif.ecat.model.ParsedName;
import org.gbif.ecat.parser.NameParser;
import org.gbif.ecat.parser.UnparsableException;

public class ParseParamUtil {
	public static String parseParam(String param) throws UnparsableException{
		NameParser np=new NameParser();
		ParsedName<Object> pn;
		String temp = "";

		pn = np.parse(param);
		temp = pn.getGenusOrAbove();
		temp += pn.getSpecificEpithet()==null?"":"+"+pn.getSpecificEpithet();
		temp += pn.getInfraSpecificEpithet()==null?"":"+"+pn.getInfraSpecificEpithet();

		return temp;
	}
}
