<%@ page import="mybatis.vo.MemVO" %>
<%@ page import="mybatis.dao.MemberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //사용자가 입력하여 현재 페이지로 전달하는 아이디와 비밀번호를
    //파라미터로 받는다.
    String mId = request.getParameter("u_id");
    String mPw = request.getParameter("u_pw");

    if(mId != null && mPw != null){
        MemVO mvo = MemberDAO.login(mId, mPw);
        int mode = 0;
        if(mvo != null){
            // HttpSession에 "mvo"라는 이름으로 MemVO객체를 저장한다.
            session.setAttribute("mvo", mvo);
            mode = 1;
        }
        response.sendRedirect("index.jsp?mode="+mode);
    }else
        response.sendRedirect("index.jsp");//id와 pw가 없는경우
%>
