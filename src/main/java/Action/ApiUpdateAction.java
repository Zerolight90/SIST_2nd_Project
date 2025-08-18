package Action;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApiUpdateAction implements Action {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/web_movie?serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1111";
    private static final String API_KEY_V4 = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzgzNzQyMjRkMDUzZjgyNTE4N2Q3NWNlN2Y4NTA1OSIsIm5iZiI6MTc1MzQzMDgyMS41MDMsInN1YiI6IjY4ODMzYjI1Yjk0ZTY2N2Y4YjUyYTQ1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aj9FVfDgUc-zPePdEXS1yj_VQDnEq6Yxh3c6uXwB2Mo";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement ps = null;
        int successCount = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT IGNORE INTO movie (mIdx, name, synop, poster, date, gen, actor, dir, age, runtime, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '상영중')";
            ps = conn.prepareStatement(sql);

            for (int page = 1; page <= 6; page++) { // 페이지 수를 조절하여 가져올 데이터 양 결정
                String listApiUrl = "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&region=KR&page=" + page;
                JsonArray movieList = getMovieListFromServer(listApiUrl);
                if (movieList == null) continue;

                for (JsonElement movieElement : movieList) {
                    JsonObject movieSummary = movieElement.getAsJsonObject();
                    String movieId = movieSummary.get("id").getAsString();
                    JsonObject movieDetails = getMovieDetails(movieId);
                    if (movieDetails == null) continue;

                    String genres = parseGenres(movieDetails);
                    int runtime = movieDetails.has("runtime") && !movieDetails.get("runtime").isJsonNull() ? movieDetails.get("runtime").getAsInt() : 0;
                    String director = parseDirector(movieDetails);
                    String actors = parseActors(movieDetails);
                    String ageRating = parseKoreanAgeRating(movieDetails);

                    ps.setInt(1, movieSummary.get("id").getAsInt());
                    ps.setString(2, movieSummary.get("title").getAsString());
                    ps.setString(3, movieSummary.get("overview").isJsonNull() ? "" : movieSummary.get("overview").getAsString());
                    ps.setString(4, "https://image.tmdb.org/t/p/w500" + (movieSummary.get("poster_path").isJsonNull() ? "" : movieSummary.get("poster_path").getAsString()));
                    ps.setString(5, movieSummary.get("release_date").getAsString());
                    ps.setString(6, genres);
                    ps.setString(7, actors);
                    ps.setString(8, director);
                    ps.setString(9, ageRating);
                    ps.setInt(10, runtime);

                    int result = ps.executeUpdate();
                    if(result > 0) {
                        successCount++; // INSERT 성공 시 카운트 증가
                    }
                    Thread.sleep(40);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 클라이언트에 에러 메시지 전송
            try {
                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");

                out.flush();
                out.close();
            } catch (Exception ex) {
                e.printStackTrace();
            }

            return null;
        } finally {
            closeDbResources(ps, conn);
        }

        // 모든 작업 완료 후 클라이언트에 성공 메시지 전송
        try {
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"success\", \"message\":\"" + successCount + "개의 새로운 영화 정보가 추가되었습니다.\"}");

            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // AJAX 응답이므로 forward할 페이지 없음
    }

    private String getResponseString(String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY_V4);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.connect();

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            String line;
            StringBuilder sb = new StringBuilder();
            while((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();
            return sb.toString();
        }
        return null;
    }
    private JsonArray getMovieListFromServer(String apiUrl) throws Exception {
        String jsonResponse = getResponseString(apiUrl);
        if (jsonResponse != null) {
            return JsonParser.parseString(jsonResponse).getAsJsonObject().getAsJsonArray("results");
        }
        return null;
    }
    private JsonObject getMovieDetails(String movieId) throws Exception {
        String detailApiUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?language=ko-KR&append_to_response=credits,release_dates";
        String jsonResponse = getResponseString(detailApiUrl);
        if (jsonResponse != null) {
            return JsonParser.parseString(jsonResponse).getAsJsonObject();
        }
        return null;
    }

    // 장르 정보 파싱을 위한 헬퍼 메소드 추가
    private String parseGenres(JsonObject movieDetails) {
        if (movieDetails.has("genres")) {
            JsonArray genresArray = movieDetails.getAsJsonArray("genres");
            StringBuilder genres = new StringBuilder();
            for (int i = 0; i < genresArray.size(); i++) {
                if (i > 0) genres.append(", ");
                genres.append(genresArray.get(i).getAsJsonObject().get("name").getAsString());
            }
            return genres.toString();
        }
        return "정보 없음";
    }

    // ... parseDirector, parseActors, parseKoreanAgeRating, closeDbResources 메소드는 기존과 동일 ...
    private String parseDirector(JsonObject movieDetails) {
        JsonObject credits = movieDetails.getAsJsonObject("credits");
        if (credits != null) {
            JsonArray crew = credits.getAsJsonArray("crew");
            for (JsonElement crewMember : crew) {
                if (crewMember.getAsJsonObject().get("job").getAsString().equals("Director")) {
                    return crewMember.getAsJsonObject().get("name").getAsString();
                }
            }
        }
        return "정보 없음";
    }
    private String parseActors(JsonObject movieDetails) {
        JsonObject credits = movieDetails.getAsJsonObject("credits");
        if (credits != null) {
            JsonArray cast = credits.getAsJsonArray("cast");
            StringBuilder actors = new StringBuilder();
            int count = 0;
            for (JsonElement castMember : cast) {
                if (count < 5) {
                    if (count > 0) actors.append(", ");
                    actors.append(castMember.getAsJsonObject().get("name").getAsString());
                    count++;
                } else {
                    break;
                }
            }
            return actors.toString();
        }
        return "정보 없음";
    }
    private String parseKoreanAgeRating(JsonObject movieDetails) {
        JsonObject releaseDates = movieDetails.getAsJsonObject("release_dates");
        if (releaseDates != null) {
            JsonArray results = releaseDates.getAsJsonArray("results");
            for (JsonElement result : results) {
                JsonObject countryData = result.getAsJsonObject();
                if (countryData.get("iso_3166_1").getAsString().equals("KR")) {
                    JsonArray releaseInfo = countryData.getAsJsonArray("release_dates");
                    for(JsonElement info : releaseInfo) {
                        String certification = info.getAsJsonObject().get("certification").getAsString();
                        if (!certification.isEmpty()) {
                            return certification;
                        }
                    }
                }
            }
        }
        return "정보 없음";
    }
    private void closeDbResources(PreparedStatement ps, Connection conn) {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}