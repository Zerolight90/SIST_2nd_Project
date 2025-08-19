<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.adminIdx}</td>
    <td>${vo.adminId}</td>
    <td>${vo.adminLevel}</td>

    <c:if test="${vo.adminstatus == 0}">
      <td><span class="status-badge status-dormant">정지</span></td>
    </c:if>
    <c:if test="${vo.adminstatus == 1}">
      <td><span class="status-badge status-dormant">활성</span></td>
    </c:if>
  </tr>
</c:forEach>