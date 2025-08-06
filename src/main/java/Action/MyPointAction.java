package Action;

import mybatis.dao.MemberDAO;
import mybatis.dao.PointDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.PointVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class MyPointAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 1. 세션에서 로그인 정보 가져오기
            HttpSession session = request.getSession();
            MemberVO mvo = (MemberVO) session.getAttribute("mvo");

            // 2. 로그인 정보가 없으면 JSP로 그냥 이동 (JSP에서 empty로 처리)
            if (mvo == null) {
                return "/mypage/myPage_pointHistory.jsp";
            }

            // 3. 로그인된 사용자의 ID를 얻어 DB 조회
            String userIdx = mvo.getUserIdx();

            MemberVO memberInfo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));
            List<PointVO> list = PointDAO.getPointHistory(Long.parseLong(userIdx));

            // 4. 조회된 결과를 request에 저장
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("pointHistory", list);

        } catch (Exception e) {
            // 예외 발생 시 서버 로그에만 기록 (사용자에게는 빈 화면 또는 에러페이지 표시)
            e.printStackTrace();
        }

        // 5. JSP 경로 반환
        return "/mypage/myPage_pointHistory.jsp";
    }
}