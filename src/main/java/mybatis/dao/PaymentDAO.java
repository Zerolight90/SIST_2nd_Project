package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class PaymentDAO {

    // 결제 정보 추가 (PaymentVO 변경사항 반영)
    public static int addPayment(PaymentVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession(false); // Auto-commit false
        int result = 0;
        try {
            // "payment.addPayment"는 PaymentMapper.xml에 정의된 ID
            result = ss.insert("payment.addPayment", vo); // Use 'payment' namespace
            if (result > 0) {
                ss.commit(); // 성공 시 커밋
            } else {
                ss.rollback(); // 실패 시 롤백
            }
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback(); // 예외 발생 시 롤백
        } finally {
            if (ss != null) {
                ss.close(); // 세션 닫기
            }
        }
        return result;
    }

    // 모든 결제 목록 조회 (테스트용)
    public static List<PaymentVO> getAllPayments() {
        SqlSession ss = FactoryService.getFactory().openSession(); // Default true (read-only operations)
        List<PaymentVO> list = null;
        try {
            // "payment.getAllPayments"는 PaymentMapper.xml에 정의될 ID
            list = ss.selectList("payment.getAllPayments"); // Use 'payment' namespace
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return list;
    }

    // 특정 사용자(userIdx)의 결제 목록 조회 (로그인 기능 구현 시 사용)
    public static List<PaymentVO> getPaymentsByUserIdx(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<PaymentVO> list = null;
        try {
            // "payment.getPaymentsByUserIdx"는 PaymentMapper.xml에 정의될 ID
            list = ss.selectList("payment.getPaymentsByUserIdx", userIdx);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return list;
    }

    // 결제 상태 및 취소일 업데이트 (RefundAction에서 사용)
    public static int updatePaymentStatusAndCancelDate(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.update("payment.updatePaymentStatusAndCancelDate", params);
            if (result > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return result;
    }
}