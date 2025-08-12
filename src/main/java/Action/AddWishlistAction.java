package Action;

import mybatis.dao.FavoriteMovieDAO;
import mybatis.vo.MemberVO;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class AddWishlistAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        if (mvo == null) {
            JSONObject json = new JSONObject();
            json.put("status", "fail");
            json.put("message", "로그인이 필요한 서비스입니다.");
            response.setContentType("application/json; charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.print(json.toJSONString());
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        String userIdx = mvo.getUserIdx();
        String mIdx = request.getParameter("mIdx");

        Map<String, String> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("mIdx", mIdx);

        JSONObject json = new JSONObject();
        boolean isSuccess = false;

        try {
            boolean isExist = FavoriteMovieDAO.isAlreadyWished(map);

            if (isExist) {
                int result = FavoriteMovieDAO.removeWishlist(map);
                if (result > 0) {
                    isSuccess = true;
                    json.put("action", "removed");
                }
            } else {
                int result = FavoriteMovieDAO.addWishlist(map);
                if (result > 0) {
                    isSuccess = true;
                    json.put("action", "added");
                }
            }

            if (isSuccess) {
                json.put("status", "success");
            } else {
                json.put("status", "fail");
                json.put("message", "처리 실패: DB 변경 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", "fail");
            json.put("message", "처리 중 예외 발생: " + e.getMessage());
        }

        // 좋아요 개수 조회 로직을 `try-catch` 바깥으로 이동
        // 이렇게 하면 좋아요 추가/삭제 로직이 성공하면 좋아요 개수 조회 실패 여부와 상관없이 성공 응답을 보냅니다.
        try {
            int newLikeCount = FavoriteMovieDAO.getLikeCount(mIdx);
            json.put("newLikeCount", newLikeCount);
        } catch (Exception e) {
            e.printStackTrace();
            // 좋아요 개수 조회에 실패해도 메인 로직은 성공으로 간주
            json.put("newLikeCount", -1); // 실패를 나타내는 값으로 설정
        }

        response.setContentType("application/json; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(json.toJSONString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }
}