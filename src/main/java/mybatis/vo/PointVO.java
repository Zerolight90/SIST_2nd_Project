package mybatis.vo;

import java.util.Date;

public class PointVO {
    private long pointIdx;
    private long userIdx;
    private Long paymentIdx;
    private int transactionType; // 0: 적립, 1: 사용
    private int amount;
    private String description;
    private Date transactionDate;

    // Getters and Setters
    public long getPointIdx() { return pointIdx; }
    public void setPointIdx(long pointIdx) { this.pointIdx = pointIdx; }
    public long getUserIdx() { return userIdx; }
    public void setUserIdx(long userIdx) { this.userIdx = userIdx; }
    public Long getPaymentIdx() { return paymentIdx; }
    public void setPaymentIdx(Long paymentIdx) { this.paymentIdx = paymentIdx; }
    public int getTransactionType() { return transactionType; }
    public void setTransactionType(int transactionType) { this.transactionType = transactionType; }
    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Date transactionDate) { this.transactionDate = transactionDate; }
}