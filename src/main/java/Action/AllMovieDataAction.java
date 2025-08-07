package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class AllMovieDataAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("\n[Debug] AllMovieDataAction.execute() 시작 ============================");

        final String API_BEARER_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzgzNzQyMjRkMDUzZjgyNTE4N2Q3NWNlN2Y4NTA1OSIsIm5iZiI6MTc1MzQzMDgyMS41MDMsInN1YiI6IjY4ODMzYjI1Yjk0ZTY2N2Y4YjUyYTQ1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aj9FVfDgUc-zPePdEXS1yj_VQDnEq6Yxh3c6uXwB2Mo";
        final String BASE_URL = "https://api.themoviedb.org/3";

        try {
            String tab = request.getParameter("tab");
            String page = request.getParameter("page");
            String query = request.getParameter("query");

            if (page == null || page.isEmpty()) page = "1";
            if (tab == null) tab = "boxoffice";

            System.out.println("[Debug] 받은 파라미터: tab=" + tab + ", page=" + page + ", query=" + query);

            String apiUrl;
            if (query != null && !query.isEmpty()) {
                apiUrl = BASE_URL + "/search/movie?query=" + URLEncoder.encode(query, "UTF-8") + "&language=ko-KR&page=" + page;
            } else {
                String endpoint = getEndpointForTab(tab);
                String separator = endpoint.contains("?") ? "&" : "?";
                apiUrl = BASE_URL + endpoint + separator + "language=ko-KR&page=" + page;
            }
            System.out.println("[Debug] TMDB API 요청 URL: " + apiUrl);

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + API_BEARER_TOKEN);

            int responseCode = conn.getResponseCode();
            System.out.println("[Debug] TMDB 응답 코드: " + responseCode);

            if (responseCode != 200) {
                System.err.println("[Debug] TMDB API 오류 메시지: " + conn.getResponseMessage());
                throw new RuntimeException("Failed : HTTP error code : " + responseCode);
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder jsonResponse = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                jsonResponse.append(line);
            }
            br.close();
            conn.disconnect();

            String responseString = jsonResponse.toString();

            // --- 응답 처리 부분 ---
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(responseString);

            // ▼▼▼ 핵심 코드: 응답을 여기서 완전히 종료시켜 컨트롤러의 추가 동작을 막습니다. ▼▼▼
            response.getWriter().close();

            System.out.println("[Debug] 클라이언트에 JSON 데이터 전송 및 응답 종료 완료.");

        } catch (Exception e) {
            System.err.println("[Debug] AllMovieDataAction 처리 중 예외 발생!");
            e.printStackTrace();
            try {
                if (!response.isCommitted()) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().print("{\"error\":\"An error occurred on the server.\"}");
                    response.getWriter().close();
                }
            } catch (Exception ioException) {
                System.err.println("[Debug] 예외 응답 전송 중 추가 예외 발생!");
                ioException.printStackTrace();
            }
        }

        System.out.println("[Debug] AllMovieDataAction.execute() 종료 ============================\n");
        // 컨트롤러의 로직을 타긴 하지만, 응답이 이미 종료되었으므로 무시됩니다.
        return "/allmovie/allmovie.jsp";
    }

    private String getEndpointForTab(String tab) {
        switch (tab) {
            case "scheduled":
                return "/movie/upcoming";
            case "sistonly":
                return "/discover/movie?with_keywords=188433";
            case "filmsociety":
                return "/movie/top_rated";
            case "classicsociety":
                return "/discover/movie?with_genres=36&sort_by=release_date.desc";
            case "boxoffice":
            default:
                return "/movie/now_playing";
        }
    }
}
