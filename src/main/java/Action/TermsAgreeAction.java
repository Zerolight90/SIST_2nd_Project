package Action;

import Action.Action;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TermsAgreeAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 세션에 동의 여부 저장
        request.getSession().setAttribute("agreed", true);

        // 동의했으니 회원가입 폼으로 이동
        return "redirect:Controller?type=join";

    }
}
