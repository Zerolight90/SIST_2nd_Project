package mybatis.vo;

// 극장별 매출 정보를 담기 위한 VO
public class RevenueVO {
    private String theaterName; // 극장 이름
    private int totalSales;     // 총 매출액

    // Getters and Setters
    public String getTheaterName() {
        return theaterName;
    }
    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }
    public int getTotalSales() {
        return totalSales;
    }
    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }
}