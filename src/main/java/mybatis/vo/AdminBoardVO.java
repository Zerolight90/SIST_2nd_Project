package mybatis.vo;

public class AdminBoardVO {

    private String boardIdx, adminIdx, tIdx, boardType, boardTitle, boardContent, boardRegDate, boardEndRegDate, boardStatus;
    private TheaterVO tvo;

    public TheaterVO getTvo() {
        return tvo;
    }

    public void setTvo(TheaterVO tvo) {
        this.tvo = tvo;
    }

    public String getBoardIdx() {
        return boardIdx;
    }

    public void setBoardIdx(String boardIdx) {
        this.boardIdx = boardIdx;
    }

    public String getAdminIdx() {
        return adminIdx;
    }

    public void setAdminIdx(String adminIdx) {
        this.adminIdx = adminIdx;
    }

    public String gettIdx() {
        return tIdx;
    }

    public void settIdx(String tIdx) {
        this.tIdx = tIdx;
    }

    public String getBoardType() {
        return boardType;
    }

    public void setBoardType(String boardType) {
        this.boardType = boardType;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public String getBoardContent() {
        return boardContent;
    }

    public void setBoardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    public String getBoardRegDate() {
        return boardRegDate;
    }

    public void setBoardRegDate(String boardRegDate) {
        this.boardRegDate = boardRegDate;
    }

    public String getBoardEndRegDate() {
        return boardEndRegDate;
    }

    public void setBoardEndRegDate(String boardEndRegDate) {
        this.boardEndRegDate = boardEndRegDate;
    }

    public String getBoardStatus() {
        return boardStatus;
    }

    public void setBoardStatus(String boardStatus) {
        this.boardStatus = boardStatus;
    }
}
