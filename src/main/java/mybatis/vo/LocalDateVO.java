package mybatis.vo;

import java.time.LocalDate;

public class LocalDateVO {
    private String locDate;
    private String dow;

    public String getLocDate() {
        return locDate;
    }

    public void setLocDate(String locDate) {
        this.locDate = locDate;
    }

    public String getDow() {
        return dow;
    }

    public void setDow(String dow) {
        this.dow = dow;
    }
}
