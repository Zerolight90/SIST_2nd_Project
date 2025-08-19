package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminBoardVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserBoardDAO {

    //총 게시물 수 반환
    public static int getTotalCount(String boardType){

        String bt = bungiCata(boardType);

        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.selectOne("userBoard.totalCount", bt);
        ss.close();

        return cnt;
    }

    //게시물 목록 반환
    public static AdminBoardVO[] getList(String boardType, int begin, int end, String searchKeyword){

        System.out.println("들어왔어?");
        String bt = bungiCata(boardType);

        AdminBoardVO[] ar = null;

        //key값 String, value는 Object(int 두개를 모두 포함시켜야 하기 때문)
        HashMap<String, Object> map = new HashMap<>();
        map.put("boardType", bt); //xml에 지정한 이름대로
        map.put("begin", begin);
        map.put("end", end);
        map.put("searchKeyword", searchKeyword);

        System.out.println("map:::::::" + map);

        SqlSession ss = FactoryService.getFactory().openSession();
        //AdminBoardVO가 여러개 넘어오도록 한다.
        List<AdminBoardVO> list = ss.selectList("userBoard.userBoardList", map);
        System.out.println("list.toString():::::::" + list.toString());
        System.out.println("list:::::::" + list);

        //결과가 넘어오면 배열로 넘겨야 하기 때문에
        if(list != null && !list.isEmpty()){ //비어있는 상태가 아니면,
            ar = new AdminBoardVO[list.size()]; //ar을 만든다.
            list.toArray(ar); //list에 있는 모든 항목들을 배열 ar에 복사
        }
        ss.close();

        return ar;
    }

    //1:1문의 작성
    public static int add(String boardType, String boardTitle, String boardContent, String fname, String oname, String boardStartRegDate, String is_answered){

        if(boardType.equals("userInquiryWrite")){
            boardType="QnA";
        }

        System.out.println("UserBoardDAO에서의 boardType::::::::::" + boardType);
        //bungiCata함수 호출하여 boardType을 bt변수명에 저장
        int cnt = 0;

        Map<String, String> map = new HashMap<>();

        map.put("boardType", boardType);
        map.put("boardTitle", boardTitle);
        map.put("boardContent", boardContent);
        map.put("fname", fname);
        map.put("oname", oname);
        map.put("boardStartRegDate", boardStartRegDate);
        map.put("is_answered", is_answered);

        SqlSession ss= FactoryService.getFactory().openSession();
        cnt = ss.insert("userBoard.add", map);

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
        AdminBoardVO vo = ss.selectOne("userBoard.getBoard", boardIdx);

        ss.close();

        return vo;
    }


    private static String bungiCata(String boardType){
        //게시판 카테고리 분기처리
        if(boardType.equals("adminBoardList")){
            boardType="공지사항";
        }else if(boardType.equals("myPrivateinquiry")){
            boardType="QnA";
        }else if((boardType.equals("userEventBoardList"))){
            boardType="이벤트";
        }else{
            boardType="공지사항";
        }

        System.out.println(boardType+ ":::boardType이다");
        return boardType;
    }

    public static AdminBoardVO getPrevPost(String boardIdx, String boardType) {
        // MyBatis Mapper를 호출하여 이전 글 정보를 가져오는 로직

        Map<String, String> map = new HashMap<>();
        map.put("boardIdx", boardIdx);
        map.put("boardType", boardType);

        SqlSession ss = FactoryService.getFactory().openSession();
        AdminBoardVO prevVO = ss.selectOne("userBoard.getPrevPost", map);

        //System.out.println("preVO.toString():::::::" + prevVO.toString());
        ss.close();
        return prevVO;
    }

    public static AdminBoardVO getNextPost(String boardIdx, String boardType) {

        Map<String, String> map = new HashMap<>();
        map.put("boardIdx", boardIdx);
        map.put("boardType", boardType);

        // MyBatis Mapper를 호출하여 다음 글 정보를 가져오는 로직
        SqlSession ss = FactoryService.getFactory().openSession();
        AdminBoardVO nextVO = ss.selectOne("userBoard.getNextPost", map);

        //System.out.println("nextVO.toString():::::::" + nextVO.toString());
        ss.close();

        return nextVO;
    }
}
