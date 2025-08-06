package Action;

import mybatis.dao.ReservationDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyReservationVO;
import util.Paging;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트
import java.util.List;

public class MyReservationAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_reservationHistory.jsp";
        }
        String userIdx = mvo.getUserIdx();

        Paging pvo = new Paging(5, 5);
        pvo.setTotalCount(ReservationDAO.getTotalReservationCount(Long.parseLong(userIdx)));

        String cPage = request.getParameter("cPage");
        if (cPage != null) pvo.setNowPage(Integer.parseInt(cPage));

        List<MyReservationVO> list = ReservationDAO.getReservationList(Long.parseLong(userIdx), pvo.getBegin(), pvo.getEnd());

        request.setAttribute("reservationList", list);
        request.setAttribute("pvo", pvo);

        return "/mypage/myPage_reservationHistory.jsp";
    }
}