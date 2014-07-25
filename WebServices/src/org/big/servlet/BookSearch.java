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
import org.big.webapi.WebAPI;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
/**
 * Servlet implementation class BookSearch
 * 
 */
public class BookSearch extends HttpServlet{

	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookSearch() {
		super();
	}

	/**
	 *
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
		String volume = request.getParameter("volume");
		String edition = request.getParameter("edition");
		String year = request.getParameter("year");
		String subject = request.getParameter("subject");
		try {
			
			String apiUrl = "http://www.biodiversitylibrary.org/api2/httpquery.ashx";
			String param = "op=BookSearch";
			
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
				param += "&lname=" + author;
			}
			if (volume != null && !"".equals(volume)) {
				param += "&volume=" + volume;// ParseParamUtil.parseParam(volume);
			} 
			if (edition != null && !"".equals(edition)) {
				if(edition.indexOf(" ") != -1){
					
					edition = edition.replace(" ", "+");
				}
				param += "&edition=" + edition;
			} 
			if (year != null && !"".equals(year)) {
				param += "&year=" + year;//ParseParamUtil.parseParam(year);
			} 
			if (subject != null && !"".equals(subject)) {
				if(subject.indexOf(" ") != -1){
					
					subject = subject.replace(" ", "+");
				}
				param += "&subject=" + subject;
			} 
			param += "&apikey=859d6fe4-b6cf-4765-8019-08b0d19bf4c0&format=json";
			
			WebAPI webapi = new WebAPI();
			webapi.setAPIurl(apiUrl);
			webapi.setParameter(param);
			String r = webapi.accessAPI();
			JsonConfig jc = new JsonConfig();
			JSONObject jo = JSONObject.fromObject(r, jc);
			Gson gson = new Gson();
			List<Map<String, Object>> bookSearchDataList = new ArrayList<Map<String, Object>>();
			if(jo.getJSONArray("Result").size() != 0){
				
				bookSearchDataList = gson.fromJson(jo.getJSONArray("Result").toString(),
						new TypeToken<List<Map<String, Object>>>() {
				}.getType());
				
//			System.out.println(bookSearchDataList.get(0).get("TitleID"));
//			System.out.println(bookSearchDataList.get(0).get("Authors").toString());
//			
//			JSONArray ja = JSONArray.fromObject(bookSearchDataList.get(0).get("Authors")) ;
//			List<Authors> authors = new ArrayList<Authors>();
//			authors = gson.fromJson(ja.toString(), new TypeToken<List<Authors>>() {
//            }.getType());
//			System.out.println(authors.get(0).getCreatorID());
			}
			
			request.getSession().setAttribute("bookSearchDataList", bookSearchDataList);
			CommonsUtil.requestDispatcher("/resultData?flag=2&num=1", request, response);
			
		} catch(JSONException e){
			e.printStackTrace();
			
			out.print("{'Status':'ok','ErrorMessage':'格式错误。','Result':null}");
		} 
		out.flush();
		out.close();
	}
	

}
