package Action;

import mybatis.dao.MemberDAO;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class IdCheckAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

            String u_id = request.getParameter("u_id");

            boolean isDuplicate = MemberDAO.idCheck(u_id);
            request.setAttribute("chk", isDuplicate);


        return "/join/idCheck.jsp";
    }
}
