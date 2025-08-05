package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.LogVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class LogDAO {

    public static LogVO[] getAllLog(){
        LogVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<LogVO> list = ss.selectList("log.getAllLog");
        ar = new LogVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

}
