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

    // 극장별 총 매출을 조회하는 메소드
    public static List<RevenueVO> getSalesByTheater() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> list = ss.selectList("admin.salesByTheater");
        ss.close();
        return list;
    }

    // 검색 조건에 맞는 극장별 매출 데이터를 조회하는 메서드
    public static List<RevenueVO> getSalesBySearch(Map<String, Object> searchParams) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> revenueList = ss.selectList("admin.getSalesBySearch", searchParams);
        ss.close();
        return revenueList;
    }

    // 모든 극장명을 조회하는 메소드
    public static List<String> getAllTheaters(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> theaterList = ss.selectList("admin.getAllTheaters");
        ss.close();
        return theaterList;
    }
}
