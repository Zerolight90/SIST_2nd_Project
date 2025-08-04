package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBoardWrite implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //반환값을 String으로 준비
        String viewPath=null;

        String enc_type = request.getContentType();

        

        return viewPath;
    }
}
