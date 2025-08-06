package mybatis.vo;

public class MemVO {
    String id;
    String pw;
    String birth;
    String name;
    String gender;
    String phone;
    String email;
    String totalPoints;
    String status;
    private long userIdx;
    //기본 생성자
    public MemVO(){}

    public MemVO(String id, String pw, String birth, String name, String gender, String phone, String email, String status, long userIdx) {
        this.id = id;
        this.pw = pw;
        this.birth = birth;
        this.name = name;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.status = status;
    }

    public long getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(long userIdx) {
        this.userIdx = userIdx;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(String totalPoints) {
        this.totalPoints = totalPoints;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
