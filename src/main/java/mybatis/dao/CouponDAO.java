package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyCouponVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CouponDAO {

    // 트랜잭션 관리를 위해 SqlSession을 파라미터로 받는 메소드
    public static int useCoupon(long couponUserIdx, SqlSession ss) {
        // commit, rollback, close를 Action에서 관리하므로 DAO에서는 update만 실행
        return ss.update("coupon.useCoupon", couponUserIdx);
    }

    //  트랜잭션 관리를 위해 SqlSession을 파라미터로 받는 메소드
    public static MyCouponVO getCouponByCouponUserIdx(long couponUserIdx, SqlSession ss) {
        // 세션을 외부에서 받아오므로 여기서 열거나 닫지 않음
        return ss.selectOne("coupon.getCouponByCouponUserIdx", couponUserIdx);
    }

    // 특정 사용자가 사용 가능한 영화 쿠폰 목록 가져오기
    public static List<MyCouponVO> getAvailableMovieCoupons(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyCouponVO> list = ss.selectList("coupon.getAvailableMovieCoupons", userIdx);
        ss.close();

        Pattern pattern = Pattern.compile("(\\d{1,3}(,\\d{3})*|\\d+)\\s*원");
        for (MyCouponVO vo : list) {
            Matcher matcher = pattern.matcher(vo.getCouponName());
            if (matcher.find()) {
                String valueStr = matcher.group(1);
                vo.setCouponValue(Integer.parseInt(valueStr.replace(",", "")));
            } else {
                vo.setCouponValue(0);
            }
        }
        return list;
    }

    // 특정 사용자가 사용 가능한 '스토어' 쿠폰 목록 가져오기
    public static List<MyCouponVO> getAvailableStoreCoupons(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyCouponVO> list = ss.selectList("coupon.getAvailableStoreCoupons", userIdx);
        ss.close();

        Pattern pattern = Pattern.compile("(\\d{1,3}(,\\d{3})*|\\d+)\\s*원");
        for (MyCouponVO vo : list) {
            Matcher matcher = pattern.matcher(vo.getCouponName());
            if (matcher.find()) {
                String valueStr = matcher.group(1);
                vo.setCouponValue(Integer.parseInt(valueStr.replace(",", "")));
            } else {
                vo.setCouponValue(0);
            }
        }
        return list;
    }

    // useCoupon 메소드
    public static int useCoupon(long couponUserIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.update("coupon.useCoupon", couponUserIdx);
            if (result > 0) ss.commit();
            else ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback();
        } finally {
            if (ss != null) ss.close();
        }
        return result;
    }

    // getCouponByCouponUserIdx 메소드
    public static MyCouponVO getCouponByCouponUserIdx(long couponUserIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MyCouponVO vo = ss.selectOne("coupon.getCouponByCouponUserIdx", couponUserIdx);
        ss.close();
        return vo;
    }

    // 특정 사용자의 모든 쿠폰 내역 조회
    public static List<MyCouponVO> getCouponHistory(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyCouponVO> list = ss.selectList("coupon.getHistory", userIdx);
        ss.close();
        return list;
    }

    public static int revertCouponUsage(long couponUserIdx, SqlSession ss) {
        return ss.update("coupon.revertCouponUsage", couponUserIdx);
    }
}