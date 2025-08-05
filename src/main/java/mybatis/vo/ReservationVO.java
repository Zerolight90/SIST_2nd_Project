package mybatis.vo;

public class ReservationVO {
    // 기본 정보
    private long reservIdx;
    private long userIdx;
    private int finalAmount; // 총 결제액

    // 조인해서 가져올 정보
    private String title;
    private String posterUrl;
    private String theaterName;
    private String screenName;
    private String startTime;
    private String seatInfo; // 예: "A1, A2" 형태의 좌석 정보

    // Getters and Setters
    public long getReservIdx() { return reservIdx; }
    public void setReservIdx(long reservIdx) { this.reservIdx = reservIdx; }
    public long getUserIdx() { return userIdx; }
    public void setUserIdx(long userIdx) { this.userIdx = userIdx; }
    public int getFinalAmount() { return finalAmount; }
    public void setFinalAmount(int finalAmount) { this.finalAmount = finalAmount; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }
    public String getTheaterName() { return theaterName; }
    public void setTheaterName(String theaterName) { this.theaterName = theaterName; }
    public String getScreenName() { return screenName; }
    public void setScreenName(String screenName) { this.screenName = screenName; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getSeatInfo() { return seatInfo; }
    public void setSeatInfo(String seatInfo) { this.seatInfo = seatInfo; }
}