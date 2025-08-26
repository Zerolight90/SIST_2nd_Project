package Action.adminAction.admin;

import Action.Action;
import mybatis.dao.AdminDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminInsertAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        /*Object adminLevel = request.getSession().getAttribute("vo");
        AdminVO vo = (AdminVO) adminLevel;

        System.out.println(vo.getAdminLevel());

        if (!vo.getAdminLevel().equals("Super")){
            response.setContentType("text/html;charset=UTF-8");

            try {
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('슈퍼 관리자만 접근할 수 있습니다.');");
                out.println("history.back();");
                out.println("</script>");
                out.flush();
            } catch (Exception e) {
                e.printStackTrace();
            }

            return null;
        }*/

        Map<String, String> map = new HashMap<>();
        map.put("tIdx", request.getParameter("tIdx"));
        map.put("adminId", request.getParameter("adminId"));
        map.put("adminPassword", request.getParameter("adminPassword"));
        map.put("adminLevel", request.getParameter("adminLevel"));

        AdminDAO.insertAdmin(map);

        return "Controller?type=adminList";
    }
}
