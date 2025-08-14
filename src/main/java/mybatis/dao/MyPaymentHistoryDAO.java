package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyPaymentHistoryVO;
import org.apache.ibatis.session.SqlSession;
import java.util.List;
import java.util.Map;

public class MyPaymentHistoryDAO {

    public static int getTotalHistoryCount(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("myPaymentHistory.getTotalHistoryCount", params);
        ss.close();
        return count;
    }

    public static List<MyPaymentHistoryVO> getHistoryList(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyPaymentHistoryVO> list = ss.selectList("myPaymentHistory.getHistoryList", params);
        ss.close();
        return list;
    }
}