package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        return "JSP/index.jsp";
    }
}
