package Action;

import Action.Action;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JoinAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //1. 요청 파라미터 수집
        String id = request.getParameter("u_id");
        String pw = request.getParameter("u_pw");
        String birthYearStr = request.getParameter("u_year");
        String birthMonthStr = request.getParameter("u_month");
        String birthDayStr = request.getParameter("u_day");
        String formattedBirth = null;

        if (birthYearStr != null && !birthYearStr.isEmpty() &&
                birthMonthStr != null && !birthMonthStr.isEmpty() &&
                birthDayStr != null && !birthDayStr.isEmpty()) {

            String paddedMonth = String.format("%02d", Integer.parseInt(birthMonthStr));
            String paddedDay = String.format("%02d", Integer.parseInt(birthDayStr));
            formattedBirth = birthYearStr + "-" + paddedMonth + "-" + paddedDay;
        }

        String name = request.getParameter("u_name");
        String gender = request.getParameter("u_gender");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");


        //2. MemVO 객체에 세팅
        MemVO mvo = new MemVO();
        mvo.setId(id);
        mvo.setPw(pw);
        mvo.setBirth(formattedBirth);
        mvo.setName(name);
        mvo.setGender(gender);
        mvo.setPhone(phone);
        mvo.setEmail(email);

        //3. DAO 호출해서 회원가입 시도
        int result = MemberDAO.registry(mvo);

        if(result > 0) {
            // 성공시(login.jsp나 index.jsp 등 적절한 페이지 지정)
            request.setAttribute("msg", "회원가입 되었습니다.");
            return "/join/login.jsp"; // 회원가입 성공 후 이동할 페이지 경로
        } else {
            // 실패 시 다시 회원가입 페이지로 돌아감
            request.setAttribute("error", "회원가입 실패했습니다. 다시 시도하세요.");
            return "/join.jsp"; // 회원가입 폼 페이지 경로
        }
    }
}
