package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminVO;
import mybatis.vo.RevenueVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

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

    // 극장별 총 매출을 조회하는 메소드
    public static List<RevenueVO> getSalesByTheater() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<RevenueVO> list = ss.selectList("admin.salesByTheater");
        ss.close();
        return list;
    }

}
