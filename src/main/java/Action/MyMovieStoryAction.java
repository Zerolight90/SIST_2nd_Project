package Action;

import mybatis.dao.MovieStoryDAO;
import mybatis.vo.MemVO; // MemVO 임포트
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트

public class MyMovieStoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemVO mvo = (MemVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_movieStory.jsp";
        }
        long userIdx = mvo.getUserIdx();

        request.setAttribute("reviewList", MovieStoryDAO.getReviewList(userIdx));
        request.setAttribute("watchedList", MovieStoryDAO.getWatchedList(userIdx));
        request.setAttribute("wishList", MovieStoryDAO.getWishList(userIdx));
        return "/mypage/myPage_movieStory.jsp";
    }
}