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

    private static final int NUM_PER_PAGE = 6;
    private static final int PAGE_PER_BLOCK = 5;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "Controller?type=login";
        }

        String userIdxString = mvo.getUserIdx();
        Long userIdx = Long.parseLong(userIdxString);

        // 페이지네이션 클릭 시 어떤 탭을 활성화할지 파라미터로 받음
        String currentTab = request.getParameter("currentTab");
        if (currentTab == null || currentTab.isEmpty()) {
            currentTab = "review"; // 기본값은 '관람평' 탭
        }
        request.setAttribute("currentTab", currentTab);

        // 현재 페이지 번호 가져오기
        String cPageStr = request.getParameter("cPage");
        int cPage = (cPageStr == null || cPageStr.isEmpty()) ? 1 : Integer.parseInt(cPageStr);

        // 1. 관람평 리스트 가져오기
        List<MovieStoryVO> reviewList = MovieStoryDAO.getReviewList(userIdx);
        request.setAttribute("reviewList", reviewList);

        // 2. 본 영화 리스트와 페이징
        Paging watchedPaging = new Paging(NUM_PER_PAGE, PAGE_PER_BLOCK);
        watchedPaging.setTotalCount(MovieStoryDAO.getWatchedCount(userIdx));
        watchedPaging.setNowPage("watched".equals(currentTab) ? cPage : 1);

        Map<String, Object> watchedParams = new HashMap<>();
        watchedParams.put("userIdx", userIdx);
        watchedParams.put("offset", watchedPaging.getBegin() - 1);
        watchedParams.put("numPerPage", watchedPaging.getNumPerPage());
        List<MovieStoryVO> watchedList = MovieStoryDAO.getWatchedList(watchedParams);
        request.setAttribute("watchedList", watchedList);
        request.setAttribute("watchedPaging", watchedPaging);

        // 3. 위시리스트와 페이징
        Paging wishPaging = new Paging(NUM_PER_PAGE, PAGE_PER_BLOCK);
        wishPaging.setTotalCount(MovieStoryDAO.getWishCount(userIdx));
        wishPaging.setNowPage("wished".equals(currentTab) ? cPage : 1);

        Map<String, Object> wishParams = new HashMap<>();
        wishParams.put("userIdx", userIdx);
        wishParams.put("offset", wishPaging.getBegin() - 1);
        wishParams.put("numPerPage", wishPaging.getNumPerPage());
        List<MovieStoryVO> wishList = MovieStoryDAO.getWishList(wishParams);
        request.setAttribute("wishList", wishList);
        request.setAttribute("wishPaging", wishPaging);

        // 최종적으로 myPage_movieStory.jsp로 이동
        return "/mypage/myPage_movieStory.jsp";
    }
}