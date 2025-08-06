package mybatis.dao;


import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import mybatis.vo.SeatStatusVO;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
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
    public static TimeTableVO[] getTimeList(String date, String tIdx, String mIdx){
        List<TimeTableVO> list = null;

        Map<String, String> map = new HashMap<String, String>();
        map.put("date", date);
        map.put("mIdx", mIdx);
        map.put("tIdx", tIdx);

        SqlSession ss = FactoryService.getFactory().openSession();

        // 요소 3개를 담은 map을 인자로 전달하여
        list = ss.selectList("timeTable.time", map);

        TimeTableVO[] ar = new TimeTableVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static TimeTableVO[] getTimetableList(){
        TimeTableVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<TimeTableVO> list = ss.selectList("timeTable.getTimetableList");
        ar = new TimeTableVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static SeatStatusVO[] getRemainSeat(){
        SeatStatusVO[] ar2 = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<SeatStatusVO> list = ss.selectList("timeTable.getRemainSeat");
        ar2 = new SeatStatusVO[list.size()];
        list.toArray(ar2);

        ss.close();
        return ar2;
    }

    // 사용자가 선택한 TimeTableVO를 얻어오는 함수
    public static TimeTableVO getSelect(String tvoIdx){
        SqlSession ss = FactoryService.getFactory().openSession();
        TimeTableVO tvo = ss.selectOne("timeTable.select", tvoIdx);
        ss.close();
        return tvo;
    }
}