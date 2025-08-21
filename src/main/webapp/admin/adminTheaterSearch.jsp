<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="p" value="${requestScope.page}" scope="page"/>
<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <c:set var="num" value="${p.totalCount - ((p.nowPage-1)*p.numPerPage+ vs1.index)}"/>
    <td>${num}</td>
    <td>${vo.tName}</td>
    <td>${vo.tRegion}</td>
    <c:if test="${vo.tStatus == 0}">
      <td>운영종료</td>
    </c:if>
    <c:if test="${vo.tStatus == 1}">
      <td>운영중</td>
    </c:if>
    <td>${vo.tRegDate}</td>
  </tr>
</c:forEach>