package mybatis.vo;

/**
 * Coupon + CouponUserMapping 테이블을 JOIN한 결과를 담는 전용 VO
 */
public class MyCouponVO {

    private int couponUserIdx; // 쿠폰-사용자 매핑 테이블의 고유 ID (PK)
    private String couponName;   // 화면에 표시할 쿠폰 이름
    private int couponValue;     // 할인될 금액

    // Getters and Setters
    public int getCouponUserIdx() {
        return couponUserIdx;
    }

    public void setCouponUserIdx(int couponUserIdx) {
        this.couponUserIdx = couponUserIdx;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public int getCouponValue() {
        return couponValue;
    }

    public void setCouponValue(int couponValue) {
        this.couponValue = couponValue;
    }
}