package mybatis.vo;

public class ScreenVO {

    private String sIdx, tIdx, screenCode, sName, sCount, sStatus, sRow, sColumn, sBlank;

    public String getsCount() {
        return sCount;
    }

    public void setsCount(String sCount) {
        this.sCount = sCount;
    }

    public String getsRow() {
        return sRow;
    }

    public void setsRow(String sRow) {
        this.sRow = sRow;
    }

    public String getsColumn() {
        return sColumn;
    }

    public void setsColumn(String sColumn) {
        this.sColumn = sColumn;
    }

    public String getsBlank() {
        return sBlank;
    }

    public void setsBlank(String sBlank) {
        this.sBlank = sBlank;
    }

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

    public String getScreenCode() {
        return screenCode;
    }

    public void setScreenCode(String screenCode) {
        this.screenCode = screenCode;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }



    public String getsStatus() {
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }
}
