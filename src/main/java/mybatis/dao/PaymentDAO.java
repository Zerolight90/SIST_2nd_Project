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

    public static PaymentVO[] adminSearchPayment(Map<String, String> map){
        PaymentVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PaymentVO> list = ss.selectList("payment.adminSearchPayment", map);
        ar = new PaymentVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    // 트랜잭션 관리를 위해 SqlSession을 파라미터로 받도록 메소드 추가
    public static PaymentVO getPaymentByPaymentKey(String paymentKey, SqlSession ss) {
        return ss.selectOne("payment.getPaymentByPaymentKey", paymentKey);
    }

    public static int updatePaymentToCancelled(String paymentKey, SqlSession ss) {
        return ss.update("payment.updatePaymentToCancelled", paymentKey);
    }

    // ## 비회원 예매/구매 내역 조회를 위한 메소드 추가 ##
    // Action에서 트랜잭션 관리를 위해 SqlSession을 파라미터로 받습니다.
    public static PaymentVO getNmemPaymentHistory(Map<String, String> params, SqlSession ss) {
        return ss.selectOne("payment.getNmemPaymentHistory", params);
    }

}