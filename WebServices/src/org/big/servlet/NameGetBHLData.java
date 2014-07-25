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
public class NameGetBHLData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NameGetBHLData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();
		String scientificName=request.getParameter("scientificName");
		NameParser np=new NameParser();
		try {
			ParsedName<Object> pn=np.parse(scientificName);
			String combinedName="";
			combinedName=pn.getGenusOrAbove();
			combinedName+=pn.getSpecificEpithet()==null?"":"+"+pn.getSpecificEpithet();
			combinedName+=pn.getInfraSpecificEpithet()==null?"":"+"+pn.getInfraSpecificEpithet();
			//String canonicalName=pn.canonicalName();
			String NameGetDetail="http://www.biodiversitylibrary.org/api2/httpquery.ashx";
			String param="op=NameGetDetail&name="+combinedName+"&apikey=859d6fe4-b6cf-4765-8019-08b0d19bf4c0&format=json";
			WebAPI wa=new WebAPI();
			wa.setAPIurl(NameGetDetail);
			wa.setParameter(param);
			String r=wa.accessAPI();
			JsonConfig jc=new JsonConfig();
			String exclude[]={"NameBankID","EOLID","NameFound","BibliographicLevel","PartName","PartNumber","PublicationFrequency","Doi","TitleUrl","Subjects","Identifiers",
					"Collections","Variants","ItemID","PrimaryTitleID","ThumbnailPageID","Source","SourceIdentifier","Contributor","Sponsor","LicenseUrl","Rights","DueDiligence","CopyrightStatus",
					"CopyrightRegion","ItemUrl","TitleUrl","ItemThumbUrl"};
			jc.setExcludes(exclude);
			JSONObject job=JSONObject.fromObject(r,jc);
			int count=job.getJSONObject("Result").getJSONArray("Titles").size();
			//if(count>=5)
			//System.out.println(r);
			out.print(job);
			
		} catch (UnparsableException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.print("{}");
		}
		catch(JSONException e)
		{
			e.printStackTrace();
			
			out.print("{'Status':'ok','ErrorMessage':'格式错误。','Result':null}");
		}
		out.flush();
		out.close();
	}

}
