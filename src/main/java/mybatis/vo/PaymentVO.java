package mybatis.vo;

import java.util.Date;

public class PaymentVO {
    private long paymentIdx; // BIGINT
    private int paymentType; // TINYINT(1) - New field from image_1bfcfe.png
    private long userIdx;    // INT -> long for flexibility
    private Long reservationIdx; // BIGINT -> Long
    private Integer productIdx; // INT -> Integer
    private String orderId; // VARCHAR(50)
    private String paymentTransactionId; // VARCHAR(255)
    private int paymentQuantity; // INT(5)
    private String paymentMethod; // VARCHAR(10)
    private int paymentTotal; // INT(7)
    private int paymentDiscount; // INT(7)
    private int paymentFinal; // INT(7)
    private int paymentStatus; // TINYINT(1) (0: 완료, 1: 취소)
    private Date paymentDate; // DATETIME
    private Date paymentCancelDate; // DATETIME

    // Constructor (Optional, but good practice for object creation)
    public PaymentVO() {}

    // Getters and Setters for all fields

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