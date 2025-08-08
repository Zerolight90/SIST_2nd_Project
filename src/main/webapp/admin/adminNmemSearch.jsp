<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.nIdx}</td>
    <td>${vo.name}</td>
    <td>${vo.email}</td>
    <td>${vo.regDate}</td>
  </tr>
</c:forEach>