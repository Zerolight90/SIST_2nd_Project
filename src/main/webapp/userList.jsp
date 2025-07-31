<%@ page import="util.Paging" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="./css/admin.css">
  <link rel="stylesheet" href="./css/userList.css">
</head>
<body style="margin: auto">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="/admin.jsp"/>
  </div>
  <div class="adminContent">

    <div class="userList">
      <table>
        <caption>게시판 목록</caption>
        <thead>
        <tr class="title">
          <th class="no">번호</th>
          <th class="name">이름</th>
          <th class="id">아이디</th>
          <th class="birth">생년월일</th>
          <th class="gen">성별</th>
        </tr>
        </thead>

        <!-- DB의 회원정보가 보여지는 영역  -->
        <tbody>

        </tbody>


        <tfoot>
        <tr>
          <td colspan="4">
            <ol class="paging">
              <c:set var="p" value="${requestScope.page}" scope="page"/>

              <c:if test="${p.startPage < p.pagePerBlock}">
                <li class="disable">&lt;</li>
              </c:if>
              <c:if test="${p.startPage >= p.pagePerBlock}">
                <li><a href="Controller?type=list&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
              </c:if>

              <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="i">
                <c:if test="${p.nowPage == i.index}">
                  <li class="now">${i.index}</li>
                </c:if>
                <c:if test="${p.nowPage != i.index}">
                  <li><a href="Controller?type=list&cPage=${i.index}">${i.index}</a></li>
                </c:if>
              </c:forEach>

              <c:if test="${p.endPage < p.totalPage}">
                <li><a href="Controller?type=list&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li>
              </c:if>
              <c:if test="${p.endPage >= p.totalPage}">
                <li class="disable">&gt;</li>
              </c:if>

            </ol>
          </td>
        </tr>
        </tfoot>
        <tbody>
        <c:set var="ar" value="${requestScope.ar}" scope="page"/>
        <c:forEach var="vo" items="${ar}" varStatus="i">
          <c:set var="num" value="${p.totalCount-((p.nowPage-1)*p.numPerPage+i.index)}"/>
          <tr>
            <td>${num}</td>
            <td style="text-align: left">
              <a href="Controller?type=view&b_idx=${vo.b_idx}&cPage=${nowPage}">
                  ${vo.subject}
                <c:if test="${vo.c_list != null && fn:length(vo.c_list) > 0}">
                  (<c:out value="${vo.c_list}"/>)
                </c:if>
              </a></td>
            <td>${vo.writer}</td>
            <td>${vo.write_date}</td>
            <td>${vo.hit}</td>
          </tr>
        </c:forEach>

        </tbody>
      </table>

    </div>
  </div>
</div>
</body>
</html>