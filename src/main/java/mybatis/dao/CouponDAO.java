package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.CouponVO;
import mybatis.vo.MyCouponVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CouponDAO {

    public static CouponVO[] getAllCoupon(){
        CouponVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<CouponVO> list = ss.selectList("coupon.getAllCoupon");
        ar = new CouponVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }
    public static void delCoupon(String cIdx){

        SqlSession ss = FactoryService.getFactory().openSession();
        int del = ss.delete("coupon.delSelectedCoupon", cIdx);
        if (del >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }
    public static void addCoupon(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int insert = ss.insert("coupon.addCoupon", map);
        if (insert >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }

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

    /**
     * 특정 사용자에게 쿠폰을 발급하는 메서드 (회원가입, 생일 등)
     * @param userIdx 발급받을 사용자의 ID
     * @param couponIdx 발급할 쿠폰의 ID
     * @return 성공 시 1, 실패 시 0
     */
    public static int issueCouponToUser(long userIdx, long couponIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false); // 수동 커밋
        int result = 0;
        try {
            Map<String, Long> map = new HashMap<>();
            map.put("userIdx", userIdx);
            map.put("couponIdx", couponIdx);
            result = ss.insert("coupon.issueCoupon", map);
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

    /**
     * 특정 사용자가 올해 생일 쿠폰을 받았는지 확인하는 메서드
     * @param userIdx 확인할 사용자의 ID
     * @param birthdayCouponIdx 생일 쿠폰의 ID
     * @return 받았으면 true, 아니면 false
     */
    public static boolean hasReceivedBirthdayCouponThisYear(long userIdx, long birthdayCouponIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        boolean received = false;
        try {
            Map<String, Long> map = new HashMap<>();
            map.put("userIdx", userIdx);
            map.put("couponIdx", birthdayCouponIdx);
            int count = ss.selectOne("coupon.checkBirthdayCouponIssued", map);
            if (count > 0) {
                received = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return received;
    }

    /**
     * 환불 시, 결제 정보(userIdx, paymentIdx)를 기반으로
     * 사용되었던 쿠폰의 고유 ID(couponUserIdx)를 찾는 메소드.
     * RefundAction에서 사용됩니다.
     * @param userIdx 회원 ID
     * @param paymentIdx 결제 ID
     * @param ss 트랜잭션을 위한 SqlSession
     * @return 조회된 couponUserIdx (없으면 null)
     */
    public static Long getCouponUserIdxByPaymentInfo(long userIdx, long paymentIdx, SqlSession ss) {
        Map<String, Long> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("paymentIdx", paymentIdx);
        return ss.selectOne("coupon.getCouponUserIdxByPaymentInfo", map);
    }
}