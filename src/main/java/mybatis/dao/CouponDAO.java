package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyCouponVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CouponDAO {

    /**
     * 특정 사용자가 보유한 사용 가능한 쿠폰 목록을 조회하는 메소드
     * @param userIdx 사용자의 고유 ID
     * @return 사용 가능한 쿠폰 목록
     */
    public static List<MyCouponVO> getAvailableCouponsByUserId(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyCouponVO> list = ss.selectList("coupon.getAvailableCoupons", userIdx);
        ss.close();
        return list;
    }

    /**
     * 특정 쿠폰을 '사용 완료' 상태로 변경하는 메소드
     * @param couponUserIdx 사용된 쿠폰의 매핑 테이블 PK
     * @return 성공 시 1, 실패 시 0
     */
    public static int useCoupon(int couponUserIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = ss.update("coupon.useCoupon", couponUserIdx);
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return result;
    }
}