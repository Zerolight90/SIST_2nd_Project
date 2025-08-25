package Action.paymentAction;

import Action.Action;
import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentStoreAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) { e.printStackTrace(); }

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        // 스토어는 회원 전용이므로 비로그인 시 로그인 페이지로 보냄
        if (mvo == null) {
            return "redirect:Controller?type=login&returnUrl=store"; // 스토어로 돌아오도록 파라미터 추가
        }
        String userIdx = mvo.getUserIdx();

        try {
            String prodIdxStr = request.getParameter("prodIdx");
            String prodName = request.getParameter("prodName");
            String prodImg = request.getParameter("prodImg");
            String amountStr = request.getParameter("amount");
            String quantityStr = request.getParameter("quantity");

            ProductVO product = new ProductVO();
            product.setProdIdx(Long.parseLong(prodIdxStr));
            product.setProdName(prodName);
            product.setProdImg(prodImg);
            product.setProdPrice(Integer.parseInt(amountStr));
            product.setQuantity(Integer.parseInt(quantityStr));

            List<MyCouponVO> couponList = CouponDAO.getAvailableStoreCoupons(Long.parseLong(userIdx));
            MemberVO memberInfo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));

            // ★★★★★ [핵심 수정] ★★★★★
            String orderId = "SIST_STORE_" + System.currentTimeMillis();

            Map<String, Object> paymentContext = new HashMap<>();
            paymentContext.put("paidItem", product);
            paymentContext.put("mvo", mvo);
            paymentContext.put("nmemvo", null); // 스토어는 회원 전용

            session.setAttribute(orderId, paymentContext);
            request.setAttribute("orderId", orderId);
            // ★★★★★★★★★★★★★★★★★★★★★

            request.setAttribute("productInfo", product);
            request.setAttribute("couponList", couponList);
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("paymentType", "paymentStore");
            request.setAttribute("isGuest", false);

        } catch (Exception e) {
            e.printStackTrace();
            return "error.jsp";
        }

        return "payment.jsp";
    }
}