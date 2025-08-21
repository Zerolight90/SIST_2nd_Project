package Action;

import mybatis.dao.TheatherDAO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class All_theaterAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 메뉴바에서 [극장]을 선택하면 수행하는 Action
        TheaterVO[] tvo = null;

        // theater 테이블의 중복되지 않는 tRegion을 갖는 TheaterVO[]를 보내 jsp에서 연산을 덜 하게 해줌
        tvo = TheatherDAO.getRegion();
        request.setAttribute("regionArr", tvo); // 중복없는 지역탭만 갖는 TheaterVO[]

        // 이 Action 에서는 극장 테이블의 정보를 가져와 모든 극장들을 보여줘야한다.
        tvo = TheatherDAO.getList();
        request.setAttribute("tvo", tvo); // 모든 정보를 갖고있는 TheaterVO[]

        return "all_theater.jsp";
    }
}
