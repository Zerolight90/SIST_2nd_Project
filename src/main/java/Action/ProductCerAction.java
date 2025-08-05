package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductCerAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String category = request.getParameter("cerCategory");
        String productName = request.getParameter("cerProductName");
        String description = request.getParameter("cerDescription");
        String img = request.getParameter("cerImg");
        String price = request.getParameter("cerPrice");
        String stock = request.getParameter("cerStock");
        String status = request.getParameter("cerStatus");


        return "adminProdList.jsp";
    }
}
