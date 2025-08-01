package mybatis.vo;

public class ReservationVO {

    // 기본 정보
    private long reservIdx;      // 예매 고유 ID (PK)
    private long userIdx;        // 예매한 사용자 ID
    private String reservStatus;   // 예매 상태 (예: PENDING_PAYMENT, COMPLETED, CANCELED)
    private int finalAmount;     // 최종 결제해야 할 금액

    // JOIN을 통해 가져올 정보들
    private String title;          // 영화 제목
    private String posterUrl;      // 영화 포스터 이미지 경로
    private String theaterName;    // 극장 이름 (예: 강남점)
    private String screenName;     // 상영관 이름 (예: IMAX관, 5관)
    private String startTime;      // 상영 시작 시간 (날짜 포함)
    private String seatInfo;       // 예매한 좌석 정보 (예: A1, A2)
    private int adultCount;        // 성인 인원 수
    private int teenCount;         // 청소년 인원 수

    // Getters and Setters
    public long getReservIdx() {
        return reservIdx;
    }

    public void setReservIdx(long reservIdx) {
        this.reservIdx = reservIdx;
    }

    public long getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(long userIdx) {
        this.userIdx = userIdx;
    }

    public String getReservStatus() {
        return reservStatus;
    }

    public void setReservStatus(String reservStatus) {
        this.reservStatus = reservStatus;
    }

    public int getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(int finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public String getTheaterName() {
        return theaterName;
    }

    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }

    public String getScreenName() {
        return screenName;
    }

    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getSeatInfo() {
        return seatInfo;
    }

    public void setSeatInfo(String seatInfo) {
        this.seatInfo = seatInfo;
    }

    public int getAdultCount() {
        return adultCount;
    }

    public void setAdultCount(int adultCount) {
        this.adultCount = adultCount;
    }

    public int getTeenCount() {
        return teenCount;
    }

    public void setTeenCount(int teenCount) {
        this.teenCount = teenCount;
    }
}