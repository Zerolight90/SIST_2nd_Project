package mybatis.dao;


import mybatis.Service.FactoryService;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TimeTableDAO {
    // 영화 목록 반환
    public static List<TimeTableVO> getList(String now){
        List<TimeTableVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        // 우선 상영중, 예정인 모든 영화를 보여주는 구간
        list = ss.selectList("timeTable.all", now);

        ss.close();
        return list;
    }

    // 영화 시간표 반환
    public static TimeTableVO[] getList(String tIdx, String mIdx){
        List<TimeTableVO> list = null;

        Map<String, String> map = new HashMap<String, String>();
        map.put("tIdx", tIdx);
        map.put("mIdx", mIdx);

        SqlSession ss = FactoryService.getFactory().openSession();

        // 우선 상영중, 예정인 모든 영화를 보여주는 구간
        list = ss.selectList("timeTable.all", map);

        TimeTableVO[] ar = new TimeTableVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }
}
