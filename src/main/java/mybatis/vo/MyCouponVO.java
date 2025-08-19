package mybatis.vo;

import java.util.Date;

/**
 * Coupon + CouponUserMapping 테이블을 JOIN한 결과를 담는 전용 VO
 */
public class MyCouponVO {

    private int couponUserIdx; // 쿠폰-사용자 매핑 테이블의 고유 ID
    private String couponName;   // 화면에 표시할 쿠폰 이름
    private int couponValue;// 할인될 금액
    private String couponCategory; // 구분
    private Date couponExpDate;    // 유효기간
    private int couponStatus;      // 사용상태 (0:사용가능, 1:사용완료)
    private int discountValue;

    public int getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(int discountValue) {
        this.discountValue = discountValue;
    }

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

    public String getCouponCategory() {
        return couponCategory;
    }

    public void setCouponCategory(String couponCategory) {
        this.couponCategory = couponCategory;
    }

    public Date getCouponExpDate() {
        return couponExpDate;
    }

    public void setCouponExpDate(Date couponExpDate) {
        this.couponExpDate = couponExpDate;
    }

    public int getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(int couponStatus) {
        this.couponStatus = couponStatus;
    }
}