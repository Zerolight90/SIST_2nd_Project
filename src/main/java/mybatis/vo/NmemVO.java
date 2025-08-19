package mybatis.vo;

public class NmemVO {

    private long nIdx; // DB의 BIGINT 타입에 맞춰 long으로 변경
    private String name;
    private String email;
    private String regDate;
    private String phone;
    private String password; // 예매 시 사용할 비밀번호 필드 추가

    /**
     * MyBatis가 객체를 생성하기 위해 필요한 기본 생성자
     */
    public NmemVO() {}

    public NmemVO(long nIdx, String name, String email, String regDate, String phone) {
        this.nIdx = nIdx;
        this.name = name;
        this.email = email;
        this.regDate = regDate;
        this.phone = phone;
    }

    // --- Getters and Setters ---
    public long getnIdx() {
        return nIdx;
    }

    public void setnIdx(long nIdx) {
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}