package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyCouponVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CouponDAO {

    // 특정 사용자가 사용 가능한 영화 쿠폰 목록 가져오기
    public static List<MyCouponVO> getAvailableMovieCoupons(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        // DB에서는 couponName까지만 조회합니다.
        List<MyCouponVO> list = ss.selectList("coupon.getAvailableMovieCoupons", userIdx);
        ss.close();

        // ========[ 중요 ] 쿠폰명에서 할인 금액을 파싱하는 로직 ============
        // 정규식 패턴: 문자열에서 '숫자'와 '원'으로 끝나는 부분을 찾습니다. (예: 5000원, 10,000원)
        Pattern pattern = Pattern.compile("(\\d{1,3}(,\\d{3})*|\\d+)\\s*원");

        for (MyCouponVO vo : list) {
            Matcher matcher = pattern.matcher(vo.getCouponName());
            if (matcher.find()) {
                // "5,000" 과 같은 숫자 부분을 추출
                String valueStr = matcher.group(1);
                // 쉼표(,)를 제거하고 숫자로 변환
                int discountValue = Integer.parseInt(valueStr.replace(",", ""));
                // VO의 couponValue 필드에 파싱한 값을 설정
                vo.setCouponValue(discountValue);
            } else {
                // 금액을 찾지 못한 경우 0으로 설정
                vo.setCouponValue(0);
            }
        }
        // ==============================================================

        return list;
    }

    // 특정 쿠폰을 '사용 완료' 상태로 변경
    public static int useCoupon(long couponUserIdx) {
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

    // couponUserIdx로 쿠폰 정보를 가져오는 메소드
    public static MyCouponVO getCouponByCouponUserIdx(long couponUserIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MyCouponVO vo = ss.selectOne("coupon.getCouponByCouponUserIdx", couponUserIdx);
        ss.close();
        return vo;
    }
}