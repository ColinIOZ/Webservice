package org.big.servlet;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.big.po.Title;
import org.big.util.CommonsUtil;
import org.big.util.ParseParamUtil;
import org.big.util.WebUtil;
import org.big.webapi.WebAPI;
import org.gbif.ecat.parser.UnparsableException;

import com.google.gson.Gson;

/**
 * Servlet implementation class TitleGetBHLData
 * 
 */
public class TitleGetBHLData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TitleGetBHLData() {
		super();
	}

	/**
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		
		try {
			String apiUrl = "http://www.biodiversitylibrary.org/api2/httpquery.ashx";
			String param = "op=TitleSearchSimple";
			if (title != null && !"".equals(title)) {
				if(title.indexOf(" ") != -1){
					
					title = title.replace(" ", "+");
				}
				param += "&title=" + title;
			}
			param += "&apikey=859d6fe4-b6cf-4765-8019-08b0d19bf4c0&format=json";
			WebAPI webapi = new WebAPI();
			webapi.setAPIurl(apiUrl);
			webapi.setParameter(param);
			String r = webapi.accessAPI();
			JsonConfig jc = new JsonConfig();
			String exclude[]={"PartNumber","PartName","CallNumber","Edition","PublicationFrequency",
					"Doi","TitleUrl","Authors","Subjects","Identifiers","Collections","Variants","Items"};
			jc.setExcludes(exclude);
			JSONObject jobject = JSONObject.fromObject(r,jc);
			
			Gson gson = new Gson();
			List<Title> titleSearchDataList = new ArrayList<Title>();
			if(jobject.getJSONArray("Result").size() != 0){
				
				for(int i = 0; i < jobject.getJSONArray("Result").size(); i++){
					Title data = new Title();
					data = gson.fromJson(jobject.getJSONArray("Result").getString(i), Title.class);
					titleSearchDataList.add(data);
				}
			}
			
			request.getSession().setAttribute("titleSearchDataList", titleSearchDataList);
			CommonsUtil.requestDispatcher("/resultData?flag=1&num=1", request, response);
			
		}catch(JSONException e){
			e.printStackTrace();
			
			out.print("{'Status':'ok','ErrorMessage':'格式错误。','Result':null}");
		}  

		out.flush();
		out.close();
	}

}
