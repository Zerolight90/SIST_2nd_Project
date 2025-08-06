package mybatis.vo;

public class ScreenVO {

    private String sIdx, tIdx, codeIdx, sName, sSeatCount, sStatus;

    public String getsIdx() {
        return sIdx;
    }

    public void setsIdx(String sIdx) {
        this.sIdx = sIdx;
    }

    public String gettIdx() {
        return tIdx;
    }

    public void settIdx(String tIdx) {
        this.tIdx = tIdx;
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
}
