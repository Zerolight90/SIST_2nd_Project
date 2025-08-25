// Action/AdminSalesAnalysisAction.java

package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.RevenueVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class AdminSalesAnalysisAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // 1. JSP로부터 파라미터 받기
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String theaterGroup = request.getParameter("theaterGroup");
        String movieGenre = request.getParameter("movieGenre");
        String paymentType = request.getParameter("paymentType");
        String timeOfDay = request.getParameter("timeOfDay");
        String memberType = request.getParameter("memberType");

        // 2. DAO로 전달할 파라미터 맵 생성
        Map<String, Object> searchParams = new HashMap<>();

        // WHERE절을 담을 StringBuilder 생성
        StringBuilder whereClause = new StringBuilder();

        if (startDate != null && !startDate.isEmpty()) {
            whereClause.append(" AND DATE(P.paymentDate) >= #{startDate}");
            searchParams.put("startDate", startDate);
        }
        if (endDate != null && !endDate.isEmpty()) {
            whereClause.append(" AND DATE(P.paymentDate) <= #{endDate}");
            searchParams.put("endDate", endDate);
        }
        if (movieGenre != null && !movieGenre.isEmpty()) {
            whereClause.append(" AND M.gen LIKE CONCAT('%', #{movieGenre}, '%')");
            searchParams.put("movieGenre", movieGenre);
        }
        if (paymentType != null && !paymentType.isEmpty()) {
            whereClause.append(" AND P.paymentType = #{paymentType}");
            searchParams.put("paymentType", paymentType);
        }
        if (timeOfDay != null && !timeOfDay.isEmpty()) {
            String[] hours = timeOfDay.split("-");
            if (hours.length == 2) {
                whereClause.append(" AND HOUR(TT.startTime) BETWEEN #{startTimeHour} AND #{endTimeHour}");
                searchParams.put("startTimeHour", Integer.parseInt(hours[0]));
                searchParams.put("endTimeHour", Integer.parseInt(hours[1]));
            }
        }
        if (memberType != null && !memberType.isEmpty()) {
            if ("member".equals(memberType)) {
                whereClause.append(" AND R.userIdx IS NOT NULL");
            } else if ("nmember".equals(memberType)) {
                whereClause.append(" AND R.nIdx IS NOT NULL");
            }
        }
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

            // theaterNamesForGroup이 비어있지 않을 때만 조건 추가
            if (!theaterNamesForGroup.isEmpty()) {
                whereClause.append(" AND T.tName IN ");
                // MyBatis <foreach>와 동일한 로직을 위해 theaterNames를 파라미터 맵에 추가
                searchParams.put("theaterNames", theaterNamesForGroup);
            }
        }

        // 완성된 WHERE절과 파라미터들을 맵에 담기
        searchParams.put("whereClause", whereClause.toString());

        // 3. 장르 목록 처리
        List<String> genreStrings = AdminDAO.getAllGenreStrings();
        Set<String> uniqueGenres = new TreeSet<>();
        for (String genreStr : genreStrings) {
            String[] genres = genreStr.split("\\s*,\\s*");
            Collections.addAll(uniqueGenres, genres);
        }
        request.setAttribute("allGenres", uniqueGenres);

        // 4. DAO 호출 및 결과 전달
        List<RevenueVO> theaterRevenueList = AdminDAO.getSalesBySearch(searchParams);
        List<RevenueVO> movieRevenueList = AdminDAO.getSalesByMovie(searchParams);
        request.setAttribute("theaterRevenueList", theaterRevenueList);
        request.setAttribute("movieRevenueList", movieRevenueList);

        return "admin/adminSalesAnalysis.jsp";
    }
}