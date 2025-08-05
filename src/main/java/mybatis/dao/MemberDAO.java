package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;

public class MemberDAO {

    //login.jsp에서 호출하는 로그인 함수
    public static MemberVO login(String id, String pw){
        HashMap<String, String> map = new HashMap<>();
        map.put("m_id",id);
        map.put("m_pw",pw);

        //sql문을 호출하기 위해 필요한 객체 SqlSession얻기
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("member.login", map);
        ss.close();

        return mvo;
    }

    public static int registry(MemberVO mvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("member.add", mvo);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    //아이디를 인자로 받아서 아이디 사용여부를 확인하는 기능
    public static boolean idCheck(String m_id) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO vo = ss.selectOne("member.id_check", m_id);
        ss.close();
        // 수정된 부분: vo가 null이면 (아이디가 DB에 없으면) false (사용 가능),
        //             vo가 null이 아니면 (아이디가 DB에 있으면) true (중복)
        return (vo != null); // 간결하게 표현 가능
    }
}
