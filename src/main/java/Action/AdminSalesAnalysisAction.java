package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.RevenueVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class AdminSalesAnalysisAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String theaterGroup = request.getParameter("theaterGroup");
        String movieGenre = request.getParameter("movieGenre");
        String paymentType = request.getParameter("paymentType");
        String timeOfDay = request.getParameter("timeOfDay");
        String memberType = request.getParameter("memberType");

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("startDate", startDate);
        searchParams.put("endDate", endDate);
        searchParams.put("movieGenre", movieGenre);
        searchParams.put("paymentType", paymentType);
        searchParams.put("timeOfDay", timeOfDay);
        searchParams.put("memberType", memberType);

        if (theaterGroup != null && !theaterGroup.isEmpty()) {
            List<String> rankedTheaters = AdminDAO.getTheatersBySalesRank();
            List<String> theaterNamesForGroup = new ArrayList<>();
            if ("1".equals(theaterGroup)) {
                theaterNamesForGroup.addAll(rankedTheaters.subList(0, Math.min(5, rankedTheaters.size())));
            } else if ("2".equals(theaterGroup)) {
                if (rankedTheaters.size() > 5) {
                    theaterNamesForGroup.addAll(rankedTheaters.subList(5, rankedTheaters.size()));
                }
            }
            searchParams.put("theaterNames", theaterNamesForGroup);
        }

        // 모든 영화 장르를 동적으로 가져와서 처리
        List<String> genreStrings = AdminDAO.getAllGenreStrings();
        Set<String> uniqueGenres = new TreeSet<>(); // TreeSet으로 자동 정렬 및 중복 제거
        for (String genreStr : genreStrings) {
            // "드라마, 액션" 같은 문자열을 쉼표 기준으로 분리
            String[] genres = genreStr.split("\\s*,\\s*"); // 쉼표 양옆 공백도 제거
            for (String g : genres) {
                if(g != null && !g.trim().isEmpty()){
                    uniqueGenres.add(g.trim());
                }
            }
        }
        request.setAttribute("allGenres", uniqueGenres);

        List<RevenueVO> theaterRevenueList = AdminDAO.getSalesBySearch(searchParams);
        List<RevenueVO> movieRevenueList = AdminDAO.getSalesByMovie(searchParams);

        request.setAttribute("theaterRevenueList", theaterRevenueList);
        request.setAttribute("movieRevenueList", movieRevenueList);

        return "admin/adminSalesAnalysis.jsp";
    }
}