package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;

import java.util.*;
import java.util.stream.Collectors;

public class FavoriteMovieDAO {

    // 위시리스트 추가
    public static int addWishlist(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.insert("favMovie.add", map);
            if (result > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            ss.rollback();
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return result;
    }

    // 이미 추가되었는지 확인
    public static boolean isAlreadyWished(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("favMovie.isExist", map);
        ss.close();
        return count > 0;
    }

    // 특정 사용자가 좋아요 누른 모든 영화의 mIdx 목록 조회
    public static Set<String> getLikedMovieSet(String userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> likedList = ss.selectList("favMovie.getLikedMoviesByUser", userIdx);
        ss.close();
        return new HashSet<>(likedList);
    }

    // 여러 영화(mIdx 목록)의 좋아요 개수를 Map<mIdx, likeCount> 형태로 반환
    public static Map<String, Integer> getLikeCountForMovies(List<MovieVO> movieList) {
        if (movieList == null || movieList.isEmpty()) {
            return new HashMap<>();
        }

        SqlSession ss = FactoryService.getFactory().openSession();

        List<Map<String, Object>> resultList = ss.selectList("favMovie.getLikeCounts", movieList);
        ss.close();

        Map<String, Integer> likeCountMap = resultList.stream()
                .collect(Collectors.toMap(
                        map -> String.valueOf(map.get("mIdx")), // mIdx를 키(Key)로 사용
                        map -> ((Number) map.get("likeCount")).intValue() // likeCount를 값(Value)으로 사용
                ));

        return likeCountMap;
    }
}