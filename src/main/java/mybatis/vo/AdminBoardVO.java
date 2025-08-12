package mybatis.vo;

public class AdminBoardVO {

    private String boardIdx, parent_boardIdx, adminIdx, tIdx, boardType, sub_boardType, boardTitle, boardContent, file_name, ori_name, boardRegDate, boardEndRegDate, boardStatus, is_answered;
    private TheaterVO tvo;

    private MemberVO mvo; //회원정보
    private NmemVO nmemvo; //비회원정보
    private AdminBoardVO bvo;//답변글

    public TheaterVO getTvo() {
        return tvo;
    }

    public void setTvo(TheaterVO tvo) {
        this.tvo = tvo;
    }

    public MemberVO getMvo() {
        return mvo;
    }

    public void setMvo(MemberVO mvo) {
        this.mvo = mvo;
    }

    public NmemVO getNmemvo() {
        return nmemvo;
    }

    public void setNmemvo(NmemVO nmemvo) {
        this.nmemvo = nmemvo;
    }

    public AdminBoardVO getBvo() {
        return bvo;
    }

    public void setBvo(AdminBoardVO bvo) {
        this.bvo = bvo;
    }

    public String getBoardIdx() {
        return boardIdx;
    }

    public void setBoardIdx(String boardIdx) {
        this.boardIdx = boardIdx;
    }

    public String getParent_boardIdx() {
        return parent_boardIdx;
    }

    public void setParent_boardIdx(String parent_boardIdx) {
        this.parent_boardIdx = parent_boardIdx;
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

    public String getSub_boardType() {
        return sub_boardType;
    }

    public void setSub_boardType(String sub_boardType) {
        this.sub_boardType = sub_boardType;
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

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getOri_name() {
        return ori_name;
    }

    public void setOri_name(String ori_name) {
        this.ori_name = ori_name;
    }

    public String getIs_answered() {
        return is_answered;
    }

    public void setIs_answered(String is_answered) {
        this.is_answered = is_answered;
    }

    @Override
    public String toString() {
        return "AdminBoardVO{" +
                "boardIdx='" + boardIdx + '\'' +
                ", parent_boardIdx='" + parent_boardIdx + '\'' +
                ", adminIdx='" + adminIdx + '\'' +
                ", tIdx='" + tIdx + '\'' +
                ", boardType='" + boardType + '\'' +
                ", sub_boardType='" + sub_boardType + '\'' +
                ", boardTitle='" + boardTitle + '\'' +
                ", boardContent='" + boardContent + '\'' +
                ", file_name='" + file_name + '\'' +
                ", ori_name='" + ori_name + '\'' +
                ", boardRegDate='" + boardRegDate + '\'' +
                ", boardEndRegDate='" + boardEndRegDate + '\'' +
                ", boardStatus='" + boardStatus + '\'' +
                ", is_answered='" + is_answered + '\'' +
                ", tvo=" + tvo +
                ", mvo=" + mvo +
                ", nmemvo=" + nmemvo +
                ", bvo=" + bvo +
                '}';
    }
}
