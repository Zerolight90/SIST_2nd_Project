package Action;

import mybatis.dao.MovieStoryDAO;
import mybatis.vo.MemberVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트

public class MyMovieStoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_movieStory.jsp";
        }
        String userIdx = mvo.getUserIdx();

        request.setAttribute("reviewList", MovieStoryDAO.getReviewList(Long.parseLong(userIdx)));
        request.setAttribute("watchedList", MovieStoryDAO.getWatchedList(Long.parseLong(userIdx)));
        request.setAttribute("wishList", MovieStoryDAO.getWishList(Long.parseLong(userIdx)));
        return "/mypage/myPage_movieStory.jsp";
    }
}