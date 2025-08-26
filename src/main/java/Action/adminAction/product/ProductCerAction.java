package Action.adminAction.product;

import Action.Action;
import mybatis.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProductCerAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prodIdx = request.getParameter("pidx");
        String category = request.getParameter("cerCategory");
        String productName = request.getParameter("cerProductName");
        String description = request.getParameter("cerDescription");
        String img = request.getParameter("cerImg");
        String price = request.getParameter("cerPrice");
        String stock = request.getParameter("cerStock");
        String status = request.getParameter("cerStatus");

        Map<String, String> map = new HashMap<>();
        map.put("prodIdx",prodIdx);
        map.put("category",category);
        map.put("productName",productName);
        map.put("description",description);
        map.put("img",img);
        map.put("price",price);
        map.put("stock",stock);
        map.put("status",status);

        ProductDAO.productCer(map);

        return "Controller?type=productInfo";
    }
}
