package Action;

import mybatis.dao.CouponDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트
import java.util.List;

public class MyCouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
//        System.out.println( "MyCouponAction");
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_couponList.jsp";
        }
        String userIdx = mvo.getUserIdx();

        List<MyCouponVO> list = CouponDAO.getCouponHistory(Long.parseLong(userIdx));
        request.setAttribute("couponList", list);
        return "/mypage/myPage_couponList.jsp";
    }
}