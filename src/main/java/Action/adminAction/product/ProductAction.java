package Action.adminAction.product;

import Action.Action;
import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        ProductVO[] ar = ProductDAO.getAllProd();

        request.setAttribute("ar", ar);

        return "admin/adminProdList.jsp";
    }
}
