/***********************************************************************
 * FileName:  WebUtil.java
 * CopyRright (c) 2013: Biodiversity Informatics Group of IOZ, all right reserved
 * FileID：f1
 * Author：LHH@BIG.IOZ
 * Create Date：2013-8-23
 * Modified by：
 * Modified Date：
 * Comments：This class is a util to display information and jump to the specified page.
 * Version：0.1.0
 ***********************************************************************/
package org.big.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.validator.GenericValidator;
/** CopyRright (c) 2013: Biodiversity Informatics Group of IOZ, all right reserved
 * Project: authorization
 * Module ID:
 * Comments:
 * JDK version used: <JDK1.7>
 * Namespace: <命名空间>
 * Author：LHH@BIG.IOZ
 * Create Date：2013-8-23
 * Modified By：
 * Modified Date:
 * Why & What is modified:
 * Version: 0.1.0
 * 
 */
public class WebUtil {

	/**
	 * The pop-up dialog displays information and jump to the specified page
	 * @param request
	 * @param response
	 * @param message : information
	 * @param path : Jump path, relative engineering path ,to/at the beginning
	 * @param : Whether the parent window
	 * @throws IOException
	 */
	public static void alert(HttpServletRequest request,
			HttpServletResponse response, String message, String path,
			boolean parent) throws IOException {
		PrintWriter out = null;
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			out.write("<script type='text/javascript'>");
			out.write("alert('" + message + "');");
			if (parent) {
				out.write("parent.");
			}
			if (GenericValidator.isBlankOrNull(path)) {
				path = request.getHeader("Referer");
				out.write("window.location.href='" + path + "';");
			} else {
				out.write("window.location.href='" + request.getContextPath()
						+ path + "';");
			}
			out.write("</script>");
			out.flush();
		} finally {
			if (out != null)
				out.close();
		}
	}
	public static void goTo(HttpServletRequest request,
			HttpServletResponse response, String path,
			boolean parent) throws IOException {
		PrintWriter out = null;
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			out.write("<script type='text/javascript'>");
			if (parent) {
				out.write("parent.");
			}
			if (GenericValidator.isBlankOrNull(path)) {
				path = request.getHeader("Referer");
				out.write("window.location.href='" + path + "';");
			} else {
				out.write("window.location.href='" + request.getContextPath()
						+ path + "';");
			}
			out.write("</script>");
			out.flush();
		} finally {
			if (out != null)
				out.close();
		}
	}

	public static void print(HttpServletResponse response, String contentType,
			String message) throws IOException {
		String defualtContentType = "text/html";
		contentType = GenericValidator.isBlankOrNull(contentType) ? defualtContentType
				: contentType;
		response.setContentType(contentType);
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(message);
			out.flush();

		} finally {
			if (out != null)
				out.close();
		}
	}

}
