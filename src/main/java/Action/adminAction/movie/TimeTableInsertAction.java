package Action.adminAction.movie;

import Action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TimeTableInsertAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        return "admin/adminTimeModal.jsp";
    }
}
