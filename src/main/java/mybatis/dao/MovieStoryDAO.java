package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieStoryVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class MovieStoryDAO {
    // 한 페이지당 보여줄 영화의 개수
    private static final int NUM_PER_PAGE = 6;

    // 관람평 목록 조회
    public static List<MovieStoryVO> getReviewList(Long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("movieStory.getReviews", userIdx);
        ss.close();
        return list;
    }

    // 본 영화 목록 조회 (페이징 적용)
    public static List<MovieStoryVO> getWatchedList(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("movieStory.getWatchedMovies", params);
        ss.close();
        return list;
    }

    // 본 영화 전체 개수 조회
    public static int getWatchedCount(Long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        // MyBatis가 결과를 찾지 못해 null을 반환할 경우를 대비
        Integer count = ss.selectOne("movieStory.getWatchedCount", userIdx);
        ss.close();
        // count가 null이면 0을, 아니면 실제 count 값을 반환
        return count == null ? 0 : count;
    }

    // 위시리스트 조회 (페이징 적용)
    public static List<MovieStoryVO> getWishList(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("favMovie.getFavoriteMovies", params);
        ss.close();
        return list;
    }

    // 위시리스트 전체 개수 조회
    public static int getWishCount(Long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        // MyBatis가 결과를 찾지 못해 null을 반환할 경우를 대비
        Integer count = ss.selectOne("favMovie.getFavoriteCount", userIdx);
        ss.close();
        // count가 null이면 0을, 아니면 실제 count 값을 반환
        return count == null ? 0 : count;
    }
}