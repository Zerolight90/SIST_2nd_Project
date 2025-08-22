package Action;

import mybatis.dao.ReviewDAO;
import mybatis.vo.MovieVO; // MovieVO 클래스 추가 (예시)
import mybatis.vo.ReviewVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ReviewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        return "";
    }
}
