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
import org.big.util.ParseParamUtil;
import org.big.util.WebUtil;
import org.big.webapi.WebAPI;
import org.gbif.ecat.parser.UnparsableException;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
/**
 * Servlet implementation class PartSearch
 * 
 */
public class PartSearch extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PartSearch() {
		super();
	}

	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/json,utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String container = request.getParameter("container");
		String date = request.getParameter("date");
		String volume = request.getParameter("volume");
		String series = request.getParameter("series");
		String issue = request.getParameter("issue");
		try {
			
			
			String apiUrl = "http://www.biodiversitylibrary.org/api2/httpquery.ashx";
			String param = "op=PartSearch";
			if (title != null && !"".equals(title)) {
				if(title.indexOf(" ") != -1){
					
					title = title.replace(" ", "+");
				}
				param += "&title=" + title;
			}
			if (author != null && !"".equals(author)) {
				if(author.indexOf(" ") != -1){
					
					author = author.replace(" ", "+");
				}
				param += "&author=" + author;
			}
			if (container != null && !"".equals(container)) {
				if(container.indexOf(" ") != -1){
					
					container = container.replace(" ", "+");
				}
				param += "&containerTitle=" + container;
			}
			if (date != null && !"".equals(date)) {
				param += "&date=" + date;
			}
			if (volume != null && !"".equals(volume)) {
				param += "&volume=" + volume;
			}
			if (series != null && !"".equals(series)) {
				if(series.indexOf(" ") != -1){
					
					series = series.replace(" ", "+");
				}
				param += "&series=" + series;
			}
			if (issue != null && !"".equals(issue)) {
				if(issue.indexOf(" ") != -1){
					
					issue = issue.replace(" ", "+");
				}
				param += "&issue=" + issue;
			}
			param += "&apikey=859d6fe4-b6cf-4765-8019-08b0d19bf4c0&format=json";
			
			WebAPI webapi = new WebAPI();
			webapi.setAPIurl(apiUrl);
			webapi.setParameter(param);
			String r = webapi.accessAPI();
			JsonConfig jc = new JsonConfig();
			JSONObject jo = JSONObject.fromObject(r, jc);
			
			Gson gson = new Gson();
			List<Map<String, Object>> partSearchDataList = new ArrayList<Map<String, Object>>();
			if(jo.getJSONArray("Result").size() != 0){
				
				partSearchDataList = gson.fromJson(jo.getJSONArray("Result").toString(),
                    new TypeToken<List<Map<String, Object>>>() {
                    }.getType());
			}
			request.getSession().setAttribute("partSearchDataList", partSearchDataList);
			CommonsUtil.requestDispatcher("/resultData?flag=3&num=1", request, response);
			
			
		} catch(JSONException e){
			e.printStackTrace();
			
			out.print("{'Status':'ok','ErrorMessage':'格式错误。','Result':null}");
		}
		out.flush();
		out.close();
	}
	
}
