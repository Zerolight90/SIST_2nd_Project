package mybatis.dao;


import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import mybatis.vo.ReservationVO;
import mybatis.vo.SeatStatusVO;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TimeTableDAO {
    // 영화 목록 반환
    public static TimeTableVO[] getList(){
        List<TimeTableVO> list = null;
        TimeTableVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        // 우선 상영중, 예정인 모든 영화를 보여주는 구간
        list = ss.selectList("timeTable.nowMovie");
        if(list.isEmpty()) {
            System.out.println("현재 상영중인 영화가 없음");
        }else {
            System.out.println(list.size()+"개의 상영중인 영화");
        }
        ar = new TimeTableVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    // 사용자가 선택한 조건을 바탕으로 영화 시간표 반환
    public static TimeTableVO[] getTimeList(String date, String mIdx, String tIdx){
        List<TimeTableVO> list = null;

        Map<String, String> map = new HashMap<String, String>();
        map.put("date", date);
        map.put("mIdx", mIdx);
        map.put("tIdx", tIdx);
        System.out.println(date + " " + mIdx + " " + tIdx);
        SqlSession ss = FactoryService.getFactory().openSession();

        // 요소 3개를 담은 map을 인자로 전달하여
        list = ss.selectList("timeTable.time", map);
//        System.out.println(list.size());
//        System.out.println(map);

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

    public static TimeTableVO[] getRemainSeat(){
        TimeTableVO[] ar2 = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<TimeTableVO> list = ss.selectList("timeTable.getRemainSeat");
        ar2 = new TimeTableVO[list.size()];
        list.toArray(ar2);

        ss.close();
        return ar2;
    }

    public static TimeTableVO[] getTimetableSearch(Map<String, String> params){
        TimeTableVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<TimeTableVO> list = ss.selectList("timeTable.getTimetableSearch", params);
        ar = new TimeTableVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static void createTimeTable(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int insert = ss.insert("timeTable.createTimeTable", map);

        ss.close();
    }

    // 사용자가 선택한 TimeTableVO를 얻어오는 함수
    public static TimeTableVO getSelect(String tvoIdx){
        SqlSession ss = FactoryService.getFactory().openSession();
        TimeTableVO tvo = ss.selectOne("timeTable.select", tvoIdx);
        ss.close();
        return tvo;
    }

    public static TimeTableVO[] getTimeTableSearch(String tIdx){
        TimeTableVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<TimeTableVO> list = ss.selectList("timeTable.theaterTab", tIdx);
        ar = new TimeTableVO[list.size()];
        list.toArray(ar);
        ss.close();
        return ar;
    }
}