package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.AdminVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
            HttpSession ss = request.getSession();
            ss.setAttribute("vo", vo);

            return "Controller?type=userSearch";
        } else {
            return "index.jsp";
        }
    }
}
