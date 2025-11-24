<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--관리자가 영화를 검색할 때 교체할 tr 태그 반복문--%>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr class="movieTr" data-idx="${vo.mIdx}">
    <td>${vo.mIdx}</td>
    <td>${vo.name}</td>
    <td>${vo.dir}</td>
    <td>${vo.runtime}&nbsp;분</td>

    <c:choose>
      <c:when test="${vo.age == '12' || vo.age == '15' || vo.age == '19'}">
        <td>${vo.age}세 이용가</td>
      </c:when>
      <c:when test="${vo.age == 'ALL'}">
        <td>전체 이용가</td>
      </c:when>
      <c:otherwise>
        <td>${vo.age}</td>
      </c:otherwise>
    </c:choose>

    <td>${vo.date}</td>

    <c:if test="${vo.audNum == null}">
      <td>0&nbsp;명</td>
    </c:if>
    <c:if test="${vo.audNum != null}">
      <td>${vo.audNum}&nbsp;명</td>
    </c:if>
  </tr>
</c:forEach>