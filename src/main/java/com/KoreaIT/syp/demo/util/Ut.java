package com.KoreaIT.syp.demo.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Ut {
	private HttpServletRequest req;
	private HttpServletResponse resp;

	public static boolean empty(Object obj) {
		
		if (obj == null) {
			return true;
		}
		
		if (obj instanceof Integer) {
			return (int) obj == 0;
		}

		if (obj instanceof String == false) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;
	}
	
	public static String f(String format, Object... args) {
		return String.format(format, args);
	}
	
	public static String jsHistoryBack(String resultCode, String msg) {
		if (msg == null) {
			msg = "";
		}
		
		return Ut.f("""
				<script>
					const msg = '%s'.trim();
					if (msg.length > 0) {
						alert(msg);
					}
					history.back();
				</script>
				""", msg);
	}

	public static String jsReplace(String msg, String uri) {
		if (msg == null) {
			msg = "";
		}
		
		if (uri == null) {
			uri = "/";
		}
		
		return Ut.f("""
					<script>
						const msg = '%s'.trim();
						if (msg.length > 0) {
							alert(msg);
						}
						location.replace('%s');
					</script>
					""", msg, uri);
	}
	
	public static String jsReplace(String resultCode, String msg, String uri) {
		if (msg == null) {
			msg = "";
		}
		
		if (uri == null) {
			uri = "/";
		}

		return Ut.f("""
					<script>
						const msg = '%s'.trim();
						if ( msg.length > 0 ){
							alert(msg);
						}
						location.replace('%s');
					</script>
					""", msg, uri);
	}

	
	public static String jsHitoryBackOnView(HttpServletRequest req, String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);

		return "usr/common/js";
	}
	
	public static String getEncodedCurrentUri(String currentUri) {

		try {
			return URLEncoder.encode(currentUri, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return currentUri;
		}
	}
	
	public static String getEncodedUri(String uri) {
		try {
			return URLEncoder.encode(uri, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return uri;
		}
	}
	
	public static Map<String, String> getParamMap(HttpServletRequest req) {
		Map<String, String> param = new HashMap<>();
		
		// 열거형
		Enumeration<String> parameterNames = req.getParameterNames();
		
		// 다음 요소가 없을 때까지 반복
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();		// replaceUri
			String paramValue = req.getParameter(paramName);		// /usr/article/write

			param.put(paramName, paramValue);
		}

		return param;
	}
	
	public static String getAttr(Map map, String attrName, String defaultValue) {
		// map에 key(attrName) 있는지 확인
		if (map.containsKey(attrName)) {
			return (String) map.get(attrName);
		}

		return defaultValue;
	}

	// 비밀번호 암호화
	public static String SHA256(String input) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hash = md.digest(input.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			return hexString.toString();
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// 임시 비밀번호 생성
	public static String getTempPassword(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());	// 난수 발생
			sb.append(charArr[index]);
		}

		return sb.toString();	// 문자열로 반환
	}

}
