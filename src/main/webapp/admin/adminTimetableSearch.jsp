<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.timeTableIdx}</td>
    <td>${vo.tName}</td>
    <td>${vo.sName}</td>
    <td>${vo.name}</td>
    <td>${vo.date}</td>
    <td>${vo.startTime}</td>
    <td>${vo.endTime}</td>
    <td>${vo.sSeatCount - vo.reservationCount} / ${vo.sSeatCount}</td>
  </tr>
</c:forEach>