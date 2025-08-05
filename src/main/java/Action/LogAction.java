package Action;

import mybatis.dao.LogDAO;
import mybatis.vo.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        LogVO[] ar = LogDAO.getAllLog();

        request.setAttribute("ar", ar);

        return "admin/adminLog.jsp";
    }
}
