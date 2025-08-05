package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.TheaterVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class TheatherDAO {
    // 영화관 목록 반환
    public static List<TheaterVO> getList(){
        List<TheaterVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        // 목록 쿼리
        list = ss.selectList("theater.all");

        ss.close();
        return list;
    }
}
