package mybatis.vo;

public class NmemVO {

    private String nIdx, name, email, regDate, phone;

    public NmemVO(String nIdx, String name, String email, String regDate, String phone) {
        this.nIdx = nIdx;
        this.name = name;
        this.email = email;
        this.regDate = regDate;
        this.phone = phone;
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

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
