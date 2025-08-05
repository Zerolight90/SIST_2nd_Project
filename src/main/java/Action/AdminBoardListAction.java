package Action;

import mybatis.dao.AdminBoardDAO;
import mybatis.dao.BbsDAO;
import mybatis.vo.AdminBoardVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBoardListAction implements Action{

    //재정의-메소드구현
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //jsp경로로 포워드 된다.

        String boardType = request.getParameter("boardType");

        //boardType이 없다면, 직접 넣어줘라(가장 먼저 보여줘야 할 게시판)
        if(boardType == null){
            boardType = "공지사항";
        }

        //총 게시물 수 구하기
        int totalCount = AdminBoardDAO.getTotalCount(boardType);
        System.out.println(" 총 게시물 수:::::::::"+totalCount);

        //페이징 처리를 위한 객체 생성
        Paging page = new Paging(10, 3); //3페이지., 1페이지당 10개씩

        page.setTotalCount(totalCount);

        String cPage = request.getParameter("cPage");

        if(cPage == null){ //현재 페이지 값이 null값이면
            page.setNowPage(1); //1페이지로 지정한다.
        }else{
            //null값이 아니라면,
            int nowPage = Integer.parseInt(cPage); //문자열 "2"를 숫자 2로 바꾼다.
            page.setNowPage(nowPage);
        }
        
        //배열 준비하여 AdminBoardDAO에 getList호출
        AdminBoardVO[] ar = AdminBoardDAO.getList(boardType, page.getBegin(), page.getEnd());

        //JSP에서 표현하기 위해 request에 저장
        request.setAttribute("ar", ar); //ar의 값이 ar이라는 이름으로 list.jsp로 넘어가게 된다.
        request.setAttribute("page", page); //page값이 page라는 이름으로 list.jsp로 넘어가게 된다.
        request.setAttribute("nowPage", page.getNowPage()); //의 값이 list.jsp로 넘어가게 된다.

        return "admin/adminBoardList.jsp";
    }
}
