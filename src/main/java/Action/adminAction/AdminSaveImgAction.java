package Action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class AdminSaveImgAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){

        //이미지들이 저장될 위치를 절대경로로 준비해야 한다.
        ServletContext application = request.getServletContext();
        String realPath = application.getRealPath("/editor_img");
        //System.out.println("realPath::::::::::::::::"+realPath);

        //첨부되어오는 이미지 파일을 위에서 준비한 절대경로에 업로드 시키기 위함
        //그렇게 하기 위해서는 cos라이브러리의 MultipartRequest 객체가 필요하다.
        try{
            MultipartRequest mr = new MultipartRequest(request, realPath,
                    1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
            //이 때 파일은 이미 editor_img폴더에 업로드가 된 상태이다.


            //파일이 저장될 때 이름이 변경될 수 있기 때문에 저장된 파일의
            //정확한 이름을 알아내야 한다.
            File f = mr.getFile("upload");
            String fname = null; //파일 첨부가 없을 수도 있기 때문
            if(f!=null)
                fname = f.getName(); //저장된 파일명!!!
            request.setAttribute("f_name", fname); //"f_name"을 저장해라
        } catch (Exception e) {
            e.printStackTrace();
        }


        return "admin/adminSaveImg.jsp";
    }
}
