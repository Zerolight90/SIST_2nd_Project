package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;

public class PaymentDAO {

    // 결제 정보 추가
    public static int addPayment(PaymentVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = 0;
        try {
            result = ss.insert("payment.addPayment", vo);
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