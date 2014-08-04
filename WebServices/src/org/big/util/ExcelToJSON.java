package org.big.util;

import jxl.*;
import jxl.write.Label;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

import org.big.webapi.WebAPI;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class ExcelToJSON {
	private static final String QUOTATION_MARKS = "\""; // 双引号
	private static final String COMMA = ","; // 逗号

	//拼凑jsonArray
	public static StringBuffer convertToJsonArray(String[][] srcArray) {

		StringBuffer stringBuffer = new StringBuffer();
		boolean first = true;
		stringBuffer.append("[");

		for (int i = 0; i < srcArray.length; i++) {
			String[] arrayItem = srcArray[i];
			if (!first) {
				stringBuffer.append(COMMA);
			}
			stringBuffer.append("{");

			boolean first2 = true;
			for (int j = 0; j < arrayItem.length; j++) {

				if (!first2) {
					stringBuffer.append(COMMA);
				}
				stringBuffer.append(QUOTATION_MARKS + "field" + j
						+ QUOTATION_MARKS + ":\"" + arrayItem[j]
						+ QUOTATION_MARKS);
				first2 = false;
			}
			stringBuffer.append("}");
			first = false;
		}

		stringBuffer.append("]");
		return stringBuffer;

	}

	public static void returnJSONFile() {
		jxl.Workbook rwb = null;
		try {
			// 构建Workbook对象, 只读Workbook对象
			// 直接从本地文件创建Workbook
			// 从输入流创建Workbook
			InputStream is = new FileInputStream("src/ISO-3166.xls");
			rwb = Workbook.getWorkbook(is);

			// Sheet(术语：工作表)就是Excel表格左下角的Sheet1,Sheet2,Sheet3但在程序中
			// Sheet的下标是从0开始
			// 获取第一张Sheet表
			Sheet rs = rwb.getSheet(0);
			// 获取Sheet表中所包含的总列数
			int rsColumns = rs.getColumns();
			// 获取Sheet表中所包含的总行数
			int rsRows = rs.getRows();
			// 获取指定单元格的对象引用
			String[][] excelContent = new String[rsRows][rsColumns];
			for (int i = 0; i < rsRows; i++) {
				for (int j = 0; j < rsColumns; j++) {

					excelContent[i][j] = rs.getCell(j, i).getContents();

				}
			}
			StringBuffer data = new StringBuffer("");
			data.append("{");
			data.append("\"total\":" + excelContent.length + ",");
			data.append("\"results\":" + convertToJsonArray(excelContent));
			data.append("}");
			
			//将json数据写入文件
			String path = System.getProperty("user.dir") + "\\WebContent\\json\\countryCode.json";
			FileWriter fw = new FileWriter(path);
		    PrintWriter out = new PrintWriter(fw);
		    out.write(data.toString());
		    out.println();
		    fw.close();
		    out.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 操作完成时，关闭对象，释放占用的内存空间
			rwb.close();

		}

	}
	public static void returnDBJSONFile() {
		try {
			String apiUrl = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/einfo.fcgi";
			String param = "retmode=json";
			WebAPI wa = new WebAPI();
			wa.setAPIurl(apiUrl);
			wa.setParameter(param);
			String data = wa.accessAPI();
			
			//将json数据写入文件
			String path = System.getProperty("user.dir") + "\\WebContent\\json\\db.json";
			FileWriter fw = new FileWriter(path);
			PrintWriter out = new PrintWriter(fw);
			out.write(data.toString());
			out.println();
			fw.close();
			out.close();
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}


	public static void main(String[] args) {
		ExcelToJSON.returnDBJSONFile();
	}
}
