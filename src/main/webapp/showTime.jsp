<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="showTime" value="${requestScope.showTime}" scope="page"/>
<c:forEach var="timevo" items="${showTime}" varStatus="i">
    <c:set var="screenVO" value="${timevo.s_list[0]}"/>
    <c:set var="movieVO" value="${timevo.m_list[0]}"/>
    <c:set var="theaterVO" value="${timevo.t_list[0]}"/>
<%--    <c:set var="reservationVO" value="${timevo.r_list[0]}"/>--%>
    <c:if test="${timevo.m_list != null && fn:length(timevo.m_list) > 0}">
            <div class="show_all">
                <button type="button" onclick="goSeat(this.nextElementSibling.value)">
                    <span class="time_area">
                        <strong class="disBlock">${fn:substring(timevo.startTime, 10, 16)}</strong>
                        <span>~${fn:substring(timevo.endTime, 10, 16)}</span>
                    </span>
                    <span class="movie_area">
                        <strong>${movieVO.name}</strong>
                        <span>${screenVO.screenCode}</span>
                    </span>
                    <span class="seat_area">
                        <span class="disBlock">${theaterVO.tName}</span>
                        <span>
                            ${screenVO.sName}
                            <!-- 예약된 좌석 / 전체좌석 -->
                            (${fn:length(timevo.r_list)} /
                            ${screenVO.sCount})
                        </span>
                    </span>
                </button>
                <input type="hidden" value="${timevo.timeTableIdx}">
            </div>
            <hr/>
    </c:if>
    <c:if test="${timevo.m_list == null}">
        m_list null
    </c:if>
</c:forEach>