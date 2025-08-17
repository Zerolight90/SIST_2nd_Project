package Action;

import mybatis.dao.NaverDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NaverLogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession(false);
        if (session != null) {
            String accessToken = (String) session.getAttribute("naver_access_token");
            if (accessToken != null && !accessToken.isEmpty()) {
                NaverDAO ndao = new NaverDAO();
                try {
                    boolean ok = ndao.deleteToken(accessToken);
                    System.out.println(ok ? "Naver unlink success" : "Naver unlink failed");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            session.invalidate();
        }
        return "/index.jsp";
    }
}
