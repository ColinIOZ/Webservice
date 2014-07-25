package org.big.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommonsUtil {
	public static void requestDispatcher(String path, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		 request.getRequestDispatcher(path).forward(request, response);
		 return;
	}
}
