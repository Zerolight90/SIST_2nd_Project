package Action.adminAction.product;

import Action.Action;
import mybatis.dao.CouponDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AddCouponAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();
        map.put("category", request.getParameter("category"));
        map.put("cName", request.getParameter("cName"));
        map.put("cInfo", request.getParameter("cInfo"));
        map.put("disValue", request.getParameter("disValue"));

        CouponDAO.addCoupon(map);

        return "Controller?type=adminCouponInfo";
    }
}
