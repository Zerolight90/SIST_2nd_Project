package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.ReviewDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.ReviewVO;

public class ReviewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");

            MemberVO mvo = (MemberVO) request.getSession().getAttribute("mvo");
            if (mvo == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return null;
            }

            String mIdx = request.getParameter("mIdx");
            String rating = request.getParameter("rating");
            String content = request.getParameter("reviewText");
            String ip = request.getRemoteAddr();

            ReviewVO vo = new ReviewVO();
            vo.setmIdx(mIdx);
            vo.setReviewRating(rating);
            vo.setReviewContent(content);
            vo.setIp(ip);
            vo.setUserIdx(mvo.getUserIdx());

            System.out.println("로그인 유저 userIdx = " + mvo.getUserIdx());
            System.out.println("리뷰 저장 데이터: mIdx=" + mIdx + ", rating=" + rating + ", content=" + content);



            int result = ReviewDAO.insertReview(vo);

            response.setContentType("application/json; charset=UTF-8");
            if (result > 0) {
                response.getWriter().write("{\"status\":\"success\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"fail\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"error\"}");
            } catch (Exception ignored) {}
        }
        return null; // JSP forward 안 하고 바로 JSON 응답
    }
}


