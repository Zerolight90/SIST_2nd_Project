package mybatis.vo;

public class ProductVO {
    private int productIdx;
    private String prodName;
    private int prodPrice;
    private String prodImg;

    // Getters and Setters
    public int getProductIdx() { return productIdx; }
    public void setProductIdx(int productIdx) { this.productIdx = productIdx; }

    public String getProdName() { return prodName; }
    public void setProdName(String prodName) { this.prodName = prodName; }

    public int getProdPrice() { return prodPrice; }
    public void setProdPrice(int prodPrice) { this.prodPrice = prodPrice; }

    public String getProdImg() { return prodImg; }
    public void setProdImg(String prodImg) { this.prodImg = prodImg; }

}