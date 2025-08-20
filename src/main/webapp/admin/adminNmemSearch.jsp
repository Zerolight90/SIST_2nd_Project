<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--관리자가 비회원을 검색할 때 교체할 tr 태그 반복문--%>

<c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
  <tr>
    <td>${vo.nIdx}</td>
    <td>${vo.name}</td>
    <td>${vo.email}</td>
    <td>${vo.joinDate}</td>
  </tr>
</c:forEach>