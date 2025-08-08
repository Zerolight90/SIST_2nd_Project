package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaymentDAO {

    // 결제 정보 추가
    // 트랜잭션 관리를 위해 SqlSession을 파라미터로 받는 메소드
    public static long addPayment(PaymentVO vo, SqlSession ss) {
        // Action에서 commit/rollback을 제어하므로 여기서는 insert만 수행
        ss.insert("payment.addPayment", vo);
        return vo.getPaymentIdx(); // keyProperty에 의해 반환된 ID
    }

    // 결제 상태를 '취소'로 변경 (환불 처리)
    public static int cancelPayment(String paymentKey) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        Map<String, Object> map = new HashMap<>();
        map.put("paymentKey", paymentKey);
        map.put("paymentStatus", 1); // 1: 취소
        map.put("paymentCancelDate", new Date());

        try {
            result = ss.update("payment.updatePaymentStatusAndCancelDate", map);
            if(result > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback();
        } finally {
            if (ss != null) ss.close();
        }
        return result;
    }

    // 특정 사용자의 모든 결제 내역 조회
    public static List<PaymentVO> getPaymentsByUser(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<PaymentVO> list = ss.selectList("payment.getPaymentsByUserIdx", userIdx);
        ss.close();
        return list;
    }

    public static PaymentVO[] getAllPayment(){
        PaymentVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PaymentVO> list = ss.selectList("payment.getAllPayment");
        ar = new PaymentVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }
}