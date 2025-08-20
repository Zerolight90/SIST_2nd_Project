package Action;

import mybatis.dao.TheatherDAO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class All_theaterAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 메뉴바에서 [극장]을 선택하면 수행하는 Action
        // 이 Action에서는 극장 테이블의 정보를 가져와 모든 극장들을 보여줘야한다.
        TheaterVO[] tvo = null;

        tvo = TheatherDAO.getList();
        request.setAttribute("tvo", tvo);

        return "all_theater.jsp";
    }
}
