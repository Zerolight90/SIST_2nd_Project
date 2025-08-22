package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MemberVO;
import mybatis.vo.NmemVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
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

    public static NmemVO[] getNmemSearch(int begin, int end, Map<String, String> params){
        NmemVO[] ar = null;
        params.put("begin", String.valueOf(begin));
        params.put("end", String.valueOf(end));

        SqlSession ss = FactoryService.getFactory().openSession();
        List<NmemVO> list = ss.selectList("nmem.getNmemSearch", params);
        ar = new NmemVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static void insertNmember(NmemVO vo, SqlSession ss) {
        // insert를 수행하고, 생성된 PK(nIdx)를 파라미터로 받은 vo객체에 다시 설정해준다.
        ss.insert("nmem.insertNmember", vo);
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


    public static NmemVO getByEmail(String email){

        SqlSession ss = FactoryService.getFactory().openSession();
        NmemVO result = ss.selectOne("nmem.getByEmail", email);
        ss.close();
        return result;

    }

    public static NmemVO chk(String u_name, String u_pw, String u_birth){
        HashMap<String, String> map = new HashMap<>();
        map.put("u_name",u_name);
        map.put("u_birth",u_birth);
        map.put("u_pw",u_pw);


        //sql문을 호출하기 위해 필요한 객체 SqlSession얻기
        SqlSession ss = FactoryService.getFactory().openSession();
        NmemVO nmenvo = ss.selectOne("nmem.bookchk", map);
        ss.close();

        return nmenvo;
    }


}
