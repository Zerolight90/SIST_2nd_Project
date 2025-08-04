package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SeatAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        return "seat.jsp";
    }
}
