package Action;

import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StoreAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        ProductVO[] ar = ProductDAO.getAllProd();
        ProductVO[] sar = ProductDAO.getSnackProd();
        ProductVO[] tar = ProductDAO.getTicketProd();

        request.setAttribute("ar", ar);
        request.setAttribute("sar", sar);
        request.setAttribute("tar", tar);

        return "store/store.jsp";
    }

}
