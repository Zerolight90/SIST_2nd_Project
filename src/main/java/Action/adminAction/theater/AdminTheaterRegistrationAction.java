package Action.adminAction.theater;

import Action.Action;
import mybatis.dao.AdminTheaterBoardDAO;
import mybatis.vo.TheaterInfoBoardVO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminTheaterRegistrationAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;

        //요청방식 구하기
        String method = request.getMethod();
        if (method.equalsIgnoreCase("post")) {
            //극장 기본 정보 폼에서 넘어온 파라미터 받기
            String tName = request.getParameter("tName");
            String tRegion = request.getParameter("tRegion");
            String tAddress = request.getParameter("tAddress");
            String tInfo = request.getParameter("tInfo");

            //극장 상세 정보 안내 폼에서 넘어온 파라미터 받기
            String tIdx = request.getParameter("tIdx");
            String[] facilitiesArr = request.getParameterValues("tFacilities");

            //극장 상세 정보-보유시설
            String tFacilities = "";

            if (facilitiesArr != null) { //보유시설 배열의 값이 null이 아니면
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < facilitiesArr.length; i++) {
                    sb.append(facilitiesArr[i]);
                    // 마지막 요소가 아닐 때만 쉼표를 추가
                    if (i < facilitiesArr.length - 1) {
                        sb.append(",");
                    }
                }
                tFacilities = sb.toString();
            }
            //System.out.println(tFacilities + "::::::::::");

            // 층별안내: 반복문으로 각 층의 텍스트를 가져와 \n으로 합침
            StringBuilder floorInfoBuilder = new StringBuilder();
            for (int i = 1; i <= 5; i++) { // 1층부터 5층까지 반복
                String floorName = "floor" + i + "Textarea"; // JSP name 속성 동적 생성
                String floorInfo = request.getParameter(floorName);
                if (floorInfo != null && !floorInfo.trim().isEmpty()) {
                    floorInfoBuilder.append(i).append("층: ").append(floorInfo).append("\n");
                }
            }
            String tFloorInfo = floorInfoBuilder.toString().trim();

            //System.out.println(tFloorInfo + "::::::::::tFloorInfo");

            String tParkingInfo = request.getParameter("tParkingInfo");
            String tParkingChk = request.getParameter("tParkingChk");
            String tParkingPrice = request.getParameter("tParkingPrice");
            String tBusRouteToTheater = request.getParameter("tBusRouteToTheater");
            String tSubwayRouteToTheater = request.getParameter("tSubwayRouteToTheater");


            TheaterVO tvo = new TheaterVO();
            tvo.settName(tName);
            tvo.settRegion(tRegion);
            tvo.settAddress(tAddress);
            tvo.settInfo(tInfo);

            TheaterInfoBoardVO infovo = new TheaterInfoBoardVO();
            infovo.settIdx(tIdx);
            infovo.settFacilities(tFacilities);
            infovo.settFloorInfo(tFloorInfo);
            infovo.settParkingInfo(tParkingInfo);
            infovo.settParkingChk(tParkingChk);
            infovo.settParkingPrice(tParkingPrice);
            infovo.settBusRouteToTheater(tBusRouteToTheater);
            infovo.settSubwayRouteToTheater(tSubwayRouteToTheater);

            // DAO를 호출하여 DB에 데이터 저장
            AdminTheaterBoardDAO.add(tvo, infovo);

            // DB 저장 후 보여줄 페이지 지정
            viewPath = "Controller?type=adminTheaterView&tIdx="+ tvo.gettIdx();

        } else {
            // GET 방식으로 요청이 온 경우 (단순히 페이지 이동)
            viewPath = "admin/adminTheaterRegistration.jsp";
        }

        return viewPath;
    }
}
