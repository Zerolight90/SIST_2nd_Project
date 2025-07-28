import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class apiAdder {

    // DB 연결을 위한 정보
    private static final String DB_URL = "jdbc:mysql://localhost:3306/my_db?serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1111";

    // TMDB API 연동을 위한 정보
    private static final String API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzgzNzQyMjRkMDUzZjgyNTE4N2Q3NWNlN2Y4NTA1OSIsIm5iZiI6MTc1MzQzMDgyMS41MDMsInN1YiI6IjY4ODMzYjI1Yjk0ZTY2N2Y4YjUyYTQ1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aj9FVfDgUc-zPePdEXS1yj_VQDnEq6Yxh3c6uXwB2Mo"; // 발급받은 API 키
    private static final String API_URL = "https://api.themoviedb.org/3/movie/now_playing?include_adult=true&include_video=false&language=ko-KR&region=KR&page=1";

    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;

        // TMDB API 호출해서 데이터 가져오기
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn_api = (HttpURLConnection) url.openConnection();
            conn_api.setRequestMethod("GET");

            conn_api.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn_api.setRequestProperty("Content-Type", "application/json");

            conn_api.connect();

            int responseCode = conn_api.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                BufferedReader br = new BufferedReader(new InputStreamReader(conn_api.getInputStream()));
                StringBuffer sb = new StringBuffer();
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();

                String jsonResponse = sb.toString();

                // GSON으로 JSON 파싱
                JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
                JsonArray results = jsonObject.getAsJsonArray("results");

                // DB 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "INSERT INTO movies (movie_id, title, overview, poster_path, release_date, popularity, vote_average) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);

                // 영화 정보를 DB에 INSERT
                for (int i = 0; i < results.size(); i++) {
                    JsonObject movie = results.get(i).getAsJsonObject();

                    ps.setInt(1, movie.get("id").getAsInt());
                    ps.setString(2, movie.get("title").getAsString());
                    ps.setString(3, movie.get("overview").getAsString());
                    ps.setString(4, "https://image.tmdb.org/t/p/w500" + movie.get("poster_path").getAsString());
                    ps.setString(5, movie.get("release_date").getAsString());
                    ps.setDouble(6, movie.get("popularity").getAsDouble());
                    ps.setDouble(7, movie.get("vote_average").getAsDouble());

                    ps.executeUpdate();
                    System.out.println(movie.get("title").getAsString() + " 저장 완료!");
                }
            } else {
                System.out.println("API 호출 실패 : " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}