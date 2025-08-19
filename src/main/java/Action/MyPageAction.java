package Action;

import util.Paging; // Paging 클래스를 다시 import 합니다.

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String type = request.getParameter("type");
        String viewPath = null;

        try {

            if (type == null || type.equals("myPage")) {
                return "./mypage/myPage.jsp";
            }

            switch (type) {
                case "myReservation":

                    String cPage = request.getParameter("cPage");
                    int nowPage = 1;
                    if (cPage != null && !cPage.isEmpty()) {
                        nowPage = Integer.parseInt(cPage);
                    }
                    Paging pvo = new Paging(5, 5); // 한 페이지에 5개, 블록당 5페이지
                    pvo.setTotalCount(23); // TODO: DB에서 실제 데이터 총 개수로 변경해야 합니다.
                    pvo.setNowPage(nowPage);

                    // JSP에서 페이징을 사용하기 위해 request에 저장
                    request.setAttribute("pvo", pvo);
                    // =================================================================

                    // 샘플 데이터 생성
                    List<Map<String, String>> sampleList = new ArrayList<>();
                    for (int i = 0; i < 5; i++) {
                        Map<String, String> map = new HashMap<>();
                        map.put("posterPath", "/images/umbokdong.png");
                        map.put("paymentDate", "2025-02-1" + i + " 14:30:00");
                        map.put("movieTitle", "샘플 영화 " + (i + 1));
                        map.put("theaterInfo", "강남 프리미엄관");
                        map.put("screenDate", "2025-02-2" + i + " 19:00:00");
                        sampleList.add(map);
                    }
                    request.setAttribute("reservationList", sampleList);

                    viewPath = "./mypage/myPage_reservationHistory.jsp";
                    break;

                case "myCoupon":
                    viewPath = "./mypage/myPage_couponList.jsp";
                    break;
                case "myPrivateinquiry":
                    viewPath = "./mypage/myPage_privateinquiry.jsp";
                    break;
                case "myPoint":
                    viewPath = "./mypage/myPage_pointHistory.jsp";
                    break;
                case "myMovieStory":
                    viewPath = "./mypage/myPage_movieStory.jsp";
                    break;
                case "myUserInfo":
                    viewPath = "./mypage/myPage_userInfo.jsp";
                    break;
                default:
                    viewPath = "./mypage/myPage.jsp";
                    break;
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            return null;
        }

        return viewPath;
    }
}