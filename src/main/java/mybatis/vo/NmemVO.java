package mybatis.vo;

public class NmemVO {

    private String nIdx, name, email, joinDate, phone, password, birth;

    public NmemVO(String nIdx, String name, String email, String joinDate, String phone, String password, String birth) {
        this.nIdx = nIdx;
        this.name = name;
        this.email = email;
        this.joinDate = joinDate;
        this.phone = phone;
        this.password = password;
        this.birth = birth;
    }

    public String getnIdx() {
        return nIdx;
    }

    public void setnIdx(String nIdx) {
        this.nIdx = nIdx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getjoinDate() {
        return joinDate;
    }

    public void setjoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }
}
