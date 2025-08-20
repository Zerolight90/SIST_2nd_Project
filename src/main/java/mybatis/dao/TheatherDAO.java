package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminBoardVO;
import mybatis.vo.TheaterVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
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


    /*선영추가*/
    // 영화관 목록 반환
    public static TheaterVO[] getTheaterList(int begin, int end){

        TheaterVO[] ar = null;

        HashMap<String, Object> map = new HashMap<>();
        map.put("begin", begin);
        map.put("end", end);

        System.out.println("map::::::::::"+map);

        SqlSession ss = FactoryService.getFactory().openSession();

        // 목록 쿼리
        List<TheaterVO> list = ss.selectList("theater.adminTheaterList", map);

        System.out.println("list::::::::" + list);

        //결과가 넘어오면 배열로 넘겨야 하기 때문에
        if(list != null && !list.isEmpty()){ //비어있는 상태가 아니면,
            ar = new TheaterVO[list.size()]; //ar을 만든다.
            list.toArray(ar); //list에 있는 모든 항목들을 배열 ar에 복사
        }

        ss.close();
        return ar;
    }
    
    //총 게시물 수 구하는 함수
    //총 게시물 수 반환
    public static int getTotalCount(String tName){

        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.selectOne("theater.totalCount", tName);
        ss.close();

        return cnt;
    }
}
