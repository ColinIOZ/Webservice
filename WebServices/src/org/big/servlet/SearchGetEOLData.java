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

import org.big.util.CommonsUtil;
import org.big.webapi.WebAPI;

public class SearchGetEOLData extends HttpServlet {

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

		String q = request.getParameter("q");
		String page = request.getParameter("page");
		String exact = request.getParameter("exact");

		String apiUrl = "http://eol.org/api/search/1.0.json";
		String param = "";
		if (q != null && !"".equals(q)) {
			if (q.indexOf(" ") != -1) {
				q = q.replace(" ", "+");
			}
			param += "q=" + q;
		}
		if (page != null && !"".equals(page))
			param += "&page=" + page;
		if (exact != null && !"".equals(exact))
			param += "&exact=" + exact;
		param += "&format=json";
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

