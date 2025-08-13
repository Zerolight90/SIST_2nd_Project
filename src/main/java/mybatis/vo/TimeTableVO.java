package mybatis.vo;

import java.util.List;

public class TimeTableVO {
    private String timeTableIdx, tIdx, mIdx, sIdx, startTime, endTime, status, date;

    private String name;
    private String tName;
    private String sName, sCount;
    private String seatStatus, seatStatusIdx;

    private int reservationCount;

    public int getReservationCount() {
        return reservationCount;
    }

    public void setReservationCount(int reservationCount) {
        this.reservationCount = reservationCount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSeatStatus() {
        return seatStatus;
    }

    public void setSeatStatus(String seatStatus) {
        this.seatStatus = seatStatus;
    }

    public String getSeatStatusIdx() {
        return seatStatusIdx;
    }

    public void setSeatStatusIdx(String seatStatusIdx) {
        this.seatStatusIdx = seatStatusIdx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String gettName() {
        return tName;
    }

    public void settName(String tName) {
        this.tName = tName;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public String getsCount() {
        return sCount;
    }

    public void setsCount(String sCount) {
        this.sCount = sCount;
    }

    private List<MovieVO> m_list;

    private List<ScreenVO> s_list;

    private List<TheaterVO> t_list;

    private List<ReservationVO> r_list;

    public List<TheaterVO> getT_list() {
        return t_list;
    }

    public void setT_list(List<TheaterVO> t_list) {
        this.t_list = t_list;
    }

    public List<ReservationVO> getR_list() {
        return r_list;
    }

    public void setR_list(List<ReservationVO> r_list) {
        this.r_list = r_list;
    }

    public List<ScreenVO> getS_list() {
        return s_list;
    }

    public void setS_list(List<ScreenVO> s_list) {
        this.s_list = s_list;
    }

    public List<MovieVO> getM_list() {
        return m_list;
    }

    public void setM_list(List<MovieVO> m_list) {
        this.m_list = m_list;
    }

    public String getTimeTableIdx() {
        return timeTableIdx;
    }

    public void setTimeTableIdx(String timeTableIdx) {
        this.timeTableIdx = timeTableIdx;
    }

    public String gettIdx() {
        return tIdx;
    }

    public void settIdx(String tIdx) {
        this.tIdx = tIdx;
    }

    public String getmIdx() {
        return mIdx;
    }

    public void setmIdx(String mIdx) {
        this.mIdx = mIdx;
    }

    public String getsIdx() {
        return sIdx;
    }

    public void setsIdx(String sIdx) {
        this.sIdx = sIdx;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
