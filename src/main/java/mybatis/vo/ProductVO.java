package mybatis.vo;

// 상품 정보 테이블(Product)에 해당하는 VO
public class ProductVO {

    private int prodIdx;
    private int prodCategory;
    private String prodName;
    private String prodInfo;
    private int prodPrice;
    private int prodStock;
    private String prodImg;
    private String prodRegDate;
    private int prodStatus;

    // Getters and Setters
    public int getProdIdx() {
        return prodIdx;
    }

    public void setProdIdx(int prodIdx) {
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

    public String getProdRegDate() {
        return prodRegDate;
    }

    public void setProdRegDate(String prodRegDate) {
        this.prodRegDate = prodRegDate;
    }

    public int getProdStatus() {
        return prodStatus;
    }

    public void setProdStatus(int prodStatus) {
        this.prodStatus = prodStatus;
    }
}