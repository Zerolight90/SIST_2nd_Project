package mybatis.vo;

public class TheaterVO {

    private String  tName, tRegion, tAddress, tInfo, tRegDate;
    private int tIdx, tScreenCount, tStatus;

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

    public String gettRegDate() {
        return tRegDate;
    }

    public void settRegDate(String tRegDate) {
        this.tRegDate = tRegDate;
    }

    public int gettIdx() {
        return tIdx;
    }

    public void settIdx(int tIdx) {
        this.tIdx = tIdx;
    }

    public int gettScreenCount() {
        return tScreenCount;
    }

    public void settScreenCount(int tScreenCount) {
        this.tScreenCount = tScreenCount;
    }

    public int gettStatus() {
        return tStatus;
    }

    public void settStatus(int tStatus) {
        this.tStatus = tStatus;
    }
}
