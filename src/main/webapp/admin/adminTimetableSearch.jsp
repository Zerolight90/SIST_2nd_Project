<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--관리자가 상영 시간표를 검색할 때 교체할 tr 태그 반복문--%>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.timeTableIdx}</td>
    <td>${vo.tName}</td>
    <td>${vo.sName}</td>
    <td>${vo.name}</td>
    <td>${vo.date}</td>
    <td>${vo.startTime}</td>
    <td>${vo.endTime}</td>
    <td>${vo.sCount - vo.reservationCount} / ${vo.sCount}</td>
  </tr>
</c:forEach>