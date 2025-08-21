<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.paymentIdx}</td>
    <td>${vo.name}</td>

    <c:if test="${vo.paymentType == 0}">
      <td>영화</td>
    </c:if>
    <c:if test="${vo.paymentType == 1}">
      <td>상품</td>
    </c:if>

    <td>${vo.paymentMethod}</td>
    <td>${vo.paymentFinal}원</td>

    <c:if test="${vo.paymentStatus == 0}">
      <td>완료</td>
    </c:if>
    <c:if test="${vo.paymentStatus == 1}">
      <td>취소</td>
    </c:if>

    <td><fmt:formatDate value="${vo.paymentDate}" pattern="yyyy-MM-dd"/></td>
  </tr>
</c:forEach>