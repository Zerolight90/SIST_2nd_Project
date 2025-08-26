package Action.adminAction.login;

import Action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLogOutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession ss = request.getSession();
        if (ss != null) {
            ss.invalidate();
        }

        return "Controller?type=index";
    }
}
