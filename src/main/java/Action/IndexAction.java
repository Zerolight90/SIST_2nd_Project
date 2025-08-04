package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class IndexAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

            return "index.jsp"; // Controller가 forward할 로그인 페이지 경로
        }
    }

