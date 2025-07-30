package mybatis.vo;

// 결제 정보 테이블(Payment)에 해당하는 VO
public class PaymentVO {

    private long paymentIdx;
    private int paymentType; // 결제 종류 (1: 영화, 2: 상품)
    private String orderId;

    private long userIdx;
    private Long reservationIdx; // 영화 예매 ID (상품 구매 시에는 null이 될 수 있음)
    private Integer productIdx;  // 상품 ID (영화 예매 시에는 null이 될 수 있음)
    private String paymentTransactionId; // Toss Payments에서 발급하는 거래 키
    private int paymentQuantity;
    private String paymentMethod;
    private int paymentTotal; // 할인 전 총 금액
    private int paymentDiscount; // 할인액
    private int paymentFinal; // 최종 결제 금액

    // Getters and Setters
    public long getPaymentIdx() { return paymentIdx; }
    public void setPaymentIdx(long paymentIdx) { this.paymentIdx = paymentIdx; }

    public int getPaymentType() { return paymentType; }
    public void setPaymentType(int paymentType) { this.paymentType = paymentType; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public long getUserIdx() { return userIdx; }
    public void setUserIdx(long userIdx) { this.userIdx = userIdx; }

    public Long getReservationIdx() { return reservationIdx; }
    public void setReservationIdx(Long reservationIdx) { this.reservationIdx = reservationIdx; }

    public Integer getProductIdx() { return productIdx; }
    public void setProductIdx(Integer productIdx) { this.productIdx = productIdx; }

    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }

    public int getPaymentQuantity() { return paymentQuantity; }
    public void setPaymentQuantity(int paymentQuantity) { this.paymentQuantity = paymentQuantity; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public int getPaymentTotal() { return paymentTotal; }
    public void setPaymentTotal(int paymentTotal) { this.paymentTotal = paymentTotal; }

    public int getPaymentDiscount() { return paymentDiscount; }
    public void setPaymentDiscount(int paymentDiscount) { this.paymentDiscount = paymentDiscount; }

    public int getPaymentFinal() { return paymentFinal; }
    public void setPaymentFinal(int paymentFinal) { this.paymentFinal = paymentFinal; }
}