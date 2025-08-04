package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_name = request.getParameter("u_name");
        String u_pw = request.getParameter("u_pw");
        MemVO mvo = MemberDAO.login(u_name, u_pw);
        request.setAttribute("mvo", mvo);
        return "Controller";
    }
}
