package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminBoardVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBoardDAO {

    //총 게시물 수 반환
    public static int getTotalCount(String boardType){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("board.totalCount", boardType);
        ss.close();

        return cnt;
    }

    //AdminBoardListAction에서 getList를 호출한다.
    //목록 반환
    public static AdminBoardVO[] getList(String boardType, int begin, int end){
        AdminBoardVO[] ar = null;

        //key값 String, value는 Object(int 두개를 모두 포함시켜야 하기 때문)
        HashMap<String, Object> map = new HashMap<>();
        map.put("boardType", boardType); //xml에 지정한 이름대로
        map.put("begin", begin);
        map.put("end", end);

        System.out.println("map:::::::" + map);

        SqlSession ss = FactoryService.getFactory().openSession();
        //AdminBoardVO가 여러개 넘어오도록 한다.
        List<AdminBoardVO> list = ss.selectList("board.adminBoardList", map);

        //결과가 넘어오면 배열로 넘겨야 하기 때문에
        if(list != null && !list.isEmpty()){ //비어있는 상태가 아니면,
            ar = new AdminBoardVO[list.size()]; //ar을 만든다.
            list.toArray(ar); //list에 있는 모든 항목들을 배열 ar에 복사
        }
        ss.close();

        return ar;
    }
    
    
    //공지사항 작성
    public static int add(String boardType, String boardTitle, String writer, String boardContent, String fname, String oname, String boardRegDate, String boardEndRegDate, String boardStatus){
        int cnt = 0;

        Map<String, String> map = new HashMap<>();

        map.put("boardType", boardType);
        map.put("title", boardTitle);
        map.put("writer", writer);
        map.put("content", boardContent);
        map.put("fname", fname);
        map.put("oname", oname);
        map.put("boardRegDate", boardRegDate);
        map.put("boardEndRegDate", boardEndRegDate);


        map.put("boardStatus", boardStatus);


        SqlSession ss= FactoryService.getFactory().openSession();
        cnt = ss.insert("board.add", map);

        if(cnt>0){
            ss.commit();
        }else{
            ss.rollback();
        }
        ss.close();

        return cnt;
    }

    //게시글 보기
    public static AdminBoardVO getBoard(String boardIdx){

        SqlSession ss = FactoryService.getFactory().openSession();
        AdminBoardVO vo = ss.selectOne("board.getBoard", boardIdx);

        ss.close();

        return vo;
    }

    //게시글 삭제
    public static int delBbs(String boardIdx){

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("board.del", boardIdx);

        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();

        return cnt;
    }
    


}
