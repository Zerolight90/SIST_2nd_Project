package Action;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.AdminBoardDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class AdminBoardWriteAction implements Action{

    //ajax요청인 경우
    private void writeJson(HttpServletResponse response, Map<String, Object> data) throws Exception {
        response.setContentType("application/json; charset=UTF-8");
        System.out.println("response.getWriter()" + data + "///////" + response.getWriter());
        new Gson().toJson(data, response.getWriter());
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("AdminBoardWriteAction!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        //반환값을 String으로 준비
        String viewPath=null;

        String enc_type = request.getContentType();
        System.out.println("enc_type::::::::::" + enc_type);

        if(enc_type == null) {

            String boardType = request.getParameter("type");

            System.out.println("AdminBoardWriteAction.boardType::::::::::" + boardType);

            if("adminWriteBoard".equals(boardType)) {
                viewPath = "admin/adminWriteBoard.jsp";
            } else if("adminWriteEvent".equals(boardType)) {
                viewPath = "admin/adminWriteEvent.jsp";
            } else {
                viewPath = "admin/adminWriteBoard.jsp";
            }
        }else if(enc_type.startsWith("multipart")) {
            System.out.println("AdminBoardWriteAction!!!!!!!!!!!!!!!!!!!!!!!1111111!!!!!");
            try {
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                // 썸네일 저장 경로
                String thumbPath = application.getRealPath("/event_thumbnails");

                //첨부파일과 다른 파라미터들을 받기 위해 MultipartRequest 생성
                //COS라이브러리가 있어야 한다.
                MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1025 * 5, "utf-8", new DefaultFileRenamePolicy()); //동일한 이름의 파일이 있다면, DefaultFileRenamePolicy()가 바꿔준다.

                //나머지 파라미터들 얻기
                String boardIdx = mr.getParameter("boardIdx");
                String boardType = mr.getParameter("boardType");
                String subBoardType = mr.getParameter("sub_boardType");
                String title = mr.getParameter("title");
                String writer = mr.getParameter("writer");
                String content = mr.getParameter("content");
                String boardStartRegDate = mr.getParameter("boardStartRegDate");
                String boardEndRegDate = mr.getParameter("boardEndRegDate");
                String boardStatus = mr.getParameter("boardStatus");
                String parent_boardIdx = mr.getParameter("boardIdx");
                String is_answered = mr.getParameter("is_answered");

                System.out.println("parent_boardIdx:::::::::::::" + parent_boardIdx);


                //첨부파일이 있다면 fname과 oname을 얻어내야 한다.
                File f = mr.getFile("file");

                //파일 첨부가 되어있다면, null이 아님
                String fname = null;
                String oname = null;

                if (f != null) {
                    fname = f.getName();
                    oname = mr.getOriginalFileName("file");
                }

                //썸네일 이미지 파일 등록
                File thumb_file = mr.getFile("thumb_file");
                String thumbfilename = null;

                if (thumb_file != null) {
                    File newThumbFile = new File(thumbPath, thumb_file.getName());
                    thumb_file.renameTo(newThumbFile);
                    thumbfilename = thumb_file.getName();
                }

                AdminBoardDAO.add(boardType, parent_boardIdx, subBoardType, title, writer, content, fname, oname, thumbfilename, boardStartRegDate, boardEndRegDate, boardStatus);

                AdminBoardDAO.update(boardIdx, is_answered);

                System.out.println("boardType은:::::::::::::" + boardType);
                //System.out.println("subBoardType:::::::::::::"+ subBoardType);

                // boardType에 따라 viewPath 설정
                if ("공지사항".equals(boardType)) {
                    viewPath = "Controller?type=adminBoardList";
                } else if ("이벤트".equals(boardType)) {
                    viewPath = "Controller?type=adminEventList";
                } else if("QnA".equals(boardType)) {
                    // 폼 파라미터로 받은 데이터
                    parent_boardIdx = mr.getParameter("parent_boardIdx");
                    content = mr.getParameter("content");

                    // JSP 페이지에 전달할 데이터를 request 속성으로 저장
                    request.setAttribute("parent_boardIdx", parent_boardIdx);
                    request.setAttribute("content", content);
                    request.setAttribute("success", true);
                    request.setAttribute("message", "등록 완료");

                    System.out.println(content + ":::::::::content");

                    viewPath = "admin/adminSaveInquiry.jsp";
                }else {
                    viewPath = "Controller?type=adminBoardList";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewPath;
    }
}