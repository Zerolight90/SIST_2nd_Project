package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
    public static List<MovieVO> getList(String now) {
        List<MovieVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        list = ss.selectList("timeTable.all", now);

        ss.close();
        return list;
    }
}
