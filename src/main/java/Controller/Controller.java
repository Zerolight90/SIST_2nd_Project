package Controller;
import Action.Action;
import Action.IndexAction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

@WebServlet("/Controller")
public class Controller extends HttpServlet {

    //Properties파일의 경로를 저장하자!
    private String myParam = "/WEB-INF/action.properties";

    /*
    위에 myParm이라는 값이 action.properties의 경로를 가지고
    그 파일의 내용(Value 값인 클래스의 경로)들을 가져와서 객체로 생성한 후
    생성된 객체의 주소를 아래의 Map구조에 저장한다.
     */
    private Map<String, Action> actionMap;

    public Controller(){
        actionMap = new HashMap<>();
    }

    @Override
    public void init() throws ServletException {
        //생성자 다음으로 최초 한번 수행 초기수행 값만 작성

        //현재 서블릿이 생성될 때 멤버변수인 myParm값이 존재한다.
        //그 myparam이 가지고 있는 값을 절대경로로 만들어야 한다.
        //jsp에서는 application이라는 내장객체가 존재 했지만, 서블릿에서는 직접 얻어내야 한다.

        ServletContext application = this.getServletContext();

        String realPath = application.getRealPath(myParam);
//        System.out.println(realPath);

        //절대경로화 시킨 이유는
        //해당 파일의 내용(클래스 경로)을 스트림을 이용하여
        //읽어와서 Properties객체 담기 위함이다.
        Properties prop= new Properties();
//        prop.setProperty("index", "emp.action.IndexAction");
        //위처럼 저장을 해야하지만 이렇게 하면 기능이 하나 생길때마다
        //소스코드를 수정해야 하는 번거로움이 있다.

        //Properties의 load함수를 이용하여 내용들을 읽기한다. 이때 필요한 객체가
        //InputStream이다.

        FileInputStream fis = null;
        try {
            //action.properties를 연결된 스트림 준비
            fis = new FileInputStream(realPath);
            prop.load(fis);
            //읽어서 비어있던 Properties객체에 키와 값을 쌍으로
            //저장한다.

        } catch (Exception e) {
            e.printStackTrace();
        }
        //생성할 객체들의 경로가 모두 Properties객체로 저장된 상태다.
        //하지만 현재 컨트롤러 입장에서는 생성할 객체가 몇개이며, 어떤객체인지 알지 못한다.
        //그래서 Preoperties에 저장된 키들을 모두 가져와서 반복자(Iterator)로 수행해야 한다.

        Iterator<Object> it = prop.keySet().iterator();

        //키들을 모두 얻었으니 키에 연결된 클래스 경로들을 하나씩 얻어 내어 객체를 생성한 후 actionMap에 저장한다
        while(it.hasNext()){
            //먼저 키를 하나 얻어내어 문자열에 반환
            String key = (String)it.next();
            //위에서 얻어낸 키와 연결된 값(value:클래스 경로)
            String value = prop.getProperty(key); //"emp.action.IndexAction"

            try {
                Object obj = Class.forName(value).newInstance();
                //쉽게 말해서 Class를 통해 정확한 클래스의 경로가 있다면 위와 같이 객체를 생성할 수 있다.

                //생성된 객체를 Action으로 형 변화시켜서
                //actionMap에 저장하자
                Action action = (Action)obj;
                actionMap.put(key, action);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }//while의 끝



    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //요청시 한글 처리
        request.setCharacterEncoding("UTF-8");
        //type이라는 파라미터 받기
        String type = request.getParameter("type");

        //type이 전달되지 않아서 null값 이면 index로 초기화 하자
        if(type == null){
            type = "index";
        }
        //type으로 받은 값이 actionMap의 key로 사용되고 있으므로
        //원하는 객체를 얻어내자
        Action action = actionMap.get(type);

        String viewPath = action.execute(request, response);

        //viewPath가 null이면 현재 컨트롤러를 sendRedirect로 다시 호출되도록 하자
        if(viewPath == null){
            response.sendRedirect("Controller");
        }else {
            //forward로 이동
            RequestDispatcher disp = request.getRequestDispatcher(viewPath);
            disp.forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
