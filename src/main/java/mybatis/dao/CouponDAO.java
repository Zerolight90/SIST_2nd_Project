package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyCouponVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CouponDAO {

    // 특정 사용자가 사용 가능한 쿠폰 목록 가져오기
    public static List<MyCouponVO> getAvailableCouponsByUserId(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyCouponVO> list = ss.selectList("coupon.getAvailableCoupons", userIdx);
        ss.close();
        return list;
    }

    // 특정 쿠폰을 '사용 완료' 상태로 변경
    public static int useCoupon(int couponUserIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.update("coupon.useCoupon", couponUserIdx);
            if (result > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return result;
    }
}