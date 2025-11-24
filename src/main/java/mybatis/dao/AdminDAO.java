package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminVO;
import mybatis.vo.RevenueVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class AdminDAO {

    public static AdminVO[] getAllAdmin(){
        AdminVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<AdminVO> list = ss.selectList("admin.getAllAdmin");
        ar = new AdminVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static AdminVO adminCheck(Map<String, String> map){
        AdminVO vo = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        vo = ss.selectOne("admin.adminCheck", map);

        ss.close();
        return vo;
    }

    public static AdminVO[] adminListSearch(int begin, int end, Map<String, String> map){
        AdminVO[] ar = null;
        map.put("begin", String.valueOf(begin));
        map.put("end", String.valueOf(end));

        SqlSession ss = FactoryService.getFactory().openSession();
        List<AdminVO> list = ss.selectList("admin.adminListSearch", map);
        ar = new AdminVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static void insertAdmin(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int insert = ss.insert("admin.adminInsert", map);
        if (insert >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }

    public static void updateAdmin(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int update = ss.update("admin.updateAdmin", map);
        if (update >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }

    // 극장별 총 매출을 조회하는 메소드
    public static List<RevenueVO> getSalesByTheater() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> list = ss.selectList("admin.salesByTheater");
        ss.close();
        return list;
    }

    public static List<RevenueVO> getSalesBySearch(Map<String, Object> searchParams) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> revenueList = ss.selectList("admin.getSalesBySearch", searchParams);
        ss.close();
        return revenueList;
    }

    public static List<RevenueVO> getSalesByMovie(Map<String, Object> searchParams) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> revenueList = ss.selectList("admin.getSalesByMovie", searchParams);
        ss.close();
        return revenueList;
    }

    public static List<String> getAllTheaters(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> theaterList = ss.selectList("admin.getAllTheaters");
        ss.close();
        return theaterList;
    }

    // 전체 극장의 매출 순위를 이름순으로 가져오는 메소드
    public static List<String> getTheatersBySalesRank() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> list = ss.selectList("admin.getTheatersBySalesRank");
        ss.close();
        return list;
    }

    // 모든 영화의 장르 문자열을 가져오는 메소드
    public static List<String> getAllGenreStrings() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> list = ss.selectList("admin.getAllGenreStrings");
        ss.close();
        return list;
    }
}
