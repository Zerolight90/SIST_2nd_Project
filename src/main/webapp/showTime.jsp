<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="showTime" value="${requestScope.showTime}" scope="page"/>
<c:forEach var="tvo" items="${showTime}" varStatus="i">
    <c:if test="${tvo.m_list != null && fn:length(tvo.m_list) > 0}">
        <c:forEach var="movieVO" items="${tvo.m_list}" varStatus="i">
            <div class="show_all">
                <button type="button" onclick="goSeat(this.nextElementSibling.value)">${movieVO.name}</button>
                <button>
                    <span></span>
                    <span></span>
                    <div>
                        <span></span>
                        <span>매진</span>
                    </div>
                </button>
                <input type="hidden" value="${tvo.tIdx}"/>
            </div>
            <hr/>
        </c:forEach>
    </c:if>
</c:forEach>