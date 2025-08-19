<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.tRegion}</td>
    <td>${vo.tName}</td>
    <td>${vo.sName}</td>
    <td>${vo.screenCode}</td>
    <td>${vo.sCount}</td>

    <c:if test="${vo.tStatus == 0}">
      <td>운영종료</td>
    </c:if>
    <c:if test="${vo.tStatus == 1}">
      <td>운영중</td>
    </c:if>

    <c:if test="${vo.sStatus == 0}">
      <td>운영종료</td>
    </c:if>
    <c:if test="${vo.sStatus == 1}">
      <td>운영중</td>
    </c:if>
  </tr>
</c:forEach>