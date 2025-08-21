package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminTheaterRegistrationAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = "admin/adminTheaterRegistration.jsp";


        return viewPath;
    }
}
