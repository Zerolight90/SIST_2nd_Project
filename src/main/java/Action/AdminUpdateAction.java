package Action;

import mybatis.dao.AdminDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminUpdateAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();
        map.put("adminIdx", request.getParameter("adminIdx"));
        map.put("tIdx", request.getParameter("tIdx"));
        map.put("adminId", request.getParameter("adminId"));
        map.put("adminPassword", request.getParameter("adminPassword"));
        map.put("adminLevel", request.getParameter("adminLevel"));
        map.put("adminstatus", request.getParameter("adminstatus"));

        AdminDAO.updateAdmin(map);

        return "Controller?type=adminList";
    }
}
