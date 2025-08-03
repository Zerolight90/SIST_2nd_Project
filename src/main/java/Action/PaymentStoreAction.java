package Action;

import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentStoreAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 1. 상품 ID만 파라미터로 받기
            int productIdx = Integer.parseInt(request.getParameter("productIdx"));

            ProductVO product = ProductDAO.getProductById(productIdx);

            if (product == null) {
                request.setAttribute("errorMsg", "존재하지 않는 상품입니다.");
                return "error.jsp";
            }

            // 2. 수량을 1로 고정하여 최종 금액을 계산
            int finalAmount = product.getProdPrice(); // 수량이 1이므로 상품 가격과 동일

            // 3. JSP에 필요한 정보들을 전달
            request.setAttribute("productInfo", product);
            request.setAttribute("finalAmount", finalAmount);
            request.setAttribute("paymentType", "paymentStore");

        } catch (Exception e) {
            e.printStackTrace();
            return "error.jsp";
        }

        return "payment.jsp";
    }
}