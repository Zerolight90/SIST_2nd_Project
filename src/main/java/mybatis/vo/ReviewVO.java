package mybatis.vo;

public class ReviewVO {
    private String reviewIdx, mIdx, reviewRating, reviewContent, reviewDate, reviewStatus, ip, userIdx; // userIdx 추가
    private MemberVO member; // MemberVO 객체 추가

    public String getReviewIdx() {
        return reviewIdx;
    }

    public void setReviewIdx(String reviewIdx) {
        this.reviewIdx = reviewIdx;
    }

    public String getmIdx() {
        return mIdx;
    }

    public void setmIdx(String mIdx) {
        this.mIdx = mIdx;
    }

    public String getReviewRating() {
        return reviewRating;
    }

    public void setReviewRating(String reviewRating) {
        this.reviewRating = reviewRating;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public String getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(String reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(String reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    // userIdx Getter and Setter 추가
    public String getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(String userIdx) {
        this.userIdx = userIdx;
    }

    // MemberVO Getter and Setter 추가
    public MemberVO getMember() {
        return member;
    }

    public void setMember(MemberVO member) {
        this.member = member;
    }
}
