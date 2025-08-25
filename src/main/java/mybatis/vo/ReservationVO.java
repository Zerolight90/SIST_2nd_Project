package mybatis.vo;

public class ReservationVO {

    // DB reservation 테이블과 매핑되는 필드들
    private long reservIdx;
    private Long userIdx;
    private Long nIdx;
    private long tIdx;
    private long sIdx;
    private long timeTableIdx;
    private long priceIdx;
    private String reservDate;
    private int status;

    // 예매 과정에서 화면에 정보를 표시하기 위해 임시로 사용하는 필드들
    private String title;
    private String posterUrl;
    private String theaterName;
    private String screenName;
    private String startTime;
    private String seatInfo;
    private int finalAmount;

    // (추가) 결제 페이지 상세 내역 표시용 필드
    private int adultCount;
    private int teenCount;
    private int seniorCount;
    private int specialCount;
    private String timeDiscountName;
    private int timeDiscountAmount;
    private int seatDiscountAmount;

    // --- Getters and Setters ---
    public long getReservIdx() { return reservIdx; }
    public void setReservIdx(long reservIdx) { this.reservIdx = reservIdx; }
    public Long getUserIdx() { return userIdx; }
    public void setUserIdx(Long userIdx) { this.userIdx = userIdx; }
    public Long getnIdx() { return nIdx; }
    public void setnIdx(Long nIdx) { this.nIdx = nIdx; }
    public long gettIdx() { return tIdx; }
    public void settIdx(long tIdx) { this.tIdx = tIdx; }
    public long getsIdx() { return sIdx; }
    public void setsIdx(long sIdx) { this.sIdx = sIdx; }
    public long getTimeTableIdx() { return timeTableIdx; }
    public void setTimeTableIdx(long timeTableIdx) { this.timeTableIdx = timeTableIdx; }
    public long getPriceIdx() { return priceIdx; }
    public void setPriceIdx(long priceIdx) { this.priceIdx = priceIdx; }
    public String getReservDate() { return reservDate; }
    public void setReservDate(String reservDate) { this.reservDate = reservDate; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
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
    public int getFinalAmount() { return finalAmount; }
    public void setFinalAmount(int finalAmount) { this.finalAmount = finalAmount; }

    // 추가된 필드 Getter/Setter
    public int getAdultCount() { return adultCount; }
    public void setAdultCount(int adultCount) { this.adultCount = adultCount; }
    public int getTeenCount() { return teenCount; }
    public void setTeenCount(int teenCount) { this.teenCount = teenCount; }
    public int getSeniorCount() { return seniorCount; }
    public void setSeniorCount(int seniorCount) { this.seniorCount = seniorCount; }
    public int getSpecialCount() { return specialCount; }
    public void setSpecialCount(int specialCount) { this.specialCount = specialCount; }
    public String getTimeDiscountName() { return timeDiscountName; }
    public void setTimeDiscountName(String timeDiscountName) { this.timeDiscountName = timeDiscountName; }
    public int getTimeDiscountAmount() { return timeDiscountAmount; }
    public void setTimeDiscountAmount(int timeDiscountAmount) { this.timeDiscountAmount = timeDiscountAmount; }
    public int getSeatDiscountAmount() { return seatDiscountAmount; }
    public void setSeatDiscountAmount(int seatDiscountAmount) { this.seatDiscountAmount = seatDiscountAmount; }


}