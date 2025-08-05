<%@ page import="mybatis.dao.MemberDAO" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("u_id");
    boolean isDuplicate = MemberDAO.idCheck(id); // DB에서 아이디 중복 여부 확인

    JSONObject json = new JSONObject();
    json.put("isDuplicate", isDuplicate); // 중복 여부를 boolean 값으로 저장

    out.print(json.toJSONString()); // JSON 문자열로 출력
%>
