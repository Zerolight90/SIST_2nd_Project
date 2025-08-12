package mybatis.vo;

import java.util.Date;

public class PaymentVO {

    private long paymentIdx;
    private long userIdx;
    private String name;
    private Long reservIdx; // 영화 예매 ID (FK)
    private Long prodIdx;   // 스토어 상품 ID (FK)
    private Long couponUserIdx; // 사용한 쿠폰 ID (FK)
    private int paymentType; // 0: 영화, 1: 스토어
    private String orderId; // 토스 결제용 주문ID
    private String paymentTransactionId; // 토스 결제 거래 키
    private String paymentMethod; // 결제 수단 (카드, 간편결제 등)
    private int paymentTotal; // 할인 전 총 금액
    private int couponDiscount; // 쿠폰 할인액
    private int pointDiscount; // 포인트 할인액
    private int paymentFinal; // 최종 결제 금액
    private int paymentStatus; // 0: 완료, 1: 취소
    private Date paymentDate;
    private Date paymentCancelDate;

    // Getters and Setters

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getPaymentIdx() { return paymentIdx; }
    public void setPaymentIdx(long paymentIdx) { this.paymentIdx = paymentIdx; }
    public long getUserIdx() { return userIdx; }
    public void setUserIdx(long userIdx) { this.userIdx = userIdx; }
    public Long getReservIdx() { return reservIdx; }
    public void setReservIdx(Long reservIdx) { this.reservIdx = reservIdx; }
    public Long getProdIdx() { return prodIdx; }
    public void setProdIdx(Long prodIdx) { this.prodIdx = prodIdx; }
    public Long getCouponUserIdx() { return couponUserIdx; }
    public void setCouponUserIdx(Long couponUserIdx) { this.couponUserIdx = couponUserIdx; }
    public int getPaymentType() { return paymentType; }
    public void setPaymentType(int paymentType) { this.paymentType = paymentType; }
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public int getPaymentTotal() { return paymentTotal; }
    public void setPaymentTotal(int paymentTotal) { this.paymentTotal = paymentTotal; }
    public int getCouponDiscount() { return couponDiscount; }
    public void setCouponDiscount(int couponDiscount) { this.couponDiscount = couponDiscount; }
    public int getPointDiscount() { return pointDiscount; }
    public void setPointDiscount(int pointDiscount) { this.pointDiscount = pointDiscount; }
    public int getPaymentFinal() { return paymentFinal; }
    public void setPaymentFinal(int paymentFinal) { this.paymentFinal = paymentFinal; }
    public int getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(int paymentStatus) { this.paymentStatus = paymentStatus; }
    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }
    public Date getPaymentCancelDate() { return paymentCancelDate; }
    public void setPaymentCancelDate(Date paymentCancelDate) { this.paymentCancelDate = paymentCancelDate; }
}