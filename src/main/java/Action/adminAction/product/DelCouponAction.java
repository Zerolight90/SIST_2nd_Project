package Action.adminAction.product;

import Action.Action;
import mybatis.dao.CouponDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DelCouponAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String cIdx = request.getParameter("cIdx");
        System.out.println(cIdx);

        CouponDAO.delCoupon(cIdx);

        return "Controller?type=adminCouponInfo";
    }
}
