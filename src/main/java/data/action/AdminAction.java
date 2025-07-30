package data.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        return "adminBase.jsp";
    }
}
