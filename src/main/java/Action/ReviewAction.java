package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.ReviewDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.ReviewVO;

import java.io.PrintWriter;

public class ReviewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        MemberVO mvo = (MemberVO) request.getSession().getAttribute("mvo");
        if (mvo == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return null;
        }

        String mIdx = request.getParameter("mIdx");
        String rating = request.getParameter("rating");
        String content = request.getParameter("reviewText");
        String ip = request.getRemoteAddr();

        ReviewVO rvo = new ReviewVO();
        rvo.setmIdx(mIdx);
        rvo.setReviewRating(rating);
        rvo.setReviewContent(content);
        rvo.setIp(ip);
        rvo.setUserIdx(mvo.getUserIdx());

        int result = ReviewDAO.insertReview(rvo);

        try {
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();

            // JSON 직접 출력
            out.print("{");
            out.printf("\"user\":\"%s**\",", mvo.getName().charAt(0));
            out.printf("\"rating\":\"%s\",", rating);
            out.printf("\"content\":\"%s\",", content.replace("\"","\\\""));
            out.printf("\"time\":\"방금 전\"");
            out.print("}");
            out.flush();
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


        return null;

    }


}


