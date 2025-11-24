package mybatis.vo;

import java.util.List;

public class MovieVO {
    private String mIdx, name, dir, gen, age, date, actor, synop, audNum, runtime, poster, status, trailer, background;

    private List<ReviewVO> reviewList;

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    private double bookingRate;

    public String getRuntime() {
        return runtime;
    }

    public void setRuntime(String runtime) {
        this.runtime = runtime;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public double getBookingRate() {
        return bookingRate;
    }

    public void setBookingRate(double bookingRate) {
        this.bookingRate = bookingRate;
    }

    public String getmIdx() {
        return mIdx;
    }

    public void setmIdx(String mIdx) {
        this.mIdx = mIdx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }

    public String getGen() {
        return gen;
    }

    public void setGen(String gen) {
        this.gen = gen;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getSynop() {
        return synop;
    }

    public void setSynop(String synop) {
        this.synop = synop;
    }

    public String getAudNum() {
        return audNum;
    }

    public void setAudNum(String audNum) {
        this.audNum = audNum;
    }

    public List<ReviewVO> getReviewList() {
        return reviewList;
    }

    public void setReviewList(List<ReviewVO> reviewList) {
        this.reviewList = reviewList;
    }
}
