package Action;

import mybatis.dao.MovieStoryDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MovieStoryVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyMovieStoryAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            // 로그인하지 않았다면 로그인 페이지로 리다이렉트
            return "Controller?type=login";
        }

        // 1. 파라미터 수신
        String tabName = request.getParameter("tabName");
        if (tabName == null || tabName.isEmpty()) {
            tabName = "review"; // 기본 탭은 '관람평'으로 설정
        }

        String cPage = request.getParameter("cPage");
        Long userIdx = Long.parseLong(mvo.getUserIdx());

        // 2. 탭에 따른 데이터 처리
        if ("review".equals(tabName)) {
            // 관람평 탭: 페이징 없이 전체 목록을 가져옴
            List<MovieStoryVO> reviewList = MovieStoryDAO.getReviewList(userIdx);
            request.setAttribute("reviewList", reviewList);

        } else if ("watched".equals(tabName) || "wished".equals(tabName)) {
            // 본 영화 또는 위시리스트 탭: 페이징 처리
            Paging p = new Paging(10, 5); // 한 페이지에 6개, 블록당 5페이지

            // 총 게시물 수 설정
            int totalCount = 0;
            if ("watched".equals(tabName)) {
                totalCount = MovieStoryDAO.getWatchedCount(userIdx);
            } else { // "wished"
                totalCount = MovieStoryDAO.getWishCount(userIdx);
            }
            p.setTotalCount(totalCount);

            // 현재 페이지 설정
            if (cPage != null && !cPage.isEmpty()) {
                p.setNowPage(Integer.parseInt(cPage));
            } else {
                p.setNowPage(1);
            }

            // DB 조회를 위한 파라미터 맵 생성
            Map<String, Object> params = new HashMap<>();
            params.put("userIdx", userIdx);
            params.put("offset", p.getBegin() - 1);
            params.put("numPerPage", p.getNumPerPage());

            // 데이터 목록 조회
            List<MovieStoryVO> movieList;
            if ("watched".equals(tabName)) {
                movieList = MovieStoryDAO.getWatchedList(params);
            } else { // "wished"
                movieList = MovieStoryDAO.getWishList(params);
            }

            // JSP로 데이터 전달
            request.setAttribute("movieList", movieList);
            request.setAttribute("paging", p);
        }

        // 3. 현재 탭과 페이지 정보를 JSP로 전달
        request.setAttribute("currentTab", tabName);

        // 4. 뷰 페이지 반환
        return "/mypage/myPage_movieStory.jsp";
    }
}