<%@ page import="util.Paging" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <style type="text/css">
    #bbs table {
      width:580px;
      margin-left:10px;
      border:1px solid black;
      border-collapse:collapse;
      font-size:14px;

    }

    #bbs table caption {
      font-size:20px;
      font-weight:bold;
      margin-bottom:10px;
    }

    #bbs table th,#bbs table td {
      text-align:center;
      border:1px solid black;
      padding:4px 10px;
    }

    .no {width:15%}
    .subject {width:30%}
    .writer {width:20%}
    .reg {width:20%}
    .hit {width:15%}
    .title{background:lightsteelblue}

    .odd {background:silver}

    /* paging */

    table tfoot ol.paging {
      list-style:none;
    }

    table tfoot ol.paging li {
      float:left;
      margin-right:8px;
    }

    table tfoot ol.paging li a {
      display:block;
      padding:3px 7px;
      border:1px solid #00B3DC;
      color:#2f313e;
      font-weight:bold;
    }

    table tfoot ol.paging li a:hover {
      background:#00B3DC;
      color:white;
      font-weight:bold;
    }

    .disable {
      padding:3px 7px;
      border:1px solid silver;
      color:silver;
    }

    .now {
      padding:3px 7px;
      border:1px solid #ff4aa5;
      background:#ff4aa5;
      color:white;
      font-weight:bold;
    }

  </style>
</head>
<body>
<div id="bbs">
  <table summary="게시판 목록">
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
      <td>
        <input type="button" value="글쓰기"
               onclick="javascript:location.href='Controller?type=write'"/>
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
</body>
</html>