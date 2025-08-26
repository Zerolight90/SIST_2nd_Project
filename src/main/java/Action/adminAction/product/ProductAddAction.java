package Action.adminAction.product;

import Action.Action;
import mybatis.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProductAddAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String category = request.getParameter("addCategory");
        String productName = request.getParameter("addProductName");
        String description = request.getParameter("addDescription");
        String img = request.getParameter("addImg");
        String price = request.getParameter("addPrice");
        String stock = request.getParameter("addStock");
        String status = String.valueOf(0);

        Map<String, String> map = new HashMap<>();
        map.put("prodCategory", category);
        map.put("prodName", productName);
        map.put("prodInfo", description);
        map.put("prodImg", img);
        map.put("prodPrice", price);
        map.put("prodStock", stock);
        map.put("prodStatus", status);

        ProductDAO.productAdd(map);

        return "Controller?type=productInfo";
    }
}
