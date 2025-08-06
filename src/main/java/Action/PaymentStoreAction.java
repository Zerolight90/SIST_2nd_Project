package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class PaymentStoreAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // [버그 추적] execute 메소드 실행 시작
        System.out.println("\n--- PaymentStoreAction 시작 ---");

        // 인코딩 설정
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        MemVO mvo = (MemVO) session.getAttribute("loginUser");
        long userIdx = (mvo == null) ? 1L : mvo.getUserIdx();

        try {
            String prodIdxStr = request.getParameter("prodIdx");
            String prodName = request.getParameter("prodName");
            String prodImg = request.getParameter("prodImg");
            String amountStr = request.getParameter("amount");

            // 필수 파라미터가 없는 경우 에러 처리
            if (prodIdxStr == null || prodName == null || amountStr == null) {
                request.setAttribute("errorMsg", "필수 상품 정보가 누락되었습니다.");
                return "error.jsp";
            }

            // 전달받은 파라미터로 ProductVO 객체를 직접 생성
            ProductVO product = new ProductVO();
            product.setProdIdx(Long.parseLong(prodIdxStr));
            product.setProdName(prodName);
            product.setProdImg(prodImg);
            product.setProdPrice(Integer.parseInt(amountStr));

            // '매점' 카테고리의 사용 가능한 쿠폰 목록 조회
            List<MyCouponVO> couponList = CouponDAO.getAvailableStoreCoupons(userIdx);

            // 사용자의 포인트 정보를 포함한 전체 회원 정보 조회
            MemVO memberInfo = MemberDAO.getMemberByIdx(userIdx);

            // 조회된 모든 정보를 request 객체에 저장
            request.setAttribute("productInfo", product);
            request.setAttribute("couponList", couponList);
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("paymentType", "paymentStore");

            // 결제 승인 단계에서 사용하기 위해 상품 정보를 세션에 저장
            session.setAttribute("productInfoForPayment", product);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "결제 페이지 로딩 중 오류가 발생했습니다.");
            return "error.jsp";
        }

        return "payment.jsp";
    }
}