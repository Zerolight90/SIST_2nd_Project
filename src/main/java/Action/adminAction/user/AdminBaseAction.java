package Action.adminAction.user;

import Action.Action;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBaseAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        MemberVO[] ar = MemberDAO.getMemInfo();

        request.setAttribute("ar", ar);

        return "admin/adminBase.jsp";
    }
}
