package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ReviewVO;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class ReviewDAO {

    private static final String NS = "review.";

    public static ReviewVO[] getReviewsByMovieId(String mIdx) {
        ReviewVO[] ar = null;
        List<ReviewVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();
//        System.out.println(mIdx);

        // 우선 상영중, 예정인 모든 영화를 보여주는 구간
        list = ss.selectList("review.getReview", mIdx);
        if(list.isEmpty()){
            System.out.println("리스트 빔");
        } else {
            ar = new ReviewVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;

    }

        public static int insertReview(ReviewVO rvo) {
            SqlSession ss = FactoryService.getFactory().openSession();

            int result = ss.insert("review.insert", rvo);
            if(result > 0){
                ss.commit();
            }else {
                ss.rollback();
            }
            ss.close();

            return result;
        }

        public static List<ReviewVO> getReviewListByMovieId(String mIdx) {
            SqlSession ss = FactoryService.getFactory().openSession();
            List<ReviewVO> list = ss.selectList("review.getReview", mIdx);
            ss.close();
            return list;
        }

    // 관람평 수정을 위한 메소드
    public static int updateReview(Map<String, String> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int result = ss.update("review.update", params);
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return result;
    }

    // 관람평 삭제를 위한 메소드
    public static int deleteReview(Map<String, String> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int result = ss.delete("review.delete", params);
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return result;
    }

}


