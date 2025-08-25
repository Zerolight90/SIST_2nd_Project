package Action.loginAction;

import Action.Action;
import mybatis.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IdCheckAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

            String u_id = request.getParameter("u_id");

            boolean isDuplicate = MemberDAO.idCheck(u_id);
            request.setAttribute("chk", isDuplicate);


        return "/join/idCheck.jsp";
    }
}
