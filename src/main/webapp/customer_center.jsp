<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="lnb">
  <h2 class="tit">고객센터</h2>
  <ul>
    <li <c:if test="${param.type eq 'userBoardList' or param.type eq 'userViewBoard'}">class="on"</c:if>><a href="Controller?type=userBoardList">공지사항</a></li>
    <li <c:if test="${param.type eq 'userFaqList'}">class="on"</c:if>><a href="Controller?type=userFaqList">자주 묻는 질문</a></li>
    <li <c:if test="${param.type eq 'userInquiryWrite'}">class="on"</c:if>>
      <a href="
        <c:choose>
          <c:when test="${empty sessionScope.mvo && empty sessionScope.kvo && empty sessionScope.nmemvo}">
            Controller?type=login&userInquiryWrite=userInquiryWrite
          </c:when>
          <c:otherwise>
            Controller?type=userInquiryWrite
          </c:otherwise>
        </c:choose>
      ">1:1 문의</a></li>
  </ul>
</nav>


