package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.AdminVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminListAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        AdminVO[] ar = AdminDAO.getAllAdmin();

        request.setAttribute("ar", ar);

        return "admin/adminList.jsp";
    }
}
