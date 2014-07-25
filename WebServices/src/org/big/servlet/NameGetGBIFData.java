package org.big.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.big.util.CommonsUtil;
import org.big.util.Constants;
import org.big.util.PageUtil;
import org.big.util.WebUtil;
import org.big.webapi.WebAPI;
import org.gbif.ecat.model.ParsedName;
import org.gbif.ecat.parser.NameParser;
import org.gbif.ecat.parser.UnparsableException;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;

/**
 * Servlet implementation class NameGetBHLData
 */
public class NameGetGBIFData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NameGetGBIFData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();
		String scientificName=request.getParameter("scientificName");
		String offset = request.getParameter("offset");
		String country=request.getParameter("country");
		String hasCoordinate=request.getParameter("hasCoordinate");
		try {
			String apiUrl="http://api.gbif.org/v0.9/occurrence/search";
			String param = "";
			if(scientificName != null && !"".equals(scientificName)){
				if(scientificName.indexOf(' ') != -1)
					scientificName = scientificName.replace(' ', '+');
				param += "scientificName=" + scientificName;
				
			}
			if(country != null && !"0".equals(country)){
				if(country.indexOf(' ') != -1)
					country = country.replace(' ', '+');
				param += "&country=" + country;
				
			}
			if(hasCoordinate != null && !"0".equals(hasCoordinate))
				param += "&hasCoordinate=" + hasCoordinate;
			if(offset != null && !"".equals(offset))
				param += "&offset=" + offset;
			
			WebAPI wa=new WebAPI();
			wa.setAPIurl(apiUrl);
			wa.setParameter(param);
			String r=wa.accessAPI();
			JsonConfig jc=new JsonConfig();
			
			JSONObject job=JSONObject.fromObject(r,jc);
			out.print(job);
			
		} catch(JSONException e)
		{
			e.printStackTrace();
			
		}
		out.flush();
		out.close();
	}

}
