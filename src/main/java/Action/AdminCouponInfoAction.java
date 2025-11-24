package Action;

import mybatis.dao.CouponDAO;
import mybatis.vo.CouponVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminCouponInfoAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        CouponVO[] ar = CouponDAO.getAllCoupon();

        request.setAttribute("ar", ar);

        return "admin/adminCoupon.jsp";
    }
}
