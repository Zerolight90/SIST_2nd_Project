package data.dao;

import mybatis.service.FactoryService;
import mybatis.vo.DataVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class DataDAO {

    public static DataVO[] getMovie(){
        DataVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<DataVO> list = ss.selectList("movie.get");

        ar = new DataVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

}
