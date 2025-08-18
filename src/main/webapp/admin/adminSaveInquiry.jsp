<%@ page contentType="text/html;charset=UTF-8" language="java" %>
{
"parent_boardIdx":"<%=request.getAttribute("parent_boardIdx")%>",
"answerContent":"<%=request.getAttribute("content")%>",
"success":"<%=request.getAttribute("success")%>",
"message":"<%=request.getAttribute("message")%>"
}