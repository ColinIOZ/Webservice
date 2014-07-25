package org.big.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.big.webapi.WebAPI;

public class PagesGetEOLData extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		String apiUrl = "http://eol.org/api/pages/1.0/";
		String id = request.getParameter("id");
		if (id != null && !"".equals(id))
			apiUrl += id + ".json";


		String param = "images=75&videos=75&sounds=75&maps=75&text=75" +
				"&iucn=true&subjects=all&licenses=all&details=true&common_names=true" +
				"&synonyms=true&references=true&vetted=1&format=json";
	    
		WebAPI webapi = new WebAPI();
		webapi.setAPIurl(apiUrl);
		webapi.setParameter(param);
		String r = webapi.accessAPI();
		//System.out.println(r);
		
		try {
			JsonConfig jc = new JsonConfig();
			JSONObject job = JSONObject.fromObject(r, jc);
			out.print(job);

		} catch (JSONException e) {
			e.printStackTrace();
		}

		out.flush();
		out.close();
	}

}
