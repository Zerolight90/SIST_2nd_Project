package mybatis.vo;

// 예매 정보 테이블(Reservation)에 해당하는 VO
public class ReservationVO {

    private int reservIdx;
    private int userIdx;
    private int theaterIdx;
    private int sIdx; // 상영관 ID
    private int timeTableIdx;
    private long reservationDate;
    private int reservationStatus;
    private String customReservationIdx;

    // Getters and Setters
    public int getReservIdx() {
        return reservIdx;
    }

    public void setReservIdx(int reservIdx) {
        this.reservIdx = reservIdx;
    }

    public int getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(int userIdx) {
        this.userIdx = userIdx;
    }

    public int getTheaterIdx() {
        return theaterIdx;
    }

    public void setTheaterIdx(int theaterIdx) {
        this.theaterIdx = theaterIdx;
    }

    public int getsIdx() {
        return sIdx;
    }

    public void setsIdx(int sIdx) {
        this.sIdx = sIdx;
    }

    public int getTimeTableIdx() {
        return timeTableIdx;
    }

    public void setTimeTableIdx(int timeTableIdx) {
        this.timeTableIdx = timeTableIdx;
    }

    public long getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(long reservationDate) {
        this.reservationDate = reservationDate;
    }

    public int getReservationStatus() {
        return reservationStatus;
    }

    public void setReservationStatus(int reservationStatus) {
        this.reservationStatus = reservationStatus;
    }

    public String getCustomReservationIdx() {
        return customReservationIdx;
    }

    public void setCustomReservationIdx(String customReservationIdx) {
        this.customReservationIdx = customReservationIdx;
    }
}