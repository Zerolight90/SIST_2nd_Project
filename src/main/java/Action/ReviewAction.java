package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
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

            // 새로 작성된 리뷰 정보를 JSON으로 구성
            Gson gson = new Gson();

            // 사용자명은 첫 글자만 표시하고 나머지는 * 처리
            String maskedUser = mvo.getName().substring(0,1) + "**";

            // 응답 데이터 객체
            ReviewResponse respData = new ReviewResponse(
                    maskedUser, rating, content, "방금 전"
            );

            out.print(gson.toJson(respData));
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 내부 클래스: 응답 JSON 포맷 전용
    class ReviewResponse {
        String user;
        String rating;
        String content;
        String time;

        ReviewResponse(String user, String rating, String content, String time) {
            this.user = user;
            this.rating = rating;
            this.content = content;
            this.time = time;
        }
    }
}
