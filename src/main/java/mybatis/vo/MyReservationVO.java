package mybatis.vo;

import java.util.Date;

public class MyReservationVO {
    private String posterUrl; // movie 테이블 (가상)
    private Date paymentDate; // payment 테이블
    private String movieTitle;  // movie 테이블
    private String theaterInfo; // theater 테이블
    private String screenDate;  // time_table 테이블

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getTheaterInfo() {
        return theaterInfo;
    }

    public void setTheaterInfo(String theaterInfo) {
        this.theaterInfo = theaterInfo;
    }

    public String getScreenDate() {
        return screenDate;
    }

    public void setScreenDate(String screenDate) {
        this.screenDate = screenDate;
    }
}