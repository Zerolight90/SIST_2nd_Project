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

    public static List<MovieVO> getBoxOfficeList() {
        List<MovieVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        list = ss.selectList("movie.getBoxOfficeList");
        ss.close();
        return list;
    }
    // [추가] 카테고리별 총 게시물 수 반환
    public static int getTotalCount(String category) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("movie.getTotalCount", category);
        ss.close();
        return count;
    }

    // [추가] 페이징 처리를 위해 Map을 인자로 받는 목록 조회
    public static List<MovieVO> getMovieList(Map<String, Object> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieVO> list = ss.selectList("movie.getPagedList", map);
        ss.close();
        return list;
    }

}
