package mybatis.vo;

import java.time.LocalDate;
import java.time.DateTimeException;

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

    // 외부(네이버)에서 들어온 월/일 원본을 그대로 보관하려면 별도 필드를 사용하세요.
    // 여기서는 n_birthday를 최종 yyyy-MM-dd 문자열로 유지합니다.

    public String getN_birthday() { return n_birthday; }

    // 네이버에서 들어오는 "MM-dd" 또는 "MM/dd" 또는 "MMdd" 등 다양한 형식을 허용하도록 처리
    public void setN_birthday(String n_birthday) {
        this.n_birthday = n_birthday;
        combineBirthdayIfPossible();
    }

    public String getBirthYear() { return birthYear; }

    public void setBirthYear(String birthYear) {
        this.birthYear = birthYear;
        combineBirthdayIfPossible();
    }

    // birthYear와 n_birthday가 모두 존재하면 합쳐서 yyyy-MM-dd로 변환해 n_birthday에 저장
    private void combineBirthdayIfPossible() {
        if (birthYear == null || birthYear.trim().isEmpty()) return;
        if (n_birthday == null || n_birthday.trim().isEmpty()) return;

        String yearStr = birthYear.trim();
        String mmdd = n_birthday.trim().replaceAll("", ""); // 숫자만 추출 (예: "05-24" -> "0524")

        try {
            if (mmdd.length() == 4) {
                int month = Integer.parseInt(mmdd.substring(0, 2));
                int day   = Integer.parseInt(mmdd.substring(2, 4));
                LocalDate d = LocalDate.of(Integer.parseInt(yearStr), month, day);
                this.n_birthday = d.toString(); // LocalDate.toString() -> "yyyy-MM-dd"
            }
            // 필요하면 mmdd.length() == 3 (Mdd) 등 추가 처리 로직을 확장하세요.
        } catch (NumberFormatException | DateTimeException e) {
            // 파싱/유효성 실패 시 원래 값 유지하거나 null로 설정하는 등 정책을 적용하세요.
            // 예: this.n_birthday = null;
        }
    }


}
