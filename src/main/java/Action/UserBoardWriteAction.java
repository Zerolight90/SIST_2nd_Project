package Action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.UserBoardDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class UserBoardWriteAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //반환값을 String으로 준비
        String viewPath = null;

        String enc_type = request.getContentType();

        if (enc_type == null) {
            viewPath = "/userInquiryWrite.jsp";

        } else if (enc_type.startsWith("multipart")) {

            try {

                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1025 * 5, "utf-8", new DefaultFileRenamePolicy());

                String title = mr.getParameter("title");
                String content = mr.getParameter("content");
                String boardType = mr.getParameter("type");
                String is_answered = mr.getParameter("is_answered");

                File f = mr.getFile("file");

                String fname = null;
                String oname = null;
                if (f != null) {
                    fname = f.getName();
                    oname = mr.getOriginalFileName("file");
                }

                //System.out.println(boardType +":::::::::::타입에 대한 설명입니다");

                UserBoardDAO.add(boardType, title, content, fname, oname, boardType, is_answered);

                viewPath = "/userInquiryWrite.jsp";

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

            return viewPath;
    }
}
