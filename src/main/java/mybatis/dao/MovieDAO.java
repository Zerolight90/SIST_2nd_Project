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

    public static MovieVO[] getMovieSearch(Map<String, String> params){
        MovieVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieVO> list = ss.selectList("movie.getMovieSearch", params);
        ar = new MovieVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
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

}
