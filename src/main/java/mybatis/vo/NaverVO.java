package mybatis.vo;

public class NaverVO {
    private String n_id, n_name, n_email, n_gender, n_Phone;
    private String n_birthday; // 최종 저장될 yyyy-MM-dd 형태
    private String birthYear;  // 예: "1995"
    private String pw;

    public String getPw() { return pw; }
    public void setPw(String pw) { this.pw = pw; }

    public String getN_id() { return n_id; }
    public void setN_id(String n_id) { this.n_id = n_id; }

    public String getN_name() { return n_name; }
    public void setN_name(String n_name) { this.n_name = n_name; }

    public String getN_email() { return n_email; }
    public void setN_email(String n_email) { this.n_email = n_email; }

    public String getN_gender() { return n_gender; }
    public void setN_gender(String n_gender) { this.n_gender = n_gender; }

    public String getN_Phone() { return n_Phone; }
    public void setN_Phone(String n_Phone) { this.n_Phone = n_Phone; }

    public String getN_birthday() { return n_birthday; }
    public void setN_birthday(String n_birthday) { this.n_birthday = n_birthday; }

    public String getBirthYear() { return birthYear; }
    public void setBirthYear(String birthYear) { this.birthYear = birthYear; }
}
