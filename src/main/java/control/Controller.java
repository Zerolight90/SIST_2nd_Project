package control;

import action.Action;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
    // 경로 지정
    private String myParam = "/WEB-INF/action.properties";

    // 위의 myparam이라는 값이 액션.프로퍼티스의 경로를 가지고
    // 그 파일의 내용(클래스의 경로)들을 가져와서 객체로 생성한 후
    // 생성된 객체의 주소를 아래의 Map구조에 저장한다.
    private Map<String, Action> actionMap;

    public Controller(){
        actionMap = new HashMap<>();
    }

    @Override
    public void init() throws ServletException {
        // 생성자 다음으로 첫 요청자에 의해 딱 한번 수행하는 함수
        // 현재 서블릿이 생성될 때 멤버변수인 myparam값이 존재한다.
        // myparam이 가지고 있는 값을 절대경로로 만들어야 한다.
        // jsp에서는 application이라는 내장객체가 존재했지만 서블릿에서는 직접 얻어내야 한다.
        ServletContext application = this.getServletContext();

        String realPath = application.getRealPath(myParam);
        // System.out.println(realPath);

        // 절대경로화 시킨 이유는 해당 파일의 내용(클래스 경로)을 스트림을 이용하여
        // 읽어와서 프로퍼티스 객체에 담기 위해서이다.
        Properties prop = new Properties();
//        prop.setProperty("index", "emp.action.IndexAction");
        // 위처럼 저장하면 하나하나 일일이 추가해야 한다.
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(realPath);

            prop.load(fis); // << 얘가 알아서 읽어서 키와 값을 채운다.
        } catch (Exception e) {
            e.printStackTrace();
        }

        Iterator<Object> it = prop.keySet().iterator();

        // 키들을 모두 얻었으니 키에 연결된 클래스 경로들을 하나씩 얻어내어 객체 생성 후 맵에 저장
        while(it.hasNext()){
            String key = (String)it.next();

            String value = prop.getProperty(key); // "emp.action.IndexAction"

            try {
                Object obj = Class.forName(value).newInstance();
                // class를 통해 정확한 클래스의 경로가 있다면 위와 같이 객체를 생성할 수 있다.
                actionMap.put(key, (Action)obj);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 요청시 한글처리
        request.setCharacterEncoding("utf-8");

        // type이라는 파라미터 받기
        String type = request.getParameter("type");

        // null 고려
        if (type == null){
            type = "index";
        }
        Action action = actionMap.get(type);

        String viewPath = action.execute(request, response);

        if (viewPath == null){
            response.sendRedirect("Controller");
        } else {
            RequestDispatcher disp =
                    request.getRequestDispatcher(viewPath);
            disp.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
