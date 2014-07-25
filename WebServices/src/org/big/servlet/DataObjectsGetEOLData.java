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

public class DataObjectsGetEOLData extends HttpServlet {

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

		String id = request.getParameter("id");
		String apiUrl = "http://eol.org/api/data_objects/1.0/";
		if (id != null && !"".equals(id))
			apiUrl += id + ".json";
		String param = "format=json";

		WebAPI webapi = new WebAPI();
		webapi.setAPIurl(apiUrl);
		webapi.setParameter(param);
		String r = webapi.accessAPI();
		// System.out.println(r);
		
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
