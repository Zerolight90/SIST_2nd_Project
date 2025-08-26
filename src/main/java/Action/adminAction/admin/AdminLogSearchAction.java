package Action.adminAction.admin;

import Action.Action;
import mybatis.dao.LogDAO;
import mybatis.vo.LogVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminLogSearchAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String datepicker = request.getParameter("datepicker");
        String datepicker2 = request.getParameter("datepicker2");
        String search_field = request.getParameter("search_field");
        String search_keyword = request.getParameter("search_keyword");
        Map<String, String> map = new HashMap<>();
        map.put("datepicker", datepicker);
        map.put("datepicker2", datepicker2);
        map.put("search_field", search_field);
        map.put("search_keyword", search_keyword);

        //총 게시물 수 구하기
        //처음부터 끝까지 전체의 데이터 갯수
        int adminLogCount = LogDAO.getAllLog().length;

        //페이징 처리를 위한 객체 생성
        Paging page = new Paging(10, 5); //1페이지당 10개씩, 3페이지

        //총 페이지수를 저장
        page.setTotalCount(adminLogCount);

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

        LogVO[] ar = LogDAO.adminLogSearch(page.getBegin(), page.getEnd(), map);

        request.setAttribute("ar", ar);
        request.setAttribute("page", page); //page라는 이름으로 page를 저장해라. list.jsp로 넘어가게 된다.
        request.setAttribute("nowPage", page.getNowPage()); //의 값이 list.jsp로 넘어가게 된다.
        request.setAttribute("adminLogCount", adminLogCount); //게시물 토탈 갯수

        return "admin/adminLogSearch.jsp";
    }
}
