package Action.adminAction.chart;

import Action.Action;
import mybatis.dao.AdminDAO;
import mybatis.vo.RevenueVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class StatisticalChartAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // 1. DB에서 극장별 매출 데이터 조회
        List<RevenueVO> revenueList = AdminDAO.getSalesByTheater();

        // 2. 조회된 데이터를 "revenueList"라는 이름으로 request 객체에 저장
        request.setAttribute("revenueList", revenueList);

        // 3. 데이터를 표시할 JSP 경로 반환
        return "admin/adminDashboard.jsp";
    }
}