package Action;

import mybatis.dao.searchDAO;
import mybatis.vo.MemberVO;
import javax.servlet.http.*;
import javax.servlet.*;

public class SearchIdPwAction implements Action {
    private searchDAO dao = new searchDAO();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch(Exception e){
            e.printStackTrace();
        }

        String name = request.getParameter("u_name");
        String year = request.getParameter("u_year");
        String month = request.getParameter("u_month");
        String day = request.getParameter("u_day");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");

        // 생년월일 유효성 체크 및 포맷팅
        String birth = null;
        try {
            if (year != null && !year.isEmpty() && month != null && !month.isEmpty() && day != null && !day.isEmpty()) {
                int m = Integer.parseInt(month);
                int d = Integer.parseInt(day);
                birth = String.format("%s%02d%02d", year, m, d);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "생년월일 입력이 올바르지 않습니다.");
            try {
                request.getRequestDispatcher("/join/searchIdResult.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return null;
        }

        // 필수값 체크 (간단히 예시)
        if (name == null || name.isEmpty() || phone == null || phone.isEmpty() || birth == null || email == null || email.isEmpty()) {
            request.setAttribute("errorMsg", "필수 입력값이 누락되었습니다.");
            try {
                request.getRequestDispatcher("/join/searchIdResult.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        MemberVO member = dao.findByFields(name, phone, birth, email);

        try {
            if (member != null) {
                request.setAttribute("foundId", member.getId());
                request.setAttribute("u_name", name);
            } else {
                request.setAttribute("errorMsg", "일치하는 회원 정보가 없습니다.");
            }
            RequestDispatcher rd = request.getRequestDispatcher("/join/searchIdResult.jsp");
            rd.forward(request, response);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return "/error.jsp";
        }
    }
}
