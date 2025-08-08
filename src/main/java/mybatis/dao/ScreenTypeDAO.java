package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ScreenTypeVO;
import org.apache.ibatis.session.SqlSession;

public class ScreenTypeDAO {

    public static ScreenTypeVO getPrice(String sCode) {
        ScreenTypeVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        vo  = (ScreenTypeVO) ss.selectOne("sType.getType", sCode);
        ss.close();
        return  vo;
    }
}
