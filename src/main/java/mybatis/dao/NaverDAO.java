package mybatis.dao;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import util.ConfigUtil;
import mybatis.vo.NaverVO;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class NaverDAO {

    private final String CLIENT_ID = ConfigUtil.getProperty("naver.api.key");
    private static final String CLIENT_SECRET = ConfigUtil.getProperty("naver.client.secret");

    public String getAccessToken(String code, String state) throws Exception {
        String reqURL = "https://nid.naver.com/oauth2.0/token"
                + "?grant_type=authorization_code"
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&code=" + URLEncoder.encode(code, "UTF-8")
                + "&state=" + URLEncoder.encode(state, "UTF-8");

        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        System.out.println("사용자 정보 응답 코드 : " + responseCode);


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

    public NaverVO buildNaverVoFromMap(Map<String, String> userInfo) {
        NaverVO vo = new NaverVO();
        if (userInfo == null) return vo;

        vo.setN_id(userInfo.get("id"));
        vo.setN_name(userInfo.get("name"));
        vo.setN_email(userInfo.get("email"));
        vo.setN_gender(userInfo.get("gender"));
        vo.setN_Phone(userInfo.get("phone"));
        vo.setBirthYear(userInfo.get("birthYear"));

        String birthYear = userInfo.get("birthYear");        // ex: "1995"
        String birthday = userInfo.get("birthday");          // ex: "05-24" 또는 "05/24" 또는 "0524"

        if (birthYear != null && birthday != null && !birthYear.trim().isEmpty() && !birthday.trim().isEmpty()) {
            String norm = birthday.replace("/", "").replace("-", "").trim(); // -> "0524"
            if (norm.length() == 4) {
                try {
                    int year = Integer.parseInt(birthYear.trim());
                    int month = Integer.parseInt(norm.substring(0, 2));
                    int day = Integer.parseInt(norm.substring(2, 4));
                    LocalDate birthDate = LocalDate.of(year, month, day);
                    vo.setN_birthday(birthDate.toString()); // yyyy-MM-dd
                } catch (NumberFormatException | DateTimeException e) {
                    vo.setN_birthday(null);
                    //
                }
            } else {
                vo.setN_birthday(null);
            }
        } else {
            vo.setN_birthday(null);
        }

        return vo;
    }

    public boolean deleteToken(String accessToken) throws Exception {

        if (accessToken == null || accessToken.trim().isEmpty()) return false;

        // service_provider 파라미터를 반드시 포함하도록 수정
        String reqURL = "https://nid.naver.com/oauth2.0/token"
                + "?grant_type=delete"
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&access_token=" + URLEncoder.encode(accessToken, "UTF-8")
                + "&service_provider=" + URLEncoder.encode("NAVER", "UTF-8");

        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);

        int responseCode = conn.getResponseCode();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) sb.append(line);
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(sb.toString());

            if (root.has("error")) {
                String err = root.path("error").asText();
                String desc = root.path("error_description").asText(null);
                System.out.println("Naver delete token error: " + err + " / " + desc);
                return false;
            }

            if (root.has("result")) {
                String result = root.get("result").asText();
                return "success".equalsIgnoreCase(result) || "ok".equalsIgnoreCase(result);
            }

            return responseCode == 200;
        } finally {
            conn.disconnect();
        }
    }
}
