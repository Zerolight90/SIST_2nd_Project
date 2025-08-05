package Action;

import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NmemAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        NmemVO[] ar = NmemDAO.getAllNmem();

        request.setAttribute("ar", ar);

        return "admin/adminNmem.jsp";
    }
}
