package mybatis.vo;

import java.util.List;

public class TimeTableVO {
    private String timeTableIdx, tIdx, mIdx, sIdx, timeTableStartTime, timeTableEndTime, status;

    private String name;
    private String tName;
    private String sName, sSeatCount;
    private String seatStatus, seatStatusIdx;

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

    public String getsSeatCount() {
        return sSeatCount;
    }

    public void setsSeatCount(String sSeatCount) {
        this.sSeatCount = sSeatCount;
    }

    private List<MovieVO> m_list;

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

    public String getTimeTableStartTime() {
        return timeTableStartTime;
    }

    public void setTimeTableStartTime(String timeTableStartTime) {
        this.timeTableStartTime = timeTableStartTime;
    }

    public String getTimeTableEndTime() {
        return timeTableEndTime;
    }

    public void setTimeTableEndTime(String timeTableEndTime) {
        this.timeTableEndTime = timeTableEndTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
