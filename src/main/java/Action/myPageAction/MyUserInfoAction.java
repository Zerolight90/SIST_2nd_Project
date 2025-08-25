package Action.myPageAction;

import Action.Action;
import mybatis.vo.MemberVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트

public class MyUserInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_userInfo.jsp";
        }
        // DAO를 다시 호출할 필요 없이, 세션에 있는 MemVO 객체를 그대로 사용합니다.
        request.setAttribute("memberInfo", mvo);
        return "/mypage/myPage_userInfo.jsp";
    }
}