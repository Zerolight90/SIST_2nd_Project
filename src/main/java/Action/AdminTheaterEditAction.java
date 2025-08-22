package Action;

import mybatis.dao.AdminTheaterBoardDAO;
import mybatis.vo.TheaterInfoBoardVO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AdminTheaterEditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;
        String method = request.getMethod(); // 요청 방식(GET, POST)을 가져옴

        if (method.equalsIgnoreCase("post")) {

            // tIdx를 포함한 모든 파라미터 받기
            String tIdx = request.getParameter("tIdx");

            // 극장 기본 정보 파라미터 받기
            String tName = request.getParameter("tName");
            String tRegion = request.getParameter("tRegion");
            String tAddress = request.getParameter("tAddress");
            String tInfo = request.getParameter("tInfo");

            // 극장 상세 정보 파라미터 받기
            String[] facilitiesArr = request.getParameterValues("tFacilities");
            String tFacilities = "";
            if (facilitiesArr != null) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < facilitiesArr.length; i++) {
                    sb.append(facilitiesArr[i]);
                    if (i < facilitiesArr.length - 1) {
                        sb.append(",");
                    }
                }
                tFacilities = sb.toString();
            }

            StringBuilder floorInfoBuilder = new StringBuilder();
            for (int i = 1; i <= 5; i++) {
                String floorName = "floor" + i + "Textarea";
                String floorInfo = request.getParameter(floorName);
                if (floorInfo != null && !floorInfo.trim().isEmpty()) {
                    floorInfoBuilder.append(i).append("층:").append(floorInfo).append("\n");
                }
            }
            String tFloorInfo = floorInfoBuilder.toString().trim();

            String tParkingInfo = request.getParameter("tParkingInfo");
            String tParkingChk = request.getParameter("tParkingChk");
            String tParkingPrice = request.getParameter("tParkingPrice");
            String tBusRouteToTheater = request.getParameter("tBusRouteToTheater");
            String tSubwayRouteToTheater = request.getParameter("tSubwayRouteToTheater");

            // TheaterVO와 TheaterInfoBoardVO 객체 생성 및 값 설정
            TheaterVO tvo = new TheaterVO();
            tvo.settIdx(tIdx); // tvo에 tIdx 설정
            tvo.settName(tName);
            tvo.settRegion(tRegion);
            tvo.settAddress(tAddress);
            tvo.settInfo(tInfo);

            TheaterInfoBoardVO infovo = new TheaterInfoBoardVO();
            infovo.settIdx(tIdx); // infovo에도 tIdx 설정
            infovo.settFacilities(tFacilities);
            infovo.settFloorInfo(tFloorInfo);
            infovo.settParkingInfo(tParkingInfo);
            infovo.settParkingChk(tParkingChk);
            infovo.settParkingPrice(tParkingPrice);
            infovo.settBusRouteToTheater(tBusRouteToTheater);
            infovo.settSubwayRouteToTheater(tSubwayRouteToTheater);

            // DAO를 호출하여 DB에 데이터 수정
            AdminTheaterBoardDAO.edit(tvo, infovo);

            // 수정 성공 후, 상세 보기 페이지로 리다이렉트
            viewPath = "Controller?type=adminTheaterView&tIdx=" + tIdx;

        } else {

            // tIdx 파라미터 받기
            String tIdx = request.getParameter("tIdx");
            if (tIdx != null && !tIdx.trim().isEmpty()) {

                // DB에서 기존 정보 불러오기
                TheaterInfoBoardVO infovo = AdminTheaterBoardDAO.getTheaterBoard(tIdx);

                // request에 데이터 저장하여 JSP로 전달
                request.setAttribute("infovo", infovo);

                // 지역 목록을 직접 생성하거나, DAO에서 가져오는 로직 추가
                List<String> regionList = Arrays.asList(
                        "서울", "경기", "인천", "부산", "대구", "대전", "광주", "울산",
                        "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"
                );

                request.setAttribute("regionList", regionList);

                //층별 안내
                List<String[]> floorList = new ArrayList<>();
                if(infovo != null && infovo.gettFloorInfo() != null && !infovo.gettFloorInfo().trim().isEmpty()){
                    String[] floors = infovo.gettFloorInfo().split("\n");
                    for (String floor : floors) {
                        String[] parts = floor.split(":", 2); // 첫 번째 ":"만 기준으로 분리
                        System.out.println(parts[0]);
                        System.out.println(parts[1]);
                        if (parts.length > 1) {
                            floorList.add(new String[]{parts[0].trim(), parts[1].trim()});
                        }
                    }
                }

                request.setAttribute("floorList", floorList);

                // 수정 화면(JSP) 경로 설정
                viewPath = "admin/adminTheaterEdit.jsp";
            } else {
                // tIdx가 없으면 목록으로 돌아가기
                viewPath = "Controller?type=adminTheaterList";
            }
        }
        return viewPath;
    }
}