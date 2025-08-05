package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminVO;
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

}
