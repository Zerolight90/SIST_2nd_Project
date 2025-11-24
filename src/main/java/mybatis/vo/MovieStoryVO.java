package mybatis.vo;

public class MovieStoryVO {
    private String posterUrl;
    private String title;
    private String comment; // 관람평 내용
    private String mIdx; // 영화 인덱스 추가

    private String reviewIdx; // 리뷰
    private String rating; // 별점

    // Getter and Setter for posterUrl
    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    // Getter and Setter for title
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // Getter and Setter for comment
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    // Getter and Setter for mIdx
    public String getmIdx() {
        return mIdx;
    }

    public void setmIdx(String mIdx) {
        this.mIdx = mIdx;
    }

    public String getReviewIdx() {
        return reviewIdx;
    }

    public void setReviewIdx(String reviewIdx) {
        this.reviewIdx = reviewIdx;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }
}