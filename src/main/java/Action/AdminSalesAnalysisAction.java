package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.RevenueVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminSalesAnalysisAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // 1. 요청 파라미터에서 모든 검색 조건 추출
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        // 수정: 여러 개의 극장명 파라미터를 배열로 받는다.
        String[] theaterNamesArray = request.getParameterValues("theaterNames");
        String movieGenre = request.getParameter("movieGenre");
        String paymentType = request.getParameter("paymentType");
        String timeOfDay = request.getParameter("timeOfDay");
        String memberType = request.getParameter("memberType");

        // 수정: Map의 Value 타입을 Object로 변경
        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("startDate", startDate);
        searchParams.put("endDate", endDate);
        // theaterNamesArray가 null이 아닐 경우 리스트로 변환하여 Map에 추가
        if (theaterNamesArray != null) {
            searchParams.put("theaterNames", Arrays.asList(theaterNamesArray));
        }
        searchParams.put("movieGenre", movieGenre);
        searchParams.put("paymentType", paymentType);
        searchParams.put("timeOfDay", timeOfDay);
        searchParams.put("memberType", memberType);

        // 추가: 모든 극장명 목록을 조회하여 request에 저장 (JSP의 드롭다운용)
        List<String> allTheaters = AdminDAO.getAllTheaters();
        request.setAttribute("allTheaters", allTheaters);

        // 2. 검색 조건에 맞는 극장별 매출 데이터 조회
        List<RevenueVO> revenueList = AdminDAO.getSalesBySearch(searchParams);

        // 3. 조회된 데이터를 "revenueList"라는 이름으로 request 객체에 저장
        request.setAttribute("revenueList", revenueList);

        // 4. 데이터를 표시할 JSP 경로 반환
        return "admin/adminSalesAnalysis.jsp";
    }
}