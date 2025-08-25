package Action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TermsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 단순히 JSP 반환
        return "/join/terms.jsp";  // terms.jsp 위치에 맞게 경로 수정
    }
}