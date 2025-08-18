package mybatis.dao;

import mybatis.Service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import mybatis.vo.MemberVO;
import java.util.HashMap;
import java.util.Map;

public class searchDAO {
    public MemberVO findByFields(String name, String phone, String birth, String email) {
        SqlSession ss = FactoryService.getFactory().openSession();
        try {
            Map<String,Object> params = new HashMap<>();
            params.put("m_name", name);
            params.put("m_phone", phone);
            params.put("m_birth", birth);
            params.put("m_email", email);
            // mapper namespace가 'member'이고 id가 'serchID'이므로 아래와 같이 호출
            MemberVO member = ss.selectOne("member.serchID", params);
            return member;
        } finally {
            ss.close();
        }
    }
}
