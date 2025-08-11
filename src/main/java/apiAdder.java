import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class apiAdder {

    // DB 연결 정보
    private static final String DB_URL = "jdbc:mysql://localhost:3306/web_movie?serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1111";

    // TMDB API 정보
    private static final String API_KEY_V4 = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNzgzNzQyMjRkMDUzZjgyNTE4N2Q3NWNlN2Y4NTA1OSIsIm5iZiI6MTc1MzQzMDgyMS41MDMsInN1YiI6IjY4ODMzYjI1Yjk0ZTY2N2Y4YjUyYTQ1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aj9FVfDgUc-zPePdEXS1yj_VQDnEq6Yxh3c6uXwB2Mo";

    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT IGNORE INTO movie (mIdx, name, synop, poster, date, gen, actor, dir, age, runtime) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            for (int page = 1; page <= 4; page++) {
                System.out.println("====== " + page + "페이지 데이터 저장 시작 ======");

                String listApiUrl = "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&region=KR&page=" + page;
                JsonArray movieList = getMovieListFromServer(listApiUrl);
                if (movieList == null) continue;

                for (JsonElement movieElement : movieList) {
                    JsonObject movieSummary = movieElement.getAsJsonObject();
                    String movieId = movieSummary.get("id").getAsString();

                    JsonObject movieDetails = getMovieDetails(movieId);
                    if (movieDetails == null) continue;

                    // 상세 정보 파싱
                    String genres = parseGenres(movieDetails); // 장르 정보 파싱
                    int runtime = movieDetails.has("runtime") && !movieDetails.get("runtime").isJsonNull() ? movieDetails.get("runtime").getAsInt() : 0;
                    String director = parseDirector(movieDetails);
                    String actors = parseActors(movieDetails);
                    String ageRating = parseKoreanAgeRating(movieDetails);

                    // DB에 저장할 데이터 설정
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

                    ps.executeUpdate();
                    System.out.println(movieSummary.get("title").getAsString() + " 저장 완료");

                    Thread.sleep(40);
                }
            }
            System.out.println("모든 데이터 저장이 완료되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeDbResources(ps, conn);
        }
    }

    // ... getResponseString, getMovieListFromServer, getMovieDetails 메소드는 기존과 동일 ...
    private static String getResponseString(String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY_V4);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.connect();

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
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
    private static JsonArray getMovieListFromServer(String apiUrl) throws Exception {
        String jsonResponse = getResponseString(apiUrl);
        if (jsonResponse != null) {
            return JsonParser.parseString(jsonResponse).getAsJsonObject().getAsJsonArray("results");
        }
        return null;
    }
    private static JsonObject getMovieDetails(String movieId) throws Exception {
        String detailApiUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?language=ko-KR&append_to_response=credits,release_dates";
        String jsonResponse = getResponseString(detailApiUrl);
        if (jsonResponse != null) {
            return JsonParser.parseString(jsonResponse).getAsJsonObject();
        }
        return null;
    }

    // 장르 정보 파싱을 위한 헬퍼 메소드 추가
    private static String parseGenres(JsonObject movieDetails) {
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
    private static String parseDirector(JsonObject movieDetails) {
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
    private static String parseActors(JsonObject movieDetails) {
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
    private static String parseKoreanAgeRating(JsonObject movieDetails) {
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
    private static void closeDbResources(PreparedStatement ps, Connection conn) {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
