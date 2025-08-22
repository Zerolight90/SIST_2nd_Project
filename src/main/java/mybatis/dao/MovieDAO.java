package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class MovieDAO {
    public static List<MovieVO> getList(String now) {
        List<MovieVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        list = ss.selectList("timeTable.all", now);

        ss.close();
        return list;
    }
    public static MovieVO[] getAllMovie() {
        MovieVO[] ar = null;

        try {
            SqlSession ss = FactoryService.getFactory().openSession();
            List<MovieVO> list = ss.selectList("movie.getMovieInfo");
            ar = new MovieVO[list.size()];
            list.toArray(ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ar;
    }
    public static MovieVO getById(String mIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MovieVO movie = ss.selectOne("movie.list", mIdx);
        ss.close();
        return movie;
    }

    public static MovieVO[] getMovieSearch(int begin, int end, Map<String, String> params){
        MovieVO[] ar = null;
        params.put("begin", String.valueOf(begin));
        params.put("end", String.valueOf(end));

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieVO> list = ss.selectList("movie.getMovieSearch", params);
        ar = new MovieVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static void editMovies(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int update = ss.update("movie.editMovies", map);

        if (update >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }

    public static List<MovieVO> getBoxOfficeList() {
        List<MovieVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        list = ss.selectList("movie.getBoxOfficeList");
        ss.close();
        return list;
    }
    // 카테고리별 총 게시물 수 반환
    public static int getTotalCount(String category) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("movie.getTotalCount", category);
        ss.close();
        return count;
    }

    // 카테고리별 영화 목록을 페이징하여 반환하는 메소드
    public static List<MovieVO> getMovieList(Map<String, Object> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieVO> list = ss.selectList("movie.getMovieList", map);
        ss.close();
        return list;
    }

    // 검색 결과의 총 개수를 반환하는 메소드
    public static int getTotalSearchCount(String keyword) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("movie.searchTotalCount", keyword);
        ss.close();
        return count;
    }

    // 검색 결과를 페이징하여 반환하는 메소드
    public static List<MovieVO> getSearchMovieList(Map<String, Object> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieVO> list = ss.selectList("movie.search", map);
        ss.close();
        return list;
    }

    /**
     * 특정 영화(mIdx)의 총 예매 수를 반환하는 메소드
     * @param mIdx 영화 ID
     * @return 해당 영화의 총 예매 수
     */
    public static int getReservationCountByMovie(String mIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("movie.getReservationCountByMovie", mIdx);
        ss.close();
        return count;
    }

    /**
     * 현재 상영중인 모든 영화의 총 예매 수를 반환하는 메소드
     * (예매율 분모 계산용)
     * @return 상영중인 영화들의 총 예매 수
     */
    public static int getTotalReservationsForShowingMovies() {
        SqlSession ss = FactoryService.getFactory().openSession();
        // 분모가 0이 되는 것을 방지하기 위해 null 체크 후 0을 반환하도록 처리
        Integer total = ss.selectOne("movie.getTotalReservationsForShowingMovies");
        ss.close();
        return (total == null) ? 0 : total;
    }

}
