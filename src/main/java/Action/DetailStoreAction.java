package Action;

import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DetailStoreAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prodIdx = request.getParameter("prodIdx");

        ProductVO vo = ProductDAO.getSelectProd(prodIdx);

        request.setAttribute("vo", vo);

        return "store/detailStore.jsp";
    }
}
