package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.KakaoVO;
import mybatis.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    //회원가입
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

    //카카오 회원가입
    public static int kakaoregistry(KakaoVO kvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("member.addKakaoUser", kvo);
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

    // Kakao ID 중복 확인 메서드 추가
    public static boolean checkKakaoId(String k_id) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<KakaoVO> kvo = ss.selectList("member.checkKakaoId", k_id);
        ss.close();

        return !kvo.isEmpty();
    }

    public static MemberVO[] getMemInfo(){
        MemberVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MemberVO> list = ss.selectList("member.getMemInfo");
        ar = new MemberVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static MemberVO[] getMemSearch(Map<String, String> params){
        MemberVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MemberVO> list = ss.selectList("member.getMemSearch", params);
        ar = new MemberVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    // userIdx로 특정 회원 정보 조회하는 메소드
    public static MemberVO getMemberByIdx(long userIdx) { // [수정]
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO vo = ss.selectOne("member.findByIdx", userIdx); // [수정]
        ss.close();
        return vo;
    }

    public static void editUsers(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int update = ss.update("member.editUsers", map);

        if (update >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }

}
