package mybatis.vo;

import java.util.Date;

public class ProductVO {

    // DB 테이블 컬럼에 맞춰 필드 수정 및 추가
    private long prodIdx;
    private int prodCategory;
    private String prodName;
    private String prodInfo;
    private int prodPrice;
    private int prodStock;
    private String prodImg;
    private Date prodRegDate;
    private int prodStatus;

    private int quantity; // DB 컬럼과 무관. 구매 수량을 임시로 담는 용도

    // Getters and Setters
    public long getProdIdx() {
        return prodIdx;
    }

    public void setProdIdx(long prodIdx) {
        this.prodIdx = prodIdx;
    }

    public int getProdCategory() {
        return prodCategory;
    }

    public void setProdCategory(int prodCategory) {
        this.prodCategory = prodCategory;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public String getProdInfo() {
        return prodInfo;
    }

    public void setProdInfo(String prodInfo) {
        this.prodInfo = prodInfo;
    }

    public int getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(int prodPrice) {
        this.prodPrice = prodPrice;
    }

    public int getProdStock() {
        return prodStock;
    }

    public void setProdStock(int prodStock) {
        this.prodStock = prodStock;
    }

    public String getProdImg() {
        return prodImg;
    }

    public void setProdImg(String prodImg) {
        this.prodImg = prodImg;
    }

    public Date getProdRegDate() {
        return prodRegDate;
    }

    public void setProdRegDate(Date prodRegDate) {
        this.prodRegDate = prodRegDate;
    }

    public int getProdStatus() {
        return prodStatus;
    }

    public void setProdStatus(int prodStatus) {
        this.prodStatus = prodStatus;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}