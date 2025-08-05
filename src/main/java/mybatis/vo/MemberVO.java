package mybatis.vo;

import java.util.Date;

public class MemberVO {
    private long userIdx;
    private String id;
    private String pw;
    private Date birth;
    private String name;
    private String gender;
    private String phone;
    private String email;
    private int totalPoints;

    // Getter and Setter
    public long getUserIdx() { return userIdx; }
    public void setUserIdx(long userIdx) { this.userIdx = userIdx; }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPw() { return pw; }
    public void setPw(String pw) { this.pw = pw; }
    public Date getBirth() { return birth; }
    public void setBirth(Date birth) { this.birth = birth; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public int getTotalPoints() { return totalPoints; }
    public void setTotalPoints(int totalPoints) { this.totalPoints = totalPoints; }
}