package Action.movieAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import com.google.gson.JsonObject;
import mybatis.dao.ReviewDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.ReviewVO;

import java.io.PrintWriter;

public class ReviewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
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

            // 방금 등록한 리뷰 응답 JSON 만들기
            JsonObject json = new JsonObject();
            json.addProperty("user", mvo.getName().charAt(0) + "**");
            json.addProperty("rating", rating);
            json.addProperty("content", content);
            json.addProperty("time", "방금 전");

            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json.toString());
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
