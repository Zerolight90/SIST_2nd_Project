package mybatis.dao;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import util.ConfigUtil;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class KakaoDAO {

    // !!! 중요: 발급받은 실제 REST API 키로 변경하세요 !!!
    private static String getApiKey() {
        return ConfigUtil.getProperty("kakao.api.key");
    }
    // !!! 중요: 카카오 개발자 센터에 등록한 Redirect URI와 정확히 일치해야 합니다 !!!
    private static String getRedirectUri() {
        return ConfigUtil.getProperty("kakao.redirect.uri");
    }

//    String apiKey = getApiKey();
//    String redirectUri = getRedirectUri();

    // 인가 코드를 받아 액세스 토큰을 반환하는 메서드
    public String getAccessToken(String code) throws Exception {

        String reqURL = "https://kauth.kakao.com/oauth/token";
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        StringBuilder postParams = new StringBuilder();
        postParams.append("grant_type=authorization_code");
        postParams.append("&client_id=").append(getApiKey());
        postParams.append("&redirect_uri=").append(getRedirectUri());
        postParams.append("&code=").append(code);

        try (DataOutputStream dos = new DataOutputStream(conn.getOutputStream())) {
            dos.write(postParams.toString().getBytes("UTF-8")); // UTF-8 명시
            dos.flush();
        }

        int responseCode = conn.getResponseCode();
        System.out.println("카카오 토큰 발급 요청: code=" + code);
        System.out.println("카카오 토큰 요청 파라미터: " + postParams); // 로그 추가

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {
            StringBuilder responseSB = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                responseSB.append(line);
            }

            System.out.println("카카오 토큰 발급 응답 : " + responseSB);
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(responseSB.toString());

            if (rootNode.has("error")) { // 상세한 오류처리
                String err = rootNode.has("error_description") ? rootNode.get("error_description").asText() : rootNode.get("error").asText();
                System.err.println("카카오 토큰 발급 오류: " + err);
            }

            return rootNode.has("access_token") ? rootNode.get("access_token").asText() : null;
        } finally {
            conn.disconnect();
        }
    }

    // 액세스 토큰을 사용하여 사용자 정보를 반환하는 메서드
    public Map<String, String> getUserInfo(String accessToken) throws Exception {
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = conn.getResponseCode();
        System.out.println("사용자 정보 응답 코드 : " + responseCode);

        System.out.println("카카오 User Info 요청: accessToken=" + accessToken);

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {

            StringBuilder responseSB = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) responseSB.append(line);
            System.out.println("카카오 User Info 응답: " + responseSB);
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(responseSB.toString());

            Map<String, String> userInfo = new HashMap<>();
            if (rootNode.has("id")) userInfo.put("id", rootNode.get("id").asText());
            JsonNode kakaoAccount = rootNode.path("kakao_account");
            userInfo.put("email", kakaoAccount.has("email") && !kakaoAccount.get("email").isNull() ? kakaoAccount.get("email").asText() : null);
            JsonNode profile = kakaoAccount.path("profile");
            userInfo.put("nickname", (!profile.isMissingNode() && profile.has("nickname") && !profile.get("nickname").isNull()) ? profile.get("nickname").asText() : null);

            // 한글 깨짐 여부를 로그로 체크
            System.out.println("User Info 추출결과: id=" + userInfo.get("id") + ", email=" + userInfo.get("email") + ", nickname=" + userInfo.get("nickname"));
            return userInfo;

        } finally {
            conn.disconnect();
        }
    }

    // 추가: 카카오 로그아웃 API 호출 메서드
    public boolean logout(String accessToken) throws Exception {

        String reqURL = "https://kapi.kakao.com/v1/user/logout"; // 카카오 로그아웃 API 엔드포인트
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST"); // POST 방식으로 요청
        conn.setRequestProperty("Authorization", "Bearer " + accessToken); // 액세스 토큰을 Bearer 토큰으로 전달
        conn.setDoOutput(true); // 출력 스트림을 사용하여 데이터 전송 (필수)

        int responseCode = conn.getResponseCode();
        System.out.println("카카오 로그아웃 응답 코드 : " + responseCode);

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"))) {
            StringBuilder responseSB = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                responseSB.append(line);
            }

            System.out.println("카카오 로그아웃 응답 내용: " + responseSB.toString());

            // 응답 코드가 200이면 성공으로 간주
            return responseCode == 200;

        } finally {
            conn.disconnect();
        }
    }
}
