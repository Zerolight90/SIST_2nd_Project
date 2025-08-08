<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr id="userTr" data-user-idx="${vo.userIdx}"> <%-- id는 고유해야 하므로 class로 바꾸거나 data 속성 사용 권장 --%>
    <td>${vo.userIdx}</td>
    <td>${vo.name}</td>
    <td>${vo.id}</td>
    <td>${vo.email}</td>
    <td>${vo.phone}</td>
    <td>${vo.totalPoints}</td>
    <c:if test="${vo.status == 0}">
      <td><span class="status-badge status-active">활성</span></td>
    </c:if>
    <c:if test="${vo.status == 1}">
      <td><span class="status-badge status-dormant">탈퇴</span></td>
    </c:if>
  </tr>
</c:forEach>