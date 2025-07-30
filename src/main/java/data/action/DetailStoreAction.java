package data.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DetailStoreAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        return "detailStore.jsp";
    }
}
