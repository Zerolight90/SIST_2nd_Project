package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminUsersEditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String userIdx = request.getParameter("userIdx");

        MemberVO vo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));

        request.setAttribute("vo", vo);

        return "admin/adminUsersModal.jsp";
    }
}
