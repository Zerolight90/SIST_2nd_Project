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

        String bt = bungiCata(boardType);
        
        SqlSession ss = FactoryService.getFactory().openSession();
        
        int cnt = ss.selectOne("adminBoard.totalCount", bt);
        ss.close();

        return cnt;
    }

    //AdminBoardListAction에서 getList를 호출한다.
    //게시물 목록 반환
    public static AdminBoardVO[] getList(String boardType, int begin, int end, String searchKeyword){

        String bt = bungiCata(boardType);

        AdminBoardVO[] ar = null;

        //key값 String, value는 Object(int 두개를 모두 포함시켜야 하기 때문)
        HashMap<String, Object> map = new HashMap<>();
        map.put("boardType", bt); //xml에 지정한 이름대로
        map.put("begin", begin);
        map.put("end", end);
        map.put("searchKeyword", searchKeyword);


        SqlSession ss = FactoryService.getFactory().openSession();
        //AdminBoardVO가 여러개 넘어오도록 한다.
        List<AdminBoardVO> list = ss.selectList("adminBoard.adminBoardList", map);


        //결과가 넘어오면 배열로 넘겨야 하기 때문에
        if(list != null && !list.isEmpty()){ //비어있는 상태가 아니면,
            ar = new AdminBoardVO[list.size()]; //ar을 만든다.
            list.toArray(ar); //list에 있는 모든 항목들을 배열 ar에 복사
        }
        ss.close();

        return ar;
    }
    
    
    //게시물 작성
    public static int add(String boardType, String parent_boardIdx, String sub_boardType, String boardTitle, String writer, String boardContent, String fname, String oname, String thumbfilename, String boardStartRegDate, String boardEndRegDate, String boardStatus){

        //bungiCata함수 호출하여 boardType을 bt변수명에 저장
        int cnt = 0;

        Map<String, String> map = new HashMap<>();

        map.put("boardType", boardType);
        map.put("parent_boardIdx", parent_boardIdx);
        map.put("subBoardType", sub_boardType);
        map.put("title", boardTitle);
        map.put("writer", writer);
        map.put("content", boardContent);
        map.put("fname", fname);
        map.put("oname", oname);
        map.put("thumbfilename", thumbfilename);
        map.put("boardStartRegDate", boardStartRegDate);
        map.put("boardEndRegDate", boardEndRegDate);
        map.put("boardStatus", boardStatus);

        
        SqlSession ss= FactoryService.getFactory().openSession();
        cnt = ss.insert("adminBoard.add", map);

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
        AdminBoardVO vo = ss.selectOne("adminBoard.getBoard", boardIdx);

        ss.close();

        return vo;
    }

    //게시글 삭제
    public static int delBbs(String boardIdx){

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminBoard.del", boardIdx);

        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();

        return cnt;
    }

    //게시글 수정
    public static int edit(String boardIdx, String boardTitle, String subBoardType, String boardStartRegDate, String boardEndRegDate, String boardContent, String fname, String oname, String thumbfilename){

        Map<String, String> map = new HashMap<>();
        map.put("boardIdx", boardIdx);
        map.put("boardTitle", boardTitle);
        map.put("subBoardType", subBoardType);
        map.put("boardStartRegDate", boardStartRegDate);
        map.put("boardEndRegDate", boardEndRegDate);
        map.put("boardContent", boardContent);

        //파일 첨부가 되어있다면,
        if(fname!=null){
            map.put("fname", fname);
            map.put("oname", oname);
        }

        //썸네일 첨부가 되어있다면,
        if(thumbfilename!=null){
            map.put("thumbfilename", thumbfilename);
        }

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminBoard.edit", map);

        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();

        return cnt;
    }


    //답변상태값 업데이트
    public static int update(String boardIdx, String is_answered){

        Map<String, String> map = new HashMap<>();
        map.put("boardIdx", boardIdx);
        map.put("is_answered", is_answered);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminBoard.update", map);

        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();

        return cnt;
    }

    private static String bungiCata(String boardType){

        //System.out.println("bungiCata..boardType:::::::::::::::"+boardType);
        //게시판 카테고리 분기처리
        if(boardType.equals("adminBoardList")){
            boardType="공지사항";
            //System.out.println("boardType은 공지사항입니까?" + boardType);
        }else if(boardType.equals("adminInquiryList")){
            boardType="QnA";
            //System.out.println("boardType은 고객문의입니까?" + boardType);
        }else if((boardType.equals("adminEventList"))){
            boardType="이벤트";
            //System.out.println("boardType은 이벤트입니까?" + boardType);
        }else{
            boardType="공지사항";
        }

        return boardType;
    }

    //검색 기능
    public String search(String boardTitle){

        SqlSession ss = FactoryService.getFactory().openSession();
        ss.selectList("adminBoard.search", boardTitle);


        return boardTitle;
    }

}
