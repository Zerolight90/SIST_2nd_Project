package data.control;

import data.action.Action;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

@WebServlet("/Controller")
public class Controller extends HttpServlet {

    // Properties 파일의 경로를 저장하자
    private String myParam = "/WEB-INF/action.properties";

    // 위의 myParam 이라는 값이 data.action.properties의 경로를 가지고
    // 그 파일의 내용 (클래스의 경로 / =을 기준으로 전후가 키 밸류) 들을 가져와서 객체로 생성한 후
    // 생성된 객체의 주소를 아래의 Map 구조에 저장한다.
    private Map<String, Action> actionMap;

    public Controller(){
        actionMap = new HashMap<>();
    }

    @Override
    public void init() throws ServletException {

        ServletContext application = this.getServletContext();
        String realPath = application.getRealPath(myParam);
        /*System.out.println("[1] action.properties 실제 경로: " + realPath);
        if (realPath == null) {
            System.out.println("[오류] action.properties 파일 경로를 찾을 수 없습니다. webapp/WEB-INF/ 폴더에 파일이 있는지 확인하세요.");
            return;
        }*/

        Properties prop = new Properties();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(realPath);
            prop.load(fis);
        } catch (Exception e) {
            e.printStackTrace();
            return; // 파일 로드 실패 시 init 중단
        } finally {
            if (fis != null) {
                try { fis.close(); } catch (Exception e) {}
            }
        }

        Iterator<Object> it = prop.keySet().iterator();

        while (it.hasNext()) {
            String key = (String) it.next();
            String value = prop.getProperty(key);

            try {
                Object obj = Class.forName(value).newInstance();
                actionMap.put(key, (Action) obj);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 시 한글처리
        request.setCharacterEncoding("UTF-8");

        // type 이라는 파라미터 받기
        String type = request.getParameter("type");

        // type이 전달되지 않아서 null을 가지면 index로 초기화 하자
        if (type == null){
            type = "index";
        }

        // type으로 받은 값이 actionMap의 key로 사용되고 있으므로
        // 원하는 객체를 얻어내자
        Action action = actionMap.get(type);

        String viewPath = action.execute(request, response);

        // viewPath가 null 이면 현재 컨트롤러를 sendRedirect로
        // 다시 호출되도록 한다
        if (viewPath == null){
            response.sendRedirect("Controller");
        } else {
            // forward로 이동
            RequestDispatcher disp = request.getRequestDispatcher(viewPath);
            disp.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
