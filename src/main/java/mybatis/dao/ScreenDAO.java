package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ScreenVO;
import org.apache.ibatis.session.SqlSession;

public class ScreenDAO {
    public static ScreenVO getById(String tIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        ScreenVO screen = ss.selectOne("screen.select", tIdx);
        ss.close();
        return screen;
    }
}
