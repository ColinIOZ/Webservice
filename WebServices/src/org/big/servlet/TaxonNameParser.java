package org.big.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.gbif.ecat.model.ParsedName;
import org.gbif.ecat.parser.NameParser;
import org.gbif.ecat.parser.UnparsableException;

/**
 * Servlet implementation class TaxonNameParser
 */
public class TaxonNameParser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaxonNameParser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		String sciname=request.getParameter("name");
		NameParser np=new NameParser();
		try {
			ParsedName<Object> pn=np.parse(NameParser.normalize(sciname));
			JSONObject job=new JSONObject();
			job.element("CanonicalName", pn.canonicalName());
			job.element("FullScientificName", pn.fullName());
			job.element("Author", pn.getAuthorship()==null?pn.getBracketAuthorship():pn.getAuthorship());
			job.element("Year", pn.getYear()==null?pn.getBracketYear():pn.getYear());
			job.element("Author&Year", pn.authorshipComplete());
			job.element("Genus_or_Above", pn.getGenusOrAbove());
			job.element("Epithet", pn.getSpecificEpithet());
			job.element("InfraSpecificEpithet", pn.getInfraSpecificEpithet());
			job.element("Rank", pn.getRank());
			job.element("RankMarker", pn.getRankMarker());
			job.element("ParsableType", pn.isParsableType());
			//System.out.println(pn.canonicalSpeciesName());
			out.print(job);
			
		} catch (UnparsableException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		out.flush();
		out.close();
	}

}
