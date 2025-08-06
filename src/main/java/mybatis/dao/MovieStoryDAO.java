package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieStoryVO;
import org.apache.ibatis.session.SqlSession;
import java.util.List;

public class MovieStoryDAO {
    // 관람평 목록 조회
    public static List<MovieStoryVO> getReviewList(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("movieStory.getReviews", userIdx);
        ss.close();
        return list;
    }
    // 본 영화 목록 조회
    public static List<MovieStoryVO> getWatchedList(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("movieStory.getWatchedMovies", userIdx);
        ss.close();
        return list;
    }
    // 위시리스트 조회
    public static List<MovieStoryVO> getWishList(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MovieStoryVO> list = ss.selectList("movieStory.getFavoriteMovies", userIdx);
        ss.close();
        return list;
    }
}