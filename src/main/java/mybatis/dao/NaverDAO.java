package mybatis.dao;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import util.ConfigUtil;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

public class NaverDAO {

    private final String CLIENT_ID = ConfigUtil.getProperty("naver.api.key");
    private final String REDIRECT_URI = ConfigUtil.getProperty("naver.redirect.uri");
    private static String clientSecret = ConfigUtil.getProperty("naver.client.secret");


    // 인가 코드로 액세스 토큰 발급 (GET)
    public String getAccessToken(String code, String state) throws Exception {
        String reqURL = "https://nid.naver.com/oauth2.0/token"
                + "?grant_type=authorization_code"
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(clientSecret, "UTF-8")
                + "&code=" + URLEncoder.encode(code, "UTF-8")
                + "&state=" + URLEncoder.encode(state, "UTF-8");

        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) response.append(line);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.toString());
            return root.has("access_token") ? root.get("access_token").asText() : null;
        } finally {
            conn.disconnect();
        }
    }

    // access token으로 프로필 조회 및 필요한 필드 반환
    public Map<String, String> getUserInfo(String accessToken) throws Exception {
        String reqURL = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = conn.getResponseCode();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) response.append(line);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.toString());
            JsonNode resp = root.path("response");

            Map<String, String> userInfo = new HashMap<>();
            userInfo.put("id", resp.has("id") && !resp.get("id").isNull() ? resp.get("id").asText() : null);
            // 네이버 프로필에서 이름 필드(일부 API는 name 또는 nickname 제공)
            userInfo.put("name", resp.has("name") && !resp.get("name").isNull() ? resp.get("name").asText()
                    : (resp.has("nickname") && !resp.get("nickname").isNull() ? resp.get("nickname").asText() : null));
            userInfo.put("email", resp.has("email") && !resp.get("email").isNull() ? resp.get("email").asText() : null);
            userInfo.put("birthday", resp.has("birthday") && !resp.get("birthday").isNull() ? resp.get("birthday").asText() : null);
            userInfo.put("gender", resp.has("gender") && !resp.get("gender").isNull() ? resp.get("gender").asText() : null);
            userInfo.put("phone", resp.has("mobile") && !resp.get("mobile").isNull() ? resp.get("mobile").asText() : null);
            userInfo.put("birthYear", resp.has("birthyear") && !resp.get("birthyear").isNull() ? resp.get("birthyear").asText() : null);

            return userInfo;
        } finally {
            conn.disconnect();
        }
    }

    // 연동해제(토큰 삭제) - grant_type=delete
    public boolean deleteToken(String accessToken) throws Exception {
        String reqURL = "https://nid.naver.com/oauth2.0/token"
                + "?grant_type=delete"
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(clientSecret, "UTF-8")
                + "&access_token=" + URLEncoder.encode(accessToken, "UTF-8")
                + "&service_provider=NAVER";

        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            return responseCode == 200;
        } finally {
            conn.disconnect();
        }
    }
}
