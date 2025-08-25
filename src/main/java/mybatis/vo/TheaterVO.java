package mybatis.vo;

import java.util.List;

public class TheaterVO {
    private String tIdx, tName, tRegion, tAddress, tInfo, tScreenCount, tRegDate, tStatus;
    private String screenCode;

    TheaterInfoBoardVO tibvo;

    List<AdminBoardVO> bvo_list;

    public List<AdminBoardVO> getBvo_list() {
        return bvo_list;
    }

    public void setBvo_list(List<AdminBoardVO> bvo_list) {
        this.bvo_list = bvo_list;
    }

    public TheaterInfoBoardVO getTibvo() {
        return tibvo;
    }

    public void setTibvo(TheaterInfoBoardVO tibvo) {
        this.tibvo = tibvo;
    }

    public String getScreenCode() {
        return screenCode;
    }

    public void setScreenCode(String screenCode) {
        this.screenCode = screenCode;
    }

    private String codeIdx, sName, sCount, sStatus;

    public String getsCount() {
        return sCount;
    }

    public void setsCount(String sCount) {
        this.sCount = sCount;
    }

    public String getsStatus() {
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }

    public String getCodeIdx() {
        return codeIdx;
    }

    public void setCodeIdx(String codeIdx) {
        this.codeIdx = codeIdx;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public String gettIdx() {
        return tIdx;
    }

    public void settIdx(String tIdx) {
        this.tIdx = tIdx;
    }

    public String gettName() {
        return tName;
    }

    public void settName(String tName) {
        this.tName = tName;
    }

    public String gettRegion() {
        return tRegion;
    }

    public void settRegion(String tRegion) {
        this.tRegion = tRegion;
    }

    public String gettAddress() {
        return tAddress;
    }

    public void settAddress(String tAddress) {
        this.tAddress = tAddress;
    }

    public String gettInfo() {
        return tInfo;
    }

    public void settInfo(String tInfo) {
        this.tInfo = tInfo;
    }

    public String gettScreenCount() {
        return tScreenCount;
    }

    public void settScreenCount(String tScreenCount) {
        this.tScreenCount = tScreenCount;
    }

    public String gettRegDate() {
        return tRegDate;
    }

    public void settRegDate(String tRegDate) {
        this.tRegDate = tRegDate;
    }

    public String gettStatus() {
        return tStatus;
    }

    public void settStatus(String tStatus) {
        this.tStatus = tStatus;
    }


    @Override
    public String toString() {
        return "TheaterVO{" +
                "tIdx='" + tIdx + '\'' +
                ", tName='" + tName + '\'' +
                ", tRegion='" + tRegion + '\'' +
                ", tAddress='" + tAddress + '\'' +
                ", tInfo='" + tInfo + '\'' +
                ", tScreenCount='" + tScreenCount + '\'' +
                ", tRegDate='" + tRegDate + '\'' +
                ", tStatus='" + tStatus + '\'' +
                ", screenCode='" + screenCode + '\'' +
                ", tibvo=" + tibvo +
                ", bvo_list=" + bvo_list +
                ", codeIdx='" + codeIdx + '\'' +
                ", sName='" + sName + '\'' +
                ", sCount='" + sCount + '\'' +
                ", sStatus='" + sStatus + '\'' +
                '}';
    }
}
