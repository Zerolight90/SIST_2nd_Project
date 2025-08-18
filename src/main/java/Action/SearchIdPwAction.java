package Action;

import mybatis.dao.searchDAO;
import mybatis.vo.MemberVO;
import javax.servlet.http.*;
import javax.servlet.*;

public class SearchIdPwAction implements Action {
    private searchDAO dao = new searchDAO();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try { request.setCharacterEncoding("UTF-8"); } catch(Exception e){}

        String name = request.getParameter("u_name");
        String year = request.getParameter("u_year");
        String month = request.getParameter("u_month");
        String day = request.getParameter("u_day");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");

        String birth = null;
        if (year != null && month != null && day != null && !year.isEmpty()) {
            birth = String.format("%s%02d%02d", year, Integer.parseInt(month), Integer.parseInt(day));
        }

        MemberVO member = dao.findByFields(name, phone, birth, email);

        try {
            if (member != null) {
                request.setAttribute("foundId", member.getId());
            } else {
                request.setAttribute("errorMsg", "일치하는 회원 정보가 없습니다.");
            }
            RequestDispatcher rd = request.getRequestDispatcher("/result/searchIdResult.jsp");
            rd.forward(request, response);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return "/error.jsp";
        }
    }
}
