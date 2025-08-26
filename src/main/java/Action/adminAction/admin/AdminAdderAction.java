package Action.adminAction.admin;

import Action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAdderAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        return "admin/adminAdderModal.jsp";
    }
}
