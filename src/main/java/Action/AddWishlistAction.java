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
            return null;
        }

        String userIdx = mvo.getUserIdx();
        String mIdx = request.getParameter("mIdx");

        Map<String, String> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("mIdx", mIdx);

        JSONObject json = new JSONObject();

        try {
            boolean isExist = FavoriteMovieDAO.isAlreadyWished(map);

            if (isExist) {
                json.put("status", "alreadyExists");
            } else {
                int result = FavoriteMovieDAO.addWishlist(map);
                if (result > 0) {
                    json.put("status", "success");
                } else {
                    json.put("status", "fail");
                    json.put("message", "데이터베이스 저장에 실패했습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", "fail");
            json.put("message", "처리 중 예외가 발생했습니다.");
        }

        // JSON 응답 보내기
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

// Use try-with-resources to automatically close the PrintWriter
        try (PrintWriter out = response.getWriter()) {
            out.print(json.toJSONString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

// Ajax 통신이므로 포워딩할 경로가 없어 null 반환
        return null;

    }
}