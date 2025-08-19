package Action;

import mybatis.dao.MemberDAO;
import mybatis.dao.NmemDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Nmember_chkAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            String u_name = request.getParameter("u_name");
            String u_pw = request.getParameter("u_pw");
            String u_birth = request.getParameter("u_birth");

            NmemVO nonvo = NmemDAO.chk(u_name, u_pw, u_birth);

            if (nonvo != null) {
                HttpSession session = request.getSession();
                request.setAttribute("nonvo", nonvo);

                return "Controller?type=myPage";
            }else {
                // 로그인 실패
//                System.out.println("Login failed for user: " + u_id);
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "예매 내역이 없습니다.");
                return "/join/nonmenber.jsp";
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return "Controller?type=myPage";
    }
}
