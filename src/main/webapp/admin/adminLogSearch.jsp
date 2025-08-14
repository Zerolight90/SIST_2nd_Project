<<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.logIdx}</td>
    <td>${vo.logType}</td>
    <td>${vo.adminId}</td>
    <td>${vo.logTarget}</td>
    <td>${vo.logInfo}</td>
    <td>${vo.logPerValue}</td>
    <td>${vo.logCurValue}</td>
    <td>${vo.logDate}</td>
  </tr>
</c:forEach>
