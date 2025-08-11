package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.AdminVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminCheckAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        Map<String, String> map = new HashMap<>();
        map.put("id", id);
        map.put("pw", pw);

        AdminVO vo = AdminDAO.adminCheck(map);

        if (vo != null){
            request.setAttribute("vo", vo);

            return "Controller?type=admin";
        } else {
            return "index.jsp";
        }
    }
}
