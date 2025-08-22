package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.LogVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

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

    public static LogVO[] adminLogSearch(int begin, int end, Map<String, String> map){
        LogVO[] ar = null;
        map.put("begin", String.valueOf(begin));
        map.put("end", String.valueOf(end));

        SqlSession ss = FactoryService.getFactory().openSession();
        List<LogVO> list = ss.selectList("log.adminLogSearch", map);
        ar = new LogVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

}
