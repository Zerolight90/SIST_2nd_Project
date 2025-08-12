package Action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.AdminBoardDAO;
import mybatis.vo.AdminBoardVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class AdminBoardEditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //작업이 구분이 되어야 한다. (넘어오면 contentType으로 구분하면 된다.)
        //넘어올 때 form이 post방식으로 넘어오는데, enc_type이 application으로 시작할 것임
        //post방식으로 넘어올 때 먼저 요청시 contentType 얻어낸다.
        //이쪽으로 두군데서 오게 되므로 구분을 해야한다.
        String enc_type = request.getContentType();
        System.out.println("enc_type:::::::" + enc_type);

        String viewPath = null;
        String boardType = null;

        if(enc_type.startsWith("application")){
            //application이라면 adminViewBoard.jsp에서 넘어온 것
            //adminViewBoard.jsp에서 수정 버튼을 클릭 한 경우 수정화면으로 이동해야 한다.
            //수정하고자 하는 게시물을 얻어내야 한다.
            String boardIdx = request.getParameter("boardIdx");
            boardType = request.getParameter("type");
            AdminBoardVO vo = AdminBoardDAO.getBoard(boardIdx);

            request.setAttribute("vo", vo);

            System.out.println("boardType은:::???" + boardType);
            if(boardType.equals("adminEditBoard")){
                viewPath = "admin/adminEditBoard.jsp"; // 여기서 forward되므로 이쪽으로 넘어오는
                //파라미터들(boardIdx, cPage)은 그대로 유지되어 adminEditBoard.jsp로 간다.
            } else if(boardType.equals("adminEditEvent")){
                viewPath = "admin/adminEditEvent.jsp";
            }

            
        }else if(enc_type.startsWith("multipart")){
            //multipart/form-data라면 adminEditBoard.jsp에서 넘어온 것
            //jsp에서 값을 수정한 후 DB에 UPDATE를 수행하길 원하는 경우
            //첨부파일을 처리하기 위해 bbs_upload 폴더의 절대경로가 필요하다.
            ServletContext application = request.getServletContext();

            try{
                String realPath = application.getRealPath("/bbs_upload");

                MultipartRequest mr = new MultipartRequest(request, realPath,1024*1025*5, 
                        "utf-8", new DefaultFileRenamePolicy()); //동일한 파일의 이름이 있다면, DefaultFileRenamePolicy()가 바꿔줌

                //나머지 파라미터들 얻기(boardTitle, boardWriter, boardContent)
                String boardTitle = mr.getParameter("boardTitle");
                boardType = mr.getParameter("type");
                String subBoardType = mr.getParameter("sub_boardType");
                String boardContent = mr.getParameter("boardContent");
                String boardRegDate = mr.getParameter("boardRegDate");
                String boardEndRegDate = mr.getParameter("boardEndRegDate");
                String boardIdx = mr.getParameter("boardIdx");
                String cPage = mr.getParameter("cPage");

                //첨부파일이 있다면 fname과 oname을 얻어내야 한다.
                File f = mr.getFile("file"); //파라미터 이름은 name을 써야한다.

                //파일 첨부가 되어있다면 null이 아님
                String fname = null;
                String oname = null;

                if(f!=null){
                    fname = f.getName(); //현재 저장된 파일명(바뀐 파일명_중복된 파일이 있으면 바꿔줌)
                    oname = mr.getOriginalFileName("file"); //기존 사용자가 저장한 파일명
                }

                AdminBoardDAO.edit(boardIdx, boardTitle, subBoardType, boardRegDate, boardEndRegDate, boardContent, fname, oname);

                if(boardType.equals("adminEditBoard")){
                    viewPath = "Controller?type=adminViewBoard&boardIdx=" + boardIdx + "&cPage=" + cPage;
                } else if(boardType.equals("adminEditEvent")){
                    viewPath = "Controller?type=adminViewEvent&boardIdx=" + boardIdx + "&cPage=" + cPage;
                } else if(boardType.equals("adminEditInquiry")){
                    viewPath = "Controller?type=adminViewInquiry&boardIdx=" + boardIdx + "&cPage=" + cPage;
                }
                System.out.println("보드타입::"+boardType);
                //viewPath = "Controller?type=adminViewBoard&boardIdx=" + boardIdx + "&cPage=" + cPage;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return viewPath;
    }
}