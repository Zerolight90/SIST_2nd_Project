package Action;

import mybatis.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBaseAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        MemVO[] ar = MemberDAO.getMemInfo();

        request.setAttribute("ar", ar);

        return "admin/adminBase.jsp";
    }
}
