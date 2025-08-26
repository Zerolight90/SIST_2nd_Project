package Action;

import com.google.gson.JsonObject;
import mybatis.dao.ReviewDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class DeleteReviewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        MemberVO mvo = (MemberVO) request.getSession().getAttribute("mvo");
        JsonObject resultJson = new JsonObject();
        boolean success = false;
        String message = "";

        if (mvo == null) {
            message = "로그인이 필요합니다.";
        } else {
            String reviewIdx = request.getParameter("reviewIdx");
            String userIdx = mvo.getUserIdx();

            Map<String, String> params = new HashMap<>();
            params.put("reviewIdx", reviewIdx);
            params.put("userIdx", userIdx);

            int result = ReviewDAO.deleteReview(params);

            if (result > 0) {
                success = true;
            } else {
                message = "관람평 삭제에 실패했습니다.";
            }
        }

        resultJson.addProperty("success", success);
        resultJson.addProperty("message", message);

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        out.print(resultJson.toString());
        out.flush();
        out.close();

        return null;
    }
}