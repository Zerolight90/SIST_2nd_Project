package Action;

import util.Paging;
import mybatis.dao.UsersDAO;
import mybatis.vo.UsersVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UsetlistAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //파라미터 받기
        String bname = request.getParameter("bname");
        if(bname == null)
            bname = "BBS";

        // 총 게시물의 수를 얻어낸다.
//        int totalCount = UsersDAO.getTotalCount(bname);
//
//        // 페이징 처리를 위한 객체 생성
//        Paging page = new Paging(5, 3);
//
//        page.setTotalCount(totalCount);//총 페이지 수까지 구했다.
//
//        // 현재페이지 값을 파라미터로 받는다.
//        String cPage = request.getParameter("cPage");
//
//        if(cPage == null)
//            page.setNowPage(1);
//        else{
//            int nowPage = Integer.parseInt(cPage);//"2" --> 2
//            page.setNowPage(nowPage);// 이때!!!
//            // 게시물을 추출할 때 사용되는 begin과 end가 구해지고,
//            // 더불어 startPage와 endPage도 구해졌다
//        }
//
//        //DAO를 호출하여 원하는 게시물들 목록을 받아야 한다.
//        BbsVO[] ar = BbsDAO.getList(bname, page.getBegin(), page.getEnd());
//
//        // JSP에서 표현하기 위해 request에 저장!
//        request.setAttribute("ar", ar);
//        request.setAttribute("page", page);
//        request.setAttribute("nowPage", page.getNowPage());

        return "list.jsp";
    }
}
