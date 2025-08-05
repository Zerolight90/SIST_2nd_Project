package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ThscAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        

//        request.setAttribute("ar", ar);

        return "admin/adminTheaterScreen.jsp";
    }
}
