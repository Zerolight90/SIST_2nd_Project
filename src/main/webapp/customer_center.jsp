<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="lnb">
  <h2 class="tit">고객센터</h2>
  <ul>
    <li <c:if test="${param.type eq 'userBoardList'}">class="on"</c:if>><a href="Controller?type=userBoardList">공지사항</a></li>
    <li <c:if test="${param.type eq ''}">class="on"</c:if>><a href="Controller?type=">자주 묻는 질문</a></li>
    <li <c:if test="${param.type eq 'userInquiryWrite'}">class="on"</c:if>><a href="Controller?type=userInquiryWrite">1:1 문의</a></li>
  </ul>
</nav>