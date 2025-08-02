package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ReservationVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class PaymentMovieAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        long userIdx = 1;

        try {
            String reservIdxParam = request.getParameter("reservIdx");
            // 1. 파라미터가 넘어왔는지 확인
            if (reservIdxParam == null || reservIdxParam.isEmpty()) {
                System.out.println("### MoviePaymentAction 오류: reservIdx 파라미터가 없습니다.");
                return "error.jsp";
            }

            long reservIdx = Long.parseLong(reservIdxParam);
            ReservationVO reservation = ReservationDAO.getReservationDetails(reservIdx);

            // 2. DAO의 결과가 null인지 확인
            if (reservation == null) {
                System.out.println("### MoviePaymentAction 오류: reservIdx '" + reservIdx + "'에 해당하는 예매 정보가 DB에 없습니다.");
                // 여기에 사용자에게 보여줄 에러 메시지를 설정할 수 있습니다.
                request.setAttribute("errorMsg", "유효하지 않은 예매 정보입니다.");
                return "error.jsp";
            }

            List<MyCouponVO> couponList = CouponDAO.getAvailableCouponsByUserId(userIdx);

            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("couponList", couponList);
            request.setAttribute("paymentType", "paymentMovie");

        } catch (NumberFormatException e) {
            System.out.println("### MoviePaymentAction 오류: reservIdx가 올바른 숫자 형식이 아닙니다.");
            return "error.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            return "error.jsp";
        }

        return "payment.jsp";
    }
}