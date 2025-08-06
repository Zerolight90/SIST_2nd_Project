<%@ page import="mybatis.dao.MemberDAO" %>
<%@ page import="org.json.simple.JSONObject" %>

<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    boolean isDuplicate = (boolean)request.getAttribute("chk");

    JSONObject json = new JSONObject();
    json.put("isDuplicate", isDuplicate);

    out.print(json.toJSONString());
%>
  