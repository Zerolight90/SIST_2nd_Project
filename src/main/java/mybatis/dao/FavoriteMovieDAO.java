package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class FavoriteMovieDAO {

    // 위시리스트 추가
    public static int addWishlist(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            // INSERT INTO favorite_movie (userIdx, mIdx) VALUES (#{userIdx}, #{mIdx})
            result = ss.insert("favMovie.add", map);
            if (result > 0) ss.commit();
            else ss.rollback();
        } catch (Exception e) {
            ss.rollback();
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return result;
    }

    // 위시리스트에서 삭제 (좋아요 취소)
    public static int removeWishlist(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            // DELETE FROM favorite_movie WHERE userIdx = #{userIdx} AND mIdx = #{mIdx}
            result = ss.delete("favMovie.remove", map);
            if (result > 0) ss.commit();
            else ss.rollback();
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
        // SELECT count(*) FROM favorite_movie WHERE userIdx = #{userIdx} AND mIdx = #{mIdx}
        int count = ss.selectOne("favMovie.isExist", map);
        ss.close();
        return count > 0;
    }

    // 특정 사용자가 좋아요 누른 모든 영화의 mIdx 목록 조회
    public static Set<Long> getLikedMovieSet(Long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<Long> likedList = ss.selectList("favMovie.getLikedMoviesByUser", userIdx);
        ss.close();
        return new HashSet<Long>(likedList);
    }

    // AllMovieDataAction에서 여러 영화의 좋아요 수를 Map<mIdx, likeCount> 형태로 반환
    public static Map<String, Integer> getLikeCountForMovies(List<MovieVO> movieList) {
        Map<String, Integer> likeCountMap = new HashMap<>();
        if (movieList == null || movieList.isEmpty()) {
            return likeCountMap;
        }

        SqlSession ss = FactoryService.getFactory().openSession();
        List<Map<String, Object>> resultList = ss.selectList("favMovie.getLikeCounts", movieList);
        ss.close();

        for (Map<String, Object> rowMap : resultList) {
            Object mIdxObj = rowMap.get("mIdx");
            if (mIdxObj == null) {
                mIdxObj = rowMap.get("MIDX");
            }

            Object countObj = rowMap.get("likeCount");
            if (countObj == null) {
                countObj = rowMap.get("LIKECOUNT");
            }

            if (mIdxObj != null && countObj != null) {
                String mIdx = String.valueOf(mIdxObj);
                int likeCount = ((Number) countObj).intValue();
                likeCountMap.put(mIdx, likeCount);
            }
        }
        return likeCountMap;
    }

    // AddWishlistAction에서 단일 영화의 좋아요 개수 반환 (추가된 메소드)
    public static int getLikeCount(String mIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        // SELECT COUNT(*) FROM favorite_movie WHERE mIdx = #{mIdx}
        int count = ss.selectOne("favMovie.getLikeCount", mIdx); // 새로운 쿼리 호출
        ss.close();
        return count;
    }
}