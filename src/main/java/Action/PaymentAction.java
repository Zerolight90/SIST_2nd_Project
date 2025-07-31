package Action;

import mybatis.vo.ProductVO;
import mybatis.vo.ReservationVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PaymentAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // Controller로부터 넘어온 type 파라미터를 직접 사용
        String type = request.getParameter("type");

        // type 파라미터가 없거나 비어있는 경우 기본값을 'pay_movie'로 설정
        if (type == null || type.isEmpty()) {
            type = "pay_movie";
        }

        // JSP에서 사용할 수 있도록 paymentType 속성을 설정
        request.setAttribute("paymentType", type);

        if ("pay_store".equals(type)) {
            // [스토어 상품 구매 처리]
            request.setAttribute("paymentType", "pay_store");

            ProductVO product = new ProductVO();
            product.setProdIdx(101); // 예시 데이터
            product.setProdName("SISTBOX 콤보"); // 예시 데이터
            product.setProdPrice(15000); // 예시 데이터
            // 이미 request.getContextPath()를 사용하고 있어 올바른 절대 경로를 생성함
            product.setProdImg(request.getContextPath() + "/images/sistboxcombo.png");
            request.setAttribute("productInfo", product);

        } else { // type이 'pay_movie'이거나 그 외의 경우
            // [영화 예매 처리]
            request.setAttribute("paymentType", "pay_movie");

            ReservationVO reservation = new ReservationVO();
            reservation.setReservIdx(201); // 예시 데이터
            reservation.setUserIdx(1); // 예시 데이터
            request.setAttribute("reservationInfo", reservation);

            Map<String, Object> displayInfo = new HashMap<>();
            displayInfo.put("title", "자전차왕 엄복동"); // 예시 데이터
            // 이미 request.getContextPath()를 사용하고 있어 올바른 절대 경로를 생성함
            displayInfo.put("posterUrl", request.getContextPath() + "/images/umbokdong.png");
            displayInfo.put("details", new String[]{
                    "2025-07-30 (수) 09:00 - 10:58",
                    "IMAX 관",
                    "성인 2명"
            });
            displayInfo.put("price", 30000); // 예시 데이터
            displayInfo.put("discount", 4000); // 예시 데이터
            displayInfo.put("finalAmount", 26000); // 예시 데이터
            request.setAttribute("displayInfo", displayInfo);
        }

        // 결제 페이지 JSP로 포워딩
        return "payment.jsp";
    }
}