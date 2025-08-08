package Action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.AdminBoardDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class AdminBoardWriteAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //반환값을 String으로 준비
        String viewPath=null;

        String enc_type = request.getContentType();
        System.out.println("enc_type::::::::::" + enc_type);

        if(enc_type == null)
            viewPath = "admin/adminWriteBoard.jsp";
        else if(enc_type.startsWith("multipart")) {
            try {
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                //첨부파일과 다른 파라미터들을 받기 위해 MultipartRequest 생성
                //COS라이브러리가 있어야 한다.
                MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1025 * 5, "utf-8", new DefaultFileRenamePolicy()); //동일한 이름의 파일이 있다면, DefaultFileRenamePolicy()가 바꿔준다.

                //나머지 파라미터들 얻기
                String boardType = mr.getParameter("boardType");
                String title = mr.getParameter("title");
                String writer = mr.getParameter("writer");
                String content = mr.getParameter("content");
                String boardRegDate = mr.getParameter("boardRegDate");
                String boardEndRegDate = mr.getParameter("boardEndRegDate");
                String boardStatus = mr.getParameter("boardStatus");


                //첨부파일이 있다면 fname과 oname을 얻어내야 한다.
                File f = mr.getFile("file");

                //파일 첨부가 되어있다면, null이 아님
                String fname = null;
                String oname = null;
                if (f != null) {
                    fname = f.getName();
                    oname = mr.getOriginalFileName("file");
                }

                AdminBoardDAO.add(boardType, title, writer, content, fname, oname, boardRegDate, boardEndRegDate, boardStatus);

                viewPath = "Controller?type=adminBoardList";

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return viewPath;
    }
}
