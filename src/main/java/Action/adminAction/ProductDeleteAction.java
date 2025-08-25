package Action.adminAction;

import Action.Action;
import mybatis.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductDeleteAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prodIdx =  request.getParameter("prodIdx");

        ProductDAO.productDel(prodIdx);

        return "Controller?type=productInfo";
    }
}
