package Action;

import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class NmemSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> params = new HashMap<>();
        params.put("datepicker", request.getParameter("datepicker"));
        params.put("search_field", request.getParameter("search_field"));
        params.put("search_keyword", request.getParameter("search_keyword"));

        NmemVO[] ar = NmemDAO.getNmemSearch(params);

        request.setAttribute("ar", ar);

        return "admin/adminNmemSearch.jsp";
    }
}
