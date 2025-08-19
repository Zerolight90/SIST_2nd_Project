package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.TheaterVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class TheatherDAO {
    // 영화관 목록 반환
    public static TheaterVO[] getList(){
        List<TheaterVO> list = null;
        TheaterVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        // 목록 쿼리
        list = ss.selectList("theater.all");
        if(list.isEmpty())
            System.out.println("theater.all is empty");

        ar = new TheaterVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static TheaterVO getById(String tIdx){
        SqlSession ss = FactoryService.getFactory().openSession();
        TheaterVO theater = null;
        theater = ss.selectOne("theater.select", tIdx);
        ss.close();
        return theater;
    }

    public static TheaterVO[] getThscInfo(){
        TheaterVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<TheaterVO> list = ss.selectList("thsc.getThscInfo");
        ar = new TheaterVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static TheaterVO[] getThscSearch(Map<String, String> map){
        TheaterVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<TheaterVO> list = ss.selectList("thsc.getThscSearch", map);
        ar = new TheaterVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }
}
