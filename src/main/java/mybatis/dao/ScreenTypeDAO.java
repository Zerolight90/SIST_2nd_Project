package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ScreenTypeVO;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class ScreenTypeDAO {
    // 자체적인 가격 정보
    public static ScreenTypeVO[] getPrice() {
        ScreenTypeVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<ScreenTypeVO> list = ss.selectList("sType.getPrice");
        ar = new ScreenTypeVO[list.size()];
        list.toArray(ar);
        ss.close();
        return ar;
    }
    
    // 영화에 따른 가격 정보
    public static ScreenTypeVO getPrice(String sCode) {
        ScreenTypeVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        vo = ss.selectOne("sType.getType", sCode);
        ss.close();
        return vo;
    }
}
