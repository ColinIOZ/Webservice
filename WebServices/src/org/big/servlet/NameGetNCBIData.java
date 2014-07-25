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
import org.gbif.ecat.model.ParsedName;
import org.gbif.ecat.parser.NameParser;
import org.gbif.ecat.parser.UnparsableException;

/**
 * Servlet implementation class NameGetBHLData
 */
public class NameGetNCBIData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NameGetNCBIData() {
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
		String retstart=request.getParameter("retstart");
		try {
			if(scientificName != null && !"".equals(scientificName)){
				if(scientificName.indexOf(" ") != -1){
					scientificName = scientificName.replace(" ", "+");
				}
			}
			String apiUrl = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi";
			String param = "db=gene&term="+scientificName+"&retmode=json&retstart="+retstart;
			System.out.println(param);
			WebAPI wa = new WebAPI();
			wa.setAPIurl(apiUrl);
			wa.setParameter(param);
			String r = wa.accessAPI();
			
			JsonConfig jc=new JsonConfig();
			JSONObject job=JSONObject.fromObject(r,jc);
			int count = Integer.valueOf((String) job.getJSONObject("esearchresult").get("count")) ;
			int start = Integer.valueOf((String) job.getJSONObject("esearchresult").get("retstart")) ;
			System.out.println(job);
			if(job.getJSONObject("esearchresult").getJSONArray("idlist").size() > 0){
				
				String apiUrl2 = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi";
				String param2 = "db=gene&retmode=json&id=";
				for(int i = 0; i < job.getJSONObject("esearchresult").getJSONArray("idlist").size(); i++){
					param2 += job.getJSONObject("esearchresult").getJSONArray("idlist").getString(i)+",";
				}
				param2 = param2.substring(0,param2.length()-1);
				WebAPI wa2=new WebAPI();
				wa2.setAPIurl(apiUrl2);
				wa2.setParameter(param2);
				String r2 = wa2.accessAPI();
				JsonConfig jc2=new JsonConfig();
				JSONObject job2=JSONObject.fromObject(r2,jc2);
				job2.put("count", count);
				job2.put("start", start);
				System.out.println(job2);
				out.print(job2);
			}else{
				job.put("count", count);
				out.print(job);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}
		out.flush();
		out.close();
	}

}
