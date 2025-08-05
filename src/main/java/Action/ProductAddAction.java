package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductAddAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String category = request.getParameter("addCategory");
        String productName = request.getParameter("addProductName");
        String description = request.getParameter("addDescription");
        String img = request.getParameter("addImg");
        String price = request.getParameter("addPrice");
        String stock = request.getParameter("addStock");
        String status = request.getParameter("addStatus");


        return "adminProdList.jsp";
    }
}
