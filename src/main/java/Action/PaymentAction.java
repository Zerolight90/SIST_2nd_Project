package Action;

import mybatis.dao.CouponDAO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ProductVO;
import mybatis.vo.ReservationVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("type");

        if (type == null || type.isEmpty()) {
            type = "pay_movie";
        }
        request.setAttribute("paymentType", type);

        long userIdx = 1; // 임시: 나중에 세션에서 실제 로그인 사용자 ID를 가져와야 함

        if ("pay_store".equals(type)) {
            // [스토어 상품 구매 처리]
            request.setAttribute("paymentType", "pay_store");

            ProductVO product = new ProductVO();
            product.setProdIdx(101);
            product.setProdName("SISTBOX 콤보");
            product.setProdPrice(15000);
            product.setProdImg(request.getContextPath() + "/images/sistboxcombo.png");
            request.setAttribute("productInfo", product);

        } else { // 'pay_movie'
            // [영화 예매 처리]
            request.setAttribute("paymentType", "pay_movie");

            List<MyCouponVO> couponList = CouponDAO.getAvailableCouponsByUserId(userIdx);
            request.setAttribute("couponList", couponList);

            ReservationVO reservation = new ReservationVO();
            reservation.setReservIdx(201);
            reservation.setUserIdx(1);
            request.setAttribute("reservationInfo", reservation);

            Map<String, Object> displayInfo = new HashMap<>();
            displayInfo.put("title", "자전차왕 엄복동");
            displayInfo.put("posterUrl", request.getContextPath() + "/images/umbokdong.png");
            displayInfo.put("details", new String[]{
                    "2025-07-30 (수) 09:00 - 10:58", "IMAX 관", "성인 2명"
            });
            displayInfo.put("originalPrice", 30000);
            displayInfo.put("initialDiscount", 4000);
            displayInfo.put("finalAmount", 26000);
            request.setAttribute("displayInfo", displayInfo);
        }
        return "payment.jsp";
    }
}