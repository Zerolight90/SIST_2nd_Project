package Action;

import mybatis.dao.CouponDAO;
import mybatis.vo.MemVO; // MemVO 임포트
import mybatis.vo.MyCouponVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트
import java.util.List;

public class MyCouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemVO mvo = (MemVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_couponList.jsp";
        }
        long userIdx = mvo.getUserIdx();

        List<MyCouponVO> list = CouponDAO.getCouponHistory(userIdx);
        request.setAttribute("couponList", list);
        return "/mypage/myPage_couponList.jsp";
    }
}