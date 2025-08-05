package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.NmemVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NmemDAO {

    public static NmemVO[] getAllNmem() {
        NmemVO[] ar = null;

        try {
            SqlSession ss = FactoryService.getFactory().openSession();
            List<NmemVO> list = ss.selectList("nmem.getNmem");
            ar = new NmemVO[list.size()];
            list.toArray(ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ar;
    }

}
