<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    // Action에서 설정한 속성 "chk"를 가져옴
    boolean isMatch = (boolean)request.getAttribute("chk");

    JSONObject json = new JSONObject();
    // 클라이언트가 isDuplicate 대신 "match"와 같이 더 명확한 이름으로 받도록 변경하는 것이 좋습니다.
    json.put("match", isMatch);

    out.print(json.toJSONString());
%>
