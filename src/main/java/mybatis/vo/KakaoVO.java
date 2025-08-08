package mybatis.vo;

public class KakaoVO {
    // 카카오 고유 ID 카카오 닉네임
    private String k_id, k_name, k_email;
    // 추가된 필드 (null 허용)
    private String pw, birth, gender, phone;

    public KakaoVO() {}

    public KakaoVO(String k_id, String k_name, String k_email) {
        this.k_id = k_id;
        this.k_name = k_name;
        this.k_email = k_email;

        this.pw = "";
        this.birth = "";
        this.gender = "";
        this.phone = "000-0000-0000";
    }

    public String getK_id() {
        return k_id;
    }

    public void setK_id(String k_id) {
        this.k_id = k_id;
    }

    public String getK_name() {
        return k_name;
    }

    public void setK_name(String k_name) {
        this.k_name = k_name;
    }

    public String getK_email() {
        return k_email;
    }

    public void setK_email(String k_email) {
        this.k_email = k_email;
    }

    public String getPw() { return pw; }
    public void setPw(String pw) { this.pw = pw; }

    public String getBirth() { return birth; }
    public void setBirth(String birth) { this.birth = birth; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    @Override
    public String toString() {

        return "KakaoVO{" +
                "k_id='" + k_id + '\'' +
                ", k_name='" + k_name + '\'' +
                ", k_email='" + k_email + '\'' +
                '}';
    }
}
