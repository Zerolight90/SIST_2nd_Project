package mybatis.vo;

public class TheaterVO {
    private String tIdx, tName, tRegion, tAddress, tInfo, tScreenCount, tRegDate, tStatus;

    private String codeIdx, sName, sSeatCount, sStatus;

    public String getsSeatCount() {
        return sSeatCount;
    }

    public void setsSeatCount(String sSeatCount) {
        this.sSeatCount = sSeatCount;
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
}
