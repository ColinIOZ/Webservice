package org.big.webapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;


public class WebAPI {

	private String APIurl;
	private String parameter;
	
	public String accessAPI()
	{
		return sendGet(APIurl,parameter);
	}
	public  String sendGet(String url, String param) {
        String result = "";  
        BufferedReader in = null;  
        try {  
            String urlName = url + "?" + param;
           // System.out.println(urlName);
            URL realUrl = new URL(urlName);  
            // 打开和URL之间的连接  
            URLConnection conn = realUrl.openConnection();  
            // 设置通用的请求属性  
            conn.setRequestProperty("accept", "*/*");  
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("Accept-Charset", "utf-8");
            conn.setRequestProperty("Content-Type", "text/plain; charset=utf-8");
            //conn.setRequestProperty("Content-Encoding", "utf-8");
           // conn.setRequestProperty("user-agent",  
           //         "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");  
            // 建立实际的连接  
            conn.connect();
            // 获取所有响应头字段  
            
            // 定义BufferedReader输入流来读取URL的响应  
            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(),"UTF-8"));
            String line;  
            while ((line = in.readLine()) != null) {  
                result +=line;  
            }  
        } catch (Exception e) {  
            System.out.println("发送GET请求出现异常！" + e);  
            e.printStackTrace();  
        }  
        // 使用finally块来关闭输入流  
        finally {  
            try {  
                if (in != null) {  
                    in.close();  
                }  
            } catch (IOException ex) {  
                ex.printStackTrace();  
            }  
        }  
        return result;  
    }
	public String getAPIurl() {
		return APIurl;
	}
	public void setAPIurl(String aPIurl) {
		APIurl = aPIurl;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
}
