<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
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
          <div style="margin-left: 20px">
              <div>
                  <h2>회원 목록</h2>
              </div>
              <div>
                  <div>전체 130건</div>
                  <div>
                      <span>가입월:</span>
                      jqueryui
                      <select>
                          <option>사용자 상태 (전체)</option>
                      </select>
                      <select>회원 등급 (전체)</select>
                      <select>
                          검색 대상 (전체)
                      </select>
                      <input type="text">
                      <a href="#">초기화</a>
                  </div>
              </div>
              <div>
                  <table border="1" style="border-collapse: collapse; border-top: 2px solid #000000; width: 700px">
                      <caption></caption>
                      <tbody>
                        <tr>
                            <td>번호</td>
                            <td>이름</td>
                            <td>아이디</td>
                            <td>이메일</td>
                            <td>전화번호</td>
                            <td>보유 포인트</td>
                            <td>등급</td>
                            <td>상태</td>
                        </tr>

                        <tr>
                            <%--<td>${vo.idx}</td>
                            <td>${vo.name}</td>
                            <td>${vo.id}</td>
                            <td>${vo.email}</td>
                            <td>${vo.phone}</td>
                            <td>${vo.point}</td>
                            <td>${vo.class}</td>
                            <td>${vo.status}</td>--%>
                        </tr>

                      </tbody>
                  </table>
              </div>
              <div></div>
          </div>
      </div>
  </div>
</body>
</html>
