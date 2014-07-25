package org.big.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.big.po.Title;
import org.big.util.CommonsUtil;
import org.big.util.Constants;
import org.big.util.PageUtil;

public class ResultData extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String flag = request.getParameter("flag");
		switch (Integer.parseInt(flag)) {
		case 1:
			titleSearchResult(request, response);
			break;
		case 2:
			bookSearchResult(request, response);
			break;
		case 3:
			partSearchResult(request, response);
			break;
		case 4:
			nameSearchResult(request, response);
			break;
		default:
			break;
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	public void titleSearchResult(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String num = request.getParameter("num");
		if(request.getSession().getAttribute("titleSearchDataList") != null){
			
			List<Title> titleSearchDataList = (List<Title>) request.getSession().getAttribute("titleSearchDataList");
			if(titleSearchDataList.size() != 0){
				
				int rowCount = titleSearchDataList.size();
				PageUtil page = new PageUtil(Constants.PAGE_SIZE1, num, rowCount);	
				List<Title> tList =  new ArrayList<Title>();
				int start = page.getStartRow();
				int end = page.getStartRow()+page.getSize();
				if(end > rowCount){
					end = rowCount;
				}
				for(int i = start; i < end; i++){
					tList.add(titleSearchDataList.get(i));
				}
				request.getSession().setAttribute("tList", tList);
				request.setAttribute("page", page);
			}
		}
		CommonsUtil.requestDispatcher("/titlesimplesearchbhl.jsp", request, response);
	}
	public void bookSearchResult(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String num = request.getParameter("num");
		if(request.getSession().getAttribute("bookSearchDataList") != null){
			
			List<Map<String, Object>> bookSearchDataList = (List<Map<String, Object>>) request.getSession().getAttribute("bookSearchDataList");
			if(bookSearchDataList.size() != 0){
				
				int rowCount = bookSearchDataList.size();
				PageUtil page = new PageUtil(Constants.PAGE_SIZE, num, rowCount);	
				List<Map<String, Object>> bList =  new ArrayList<Map<String,Object>>();
				int start = page.getStartRow();
				int end = page.getStartRow()+page.getSize();
				if(end > rowCount){
					end = rowCount;
				}
				for(int i = start; i < end; i++){
					bList.add(bookSearchDataList.get(i));
				}
				request.getSession().setAttribute("bList", bList);
				request.setAttribute("page", page);
			}
		}
		CommonsUtil.requestDispatcher("/booksearchbhl.jsp", request, response);
	}
	public void partSearchResult(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String num = request.getParameter("num");
		if(request.getSession().getAttribute("partSearchDataList") != null){
			
			List<Map<String, Object>> partSearchDataList = (List<Map<String, Object>>) request.getSession().getAttribute("partSearchDataList");
			if(partSearchDataList.size() != 0){
				
				int rowCount = partSearchDataList.size();
				PageUtil page = new PageUtil(Constants.PAGE_SIZE, num, rowCount);	
				List<Map<String, Object>> pList =  new ArrayList<Map<String,Object>>();
				int start = page.getStartRow();
				int end = page.getStartRow()+page.getSize();
				if(end > rowCount){
					end = rowCount;
				}
				for(int i = start; i < end; i++){
					pList.add(partSearchDataList.get(i));
				}
				request.getSession().setAttribute("pList", pList);
				request.setAttribute("page", page);
			}
		}
		CommonsUtil.requestDispatcher("/partsearchbhl.jsp", request, response);
	}
	public void nameSearchResult(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		
		String num = request.getParameter("num");
		if(request.getSession().getAttribute("nameSearchDataList") != null){
			
			List<Map<String, Object>> nameSearchDataList = (List<Map<String, Object>>) request.getSession().getAttribute("nameSearchDataList");
			if(nameSearchDataList.size() != 0){
				
				int rowCount = nameSearchDataList.size();
				PageUtil page = new PageUtil(Constants.PAGE_SIZE, num, rowCount);	
				List<Map<String, Object>> nList =  new ArrayList<Map<String,Object>>();
				int start = page.getStartRow();
				int end = page.getStartRow()+page.getSize();
				if(end > rowCount){
					end = rowCount;
				}
				for(int i = start; i < end; i++){
					nList.add(nameSearchDataList.get(i));
				}
				request.getSession().setAttribute("nList", nList);
				request.setAttribute("page", page);
			}
		}
		CommonsUtil.requestDispatcher("/namesearchbhlnew.jsp", request, response);
	}

}
