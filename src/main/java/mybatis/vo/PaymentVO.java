package mybatis.vo;

import java.util.Date;

public class PaymentVO {

    private long paymentIdx;
    private int paymentType; // 1: 영화, 2: 상품
    private String orderId;
    private String paymentTransactionId; // Toss Payments 거래 키
    private String paymentMethod;
    private int paymentTotal; // 할인 전 총 금액
    private int paymentDiscount; // 할인액
    private int paymentFinal; // 최종 결제 금액
    private Date paymentDate;

    // Foreign Keys
    private long userIdx;
    private Long reservationIdx;
    private Integer productIdx;
    private Integer couponUserIdx;

    // Getters and Setters (생략)

    public long getPaymentIdx() {
        return paymentIdx;
    }

    public void setPaymentIdx(long paymentIdx) {
        this.paymentIdx = paymentIdx;
    }

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPaymentTransactionId() {
        return paymentTransactionId;
    }

    public void setPaymentTransactionId(String paymentTransactionId) {
        this.paymentTransactionId = paymentTransactionId;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getPaymentTotal() {
        return paymentTotal;
    }

    public void setPaymentTotal(int paymentTotal) {
        this.paymentTotal = paymentTotal;
    }

    public int getPaymentDiscount() {
        return paymentDiscount;
    }

    public void setPaymentDiscount(int paymentDiscount) {
        this.paymentDiscount = paymentDiscount;
    }

    public int getPaymentFinal() {
        return paymentFinal;
    }

    public void setPaymentFinal(int paymentFinal) {
        this.paymentFinal = paymentFinal;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public long getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(long userIdx) {
        this.userIdx = userIdx;
    }

    public Long getReservationIdx() {
        return reservationIdx;
    }

    public void setReservationIdx(Long reservationIdx) {
        this.reservationIdx = reservationIdx;
    }

    public Integer getProductIdx() {
        return productIdx;
    }

    public void setProductIdx(Integer productIdx) {
        this.productIdx = productIdx;
    }

    public Integer getCouponUserIdx() {
        return couponUserIdx;
    }

    public void setCouponUserIdx(Integer couponUserIdx) {
        this.couponUserIdx = couponUserIdx;
    }
}