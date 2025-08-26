<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>


<header>
    <jsp:include page="common/sub_menu.jsp"/>
</header>

<div>
    <div class="topBox">
        <div class="theaterTopBox">
            <div class="location">
                <span>Home</span>
                &nbsp;>&nbsp;
                <span>고객센터</span>
                >
                <a href="Controller?type=userBoardList">공지사항</a>
            </div>
        </div>
    </div>

    <div class="inner-wrap">
        <div class="container">
            <aside class="aside">
                <jsp:include page="/customer_center.jsp"/>
            </aside>


            <div class="page-content">
                <!-- 상단 탭 -->
                <div class="page-title">
                    <h2 class="tit">공지사항</h2>
                </div>
                <c:if test="${requestScope.vo ne null}">
                    <c:set var="vo" value="${requestScope.vo}"/>
                    <c:set var="prevVo" value="${requestScope.prevVo}"/>
                    <c:set var="nextVo" value="${requestScope.nextVo}"/>
                    <form method="post">
                        <!-- 3. 공지사항 테이블 -->
                        <table class="board-table">
                            <caption>공지사항 상세보기</caption>
                            <tbody>
                            <tr>
                                <th class="w100"><label for="boardTitle">제목</label></th>
                                <td>
                                        ${vo.boardTitle}
                                </td>
                            </tr>
                            <tr>
                                <th class="w100">지점명</th>
                                <td>
                                        ${vo.tvo.tName}
                                </td>
                            </tr>
                            <tr>
                                <th class="w100"><label for="board_reg_date">게시일</label></th>
                                <td>
                                        ${vo.boardStartRegDate}
                                </td>
                            </tr>
                            <tr>
                                <th class="w100" style="width: 200px">구분</th>
                                    <%--공지/이벤트 구분--%>
                                <td>
                                    <span>공지</span>
                                </td>
                            </tr>
                            <tr>
                                <th class="w100"><label for="board_content">내용</label></th>
                                <td>
                                        ${vo.boardContent}
                                </td>
                            </tr>
                            <c:if test="${vo.file_name ne null and vo.file_name.length() > 4}">
                                <tr>
                                    <th>첨부파일</th>
                                    <td>
                                        <a href="javascript:down('${vo.file_name}')">
                                                ${vo.file_name}
                                        </a>
                                    </td>
                                </tr>
                            </c:if>

                            </tbody>
                        </table>

                    </form>
                    <%--숨겨진 폼 만들기--%>
                    <form name="ff" method="post">
                        <input type="hidden" name="type"/>
                        <input type="hidden" name="f_name"/>
                        <input type="hidden" name="boardIdx" value="${vo.boardIdx}"/>
                        <input type="hidden" name="cPage" value="${param.cPage}"/>
                    </form>
                </c:if>
                <div>
                    <table>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty nextVo}">
                                <tr>
                                    <td style="width: 200px;">다음글</td>
                                    <td>
                                        <a href="Controller?type=userViewBoard&boardIdx=${nextVo.boardIdx}&cPage=${param.cPage}&boardType=${vo.boardType}">
                                                ${nextVo.boardTitle}
                                        </a>
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td style="width: 200px;">다음글</td>
                                    <td>다음글이 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty prevVo}">
                                <tr>
                                    <td style="width: 200px;">이전글</td>
                                    <td>
                                        <a href="Controller?type=userViewBoard&boardIdx=${prevVo.boardIdx}&cPage=${param.cPage}&boardType=${vo.boardType}">
                                                ${prevVo.boardTitle}
                                        </a>
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td style="width: 200px;">이전글</td>
                                    <td>이전글이 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="mtb30 m30" style="text-align: center;">
                    <button type="button" onclick="goList()" class="list-button" value="목록">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function goList() {
        location.href="Controller?type=userBoardList&cPage=${param.cPage}";
    }
</script>

<footer>
    <jsp:include page="./common/Footer.jsp"/>
</footer>
</body>
</html>
