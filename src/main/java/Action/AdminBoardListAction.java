package Action;

import mybatis.dao.AdminBoardDAO;
import mybatis.dao.BbsDAO;
import mybatis.vo.AdminBoardVO;
import mybatis.vo.AdminVO;
import mybatis.vo.MemberVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class AdminBoardListAction implements Action{

    //재정의-메소드구현
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //로그인한 관리자 받아오기
        HttpSession session = request.getSession();

        AdminVO vo = (AdminVO) session.getAttribute("vo");
        session.setAttribute("adminInfo", vo);


        String boardType = request.getParameter("type");
        String searchKeyword = request.getParameter("searchKeyword");

        //System.out.println("키워드::::::::::::::::::::" + searchKeyword);
        //System.out.println("boardType:::::::::::::::" + boardType);

        if(boardType == null) {
            boardType = "adminBoardList";
        }

        //총 게시물 수 구하기
        //처음부터 끝까지 전체의 데이터 갯수
        int totalCount = AdminBoardDAO.getTotalCount(boardType);
        //int totalCount = AdminBoardDAO.getTotalCount(boardType, vo.gettIdx());
        //System.out.println(" 총 게시물 수:::::::::"+totalCount);

        //페이징 처리를 위한 객체 생성
        Paging page = new Paging(10, 5); //1페이지당 10개씩, 3페이지

        //총 페이지수를 저장
        page.setTotalCount(totalCount);

        //현재 페이지 값을 받으면 된다.(어떤 페이지를 보겠다고 하는지)
        String cPage = request.getParameter("cPage");

        if(cPage == null){ //현재 페이지 값이 null값이면(없으면)
            page.setNowPage(1); //1페이지로 지정한다.
        }else{
            //null값이 아니라면,
            int nowPage = Integer.parseInt(cPage); //문자열 "2"를 숫자 2로 바꾼다. //받은 문자열을 숫자로 변환하라.
            page.setNowPage(nowPage); //begin, end, startPage, endPage가 구해지도록 setNowPage 함수 안에 넣어놨다 이게 page 안에 저장됨
            //jsp에서 표현할거라 Paging이라는 객체를 request에 저장해라
            //총 페이지 수도 필요하고, 현재 페이지도 필요하다.
        }
        
        //배열 준비하여 AdminBoardDAO에 getList호출
        //유지보수 생각하면서 코드도 진행이 됨
        AdminBoardVO[] ar = AdminBoardDAO.getList(boardType, page.getBegin(), page.getEnd(), searchKeyword);

//      session.setAttribute("ar", ar); //ar의 값이 ar이라는 이름으로 list.jsp로 넘어가게 된다.

        //JSP에서 표현하기 위해 request에 저장
        request.setAttribute("ar", ar); //ar의 값이 ar이라는 이름으로 list.jsp로 넘어가게 된다.
        request.setAttribute("page", page); //page라는 이름으로 page를 저장해라. list.jsp로 넘어가게 된다.
        request.setAttribute("nowPage", page.getNowPage()); //의 값이 list.jsp로 넘어가게 된다.
        request.setAttribute("totalCount", totalCount); //게시물 토탈 갯수

        //게시판 타입에 따른 화면단 분기처리
        if(boardType.equals("adminBoardList")){

            return "admin/adminBoardList.jsp";
        } else if(boardType.equals("adminInquiryList")){

            return "admin/adminInquiryList.jsp";
        } else if(boardType.equals("adminEventList")){

            return "admin/adminEventList.jsp";
        }else{

            return "admin/adminBoardList.jsp";
        }
    }
}
