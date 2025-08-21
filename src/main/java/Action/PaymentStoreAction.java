package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class PaymentStoreAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) { e.printStackTrace(); }

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        // 비로그인 시 로그인 페이지로 리다이렉트
        if (mvo == null) {
             return "redirect:Controller?type=login";
        }
        String userIdx = mvo.getUserIdx();

        try {
            String prodIdxStr = request.getParameter("prodIdx");
            String prodName = request.getParameter("prodName");
            String prodImg = request.getParameter("prodImg");
            String amountStr = request.getParameter("amount");

            // 파라미터로 ProductVO 객체 생성
            ProductVO product = new ProductVO();
            product.setProdIdx(Long.parseLong(prodIdxStr));
            product.setProdName(prodName);
            product.setProdImg(prodImg);
            product.setProdPrice(Integer.parseInt(amountStr)); // 총액

            List<MyCouponVO> couponList = CouponDAO.getAvailableStoreCoupons(Long.parseLong(userIdx));
            MemberVO memberInfo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));

            request.setAttribute("productInfo", product);
            request.setAttribute("couponList", couponList);
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("paymentType", "paymentStore");
            request.setAttribute("isGuest", false); // 스토어는 회원 전용

            session.setAttribute("productInfoForPayment", product);

        } catch (Exception e) {
            e.printStackTrace();
            return "error.jsp";
        }

        return "payment.jsp";
    }
}