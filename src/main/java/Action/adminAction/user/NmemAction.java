package Action.adminAction.user;

import Action.Action;
import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class NmemAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> params = new HashMap<>();
        params.put("datepicker", request.getParameter("datepicker"));
        params.put("search_field", request.getParameter("search_field"));
        params.put("search_keyword", request.getParameter("search_keyword"));

        //총 게시물 수 구하기
        //처음부터 끝까지 전체의 데이터 갯수
        int nmemCount = NmemDAO.getAllNmem().length;

        //페이징 처리를 위한 객체 생성
        Paging page = new Paging(10, 5); //1페이지당 10개씩, 3페이지

        //총 페이지수를 저장
        page.setTotalCount(nmemCount);

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

        NmemVO[] ar = NmemDAO.getNmemSearch(page.getBegin(), page.getEnd(), params);

        request.setAttribute("ar", ar);
        request.setAttribute("page", page); //page라는 이름으로 page를 저장해라. list.jsp로 넘어가게 된다.
        request.setAttribute("nowPage", page.getNowPage()); //의 값이 list.jsp로 넘어가게 된다.
        request.setAttribute("nmemCount", nmemCount); //게시물 토탈 갯수

        return "admin/adminNmem.jsp";
    }
}
