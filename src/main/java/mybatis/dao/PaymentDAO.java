package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;

public class PaymentDAO {

    public static int addPayment(PaymentVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.insert("payment.addPayment", vo);
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
}