package Action;

import mybatis.dao.ReviewDAO;
import mybatis.vo.ReviewVO;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.List;

public class ReviewListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String mIdx = request.getParameter("mIdx");

        List<ReviewVO> reviews = ReviewDAO.getReviewListByMovieId(mIdx);

        response.setContentType("application/json; charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.print("[");
            for (int i = 0; i < reviews.size(); i++) {
                ReviewVO r = reviews.get(i);
                String user = (r.getMember() != null && r.getMember().getName() != null)
                        ? r.getMember().getName().charAt(0) + "**"
                        : "익명";
                out.printf("{\"user\":\"%s\",\"rating\":\"%s\",\"content\":\"%s\",\"time\":\"%s\"}",
                        user,
                        r.getReviewRating(),
                        r.getReviewContent().replace("\"","\\\""),
                        r.getReviewDate() != null ? r.getReviewDate() : "방금 전"
                );
                if (i < reviews.size() - 1) out.print(",");
            }
            out.print("]");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // forward X → JSON 응답만
    }
}
