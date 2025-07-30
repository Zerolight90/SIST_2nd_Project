package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.BbsVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BbsDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String bname){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("bbs.totalCount", bname);
        ss.close();
        return cnt;
    }

    // 목록 반환
    public static BbsVO[] getList(String bname, int begin, int end){
        BbsVO[] ar = null;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bname", bname);
        map.put("begin", begin);
        map.put("end", end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<BbsVO> list = ss.selectList("bbs.list", map);
        if(list != null && list.size() > 0){
            ar = new BbsVO[list.size()];
            list.toArray(ar);// list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();

        return ar;
    }

    // 저장
    public static int add(String subject, String writer, String content,
              String fname, String oname, String ip, String bname){
        int cnt = 0;

        Map<String, String> map = new HashMap<>();
        map.put("subject",subject);
        map.put("writer",writer);
        map.put("content",content);
        map.put("fname",fname);
        map.put("oname",oname);
        map.put("ip",ip);
        map.put("bname",bname);

        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("bbs.add", map);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    // 기본키를 인자로 하여 게시물 가져오기
    public static BbsVO getBbs(String b_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        BbsVO vo = ss.selectOne("bbs.getBbs", b_idx);
        //List<BbsVO> list = ss.selectList("bbs.getBbs", b_idx);
        ss.close();
        return vo;
    }



    // 수정
    public static int edit(String b_idx, String title, String content,
                   String fname, String oname, String ip){
        Map<String, String> map = new HashMap<>();
        map.put("b_idx", b_idx);
        map.put("title", title);
        map.put("content", content);
        if(fname != null){
            map.put("fname",fname);
            map.put("oname",oname);
        }
        map.put("ip",ip);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("bbs.edit", map);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }


    // 삭제
    public static int delBbs(String b_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("bbs.del", b_idx);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
        return cnt;
    }

    // 조회수 증가
    public static int hit(String b_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("bbs.hit", b_idx);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
        return cnt;
    }


}
