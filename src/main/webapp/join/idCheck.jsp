<%@ page import="mybatis.dao.MemberDAO" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("u_id");
    boolean isDuplicate = MemberDAO.idCheck(id);

    JSONObject json = new JSONObject();
    json.put("isDuplicate", isDuplicate);

    out.print(json.toJSONString());
%>
  