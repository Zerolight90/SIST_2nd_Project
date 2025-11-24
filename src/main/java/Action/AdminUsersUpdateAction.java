package Action;

import mybatis.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminUsersUpdateAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();
        map.put("userIdx", request.getParameter("userIdx"));
        map.put("name", request.getParameter("name"));
        map.put("email", request.getParameter("email"));
        map.put("phone", request.getParameter("phone"));
        map.put("totalPoints", request.getParameter("totalPoints"));

        MemberDAO.editUsers(map);

        return "Controller?type=userSearch";
    }
}
