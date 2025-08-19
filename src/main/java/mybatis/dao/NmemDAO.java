package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.NmemVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class NmemDAO {

    public static NmemVO[] getAllNmem() {
        NmemVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<NmemVO> list = ss.selectList("nmem.getNmem");
        ar = new NmemVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static NmemVO[] getNmemSearch(Map<String, String> params){
        NmemVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<NmemVO> list = ss.selectList("nmem.getNmemSearch", params);
        ar = new NmemVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    // 비회원 추가를 위한 로직
    public static int registry(NmemVO nmemvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("nmem.add", nmemvo);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    // 비회원 로그인을 위한 로직
    public static NmemVO getByEmail(String email){

        SqlSession ss = FactoryService.getFactory().openSession();
        NmemVO vo = ss.selectOne("nmem.getByEmail", email);
        ss.close();

        return vo;
    }

}
