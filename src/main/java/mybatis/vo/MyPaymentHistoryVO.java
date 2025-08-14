package mybatis.vo;

import java.util.Date;

public class MyPaymentHistoryVO {

    private int paymentType;
    private Date paymentDate;
    private String orderId;
    private String paymentKey;
    private int paymentStatus;
    private String itemTitle;
    private String itemPosterUrl;
    private String theaterInfo;
    private Date screenDate;
    private int prodPrice;
    private int quantity = 1;

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPaymentKey() {
        return paymentKey;
    }

    public void setPaymentKey(String paymentKey) {
        this.paymentKey = paymentKey;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getItemPosterUrl() {
        return itemPosterUrl;
    }

    public void setItemPosterUrl(String itemPosterUrl) {
        this.itemPosterUrl = itemPosterUrl;
    }

    public String getTheaterInfo() {
        return theaterInfo;
    }

    public void setTheaterInfo(String theaterInfo) {
        this.theaterInfo = theaterInfo;
    }

    public Date getScreenDate() {
        return screenDate;
    }

    public void setScreenDate(Date screenDate) {
        this.screenDate = screenDate;
    }

    public int getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(int prodPrice) {
        this.prodPrice = prodPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}