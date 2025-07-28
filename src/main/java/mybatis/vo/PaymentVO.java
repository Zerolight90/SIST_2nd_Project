package mybatis.vo;

import java.util.Date;

public class PaymentVO {
    private long paymentIdx;
    private long userIdx;
    private Long reservationIdx;
    private Integer productIdx;
    private String orderId;
    private String paymentTransactionId;
    private int paymentQuantity;
    private String paymentMethod;
    private int paymentTotal;
    private int paymentDiscount;
    private int paymentFinal;
    private int paymentStatus;
    private Date paymentDate;
    private Date paymentCancelDate;

    public long getPaymentIdx() {
        return paymentIdx;
    }

    public void setPaymentIdx(long paymentIdx) {
        this.paymentIdx = paymentIdx;
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

    public int getPaymentQuantity() {
        return paymentQuantity;
    }

    public void setPaymentQuantity(int paymentQuantity) {
        this.paymentQuantity = paymentQuantity;
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

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Date getPaymentCancelDate() {
        return paymentCancelDate;
    }

    public void setPaymentCancelDate(Date paymentCancelDate) {
        this.paymentCancelDate = paymentCancelDate;
    }
}