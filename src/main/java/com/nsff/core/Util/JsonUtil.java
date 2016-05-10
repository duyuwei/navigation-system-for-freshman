package com.nsff.core.Util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

public class JsonUtil {
	public static void fromMapToJson(Map<String, Object> json,HttpServletResponse response){
		PrintWriter out = null;
		response.setContentType("text/html;charset=utf-8");
		try {
			out = response.getWriter();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		JSONObject jsonObject = new JSONObject(json);
		
		out.write(jsonObject.toString());
		out.flush();
		out.close();
	}
}
