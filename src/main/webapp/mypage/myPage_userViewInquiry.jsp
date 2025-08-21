<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1문의내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

    <style>

        .inner-wrap .mt30{
            margin-top: 30px;
        }

        .mt10{
            margin-top: 10px;
        }

        .inquiry-view .tit-area {
            padding: 15px 0;
        }


        .content-info{
            font-size: 13px;
        }

        .inquiry-view .info {
            font-size: .9333em;
            display: flex; /* flexbox를 사용하여 자식 요소들을 가로로 배열 */
        }

        .table-wrap {
            border-top: 1px solid #1a1a1a;
        }

        .inquiry-view .info p {
            position: relative;
            display: inline-block;
            vertical-align: top;
            margin: 0 0 0 8px;
            padding: 0 0 0 11px;
        }

        .inquiry-view .review {
            padding: 20px 30px;
            border-bottom: 1px solid #eaeaea;
            background: url(https://img.megabox.co.kr/static/pc/images/common/bg/bg-review.png) no-repeat 10px 20px;
        }

        .inquiry-view .board-content {
            overflow: hidden;
            width: 100%;
            padding: 20px 35px;
            border-top: 1px solid #eaeaea;
        }

        /*삭제 버튼 추가시*/
        .btn-group {
            padding: 20px 0 30px 0;
            margin: 0;
            text-align: center;
            padding-top: 40px !important;
        }

        .inquiry-view .tit-area .title span{
            display: table-cell;
            margin: 0;
            padding: 0;
            font-size: 1.1429em;
            font-weight: bold;
        }

        .inquiry-view .info div .tit {
            position: relative;
            margin-right: 3px;
            color: #444;
            font-weight: 400;
        }

        .inquiry-view .info div .txt{
            display: inline-block;
            vertical-align: top;
            color: #666;
            margin-right: 10px;
        }

        .inquiry-view .info p:before {
            content: '';
            position: absolute;
            top: 4px;
            left: 0;
            width: 1px;
            height: 12px;
            background-color: #d9d9db;
        }

        .inquiry-view .info p {
            position: relative;
            display: inline-block;
            vertical-align: top;
            margin: 0 0 0 8px;
            padding: 0 0 0 11px;
        }

        .board-content{
            border-top: 1px solid #888;
            margin-top: 40px;
        }

        .tit-area .mt10 .txt{
            color: #666;
            font-size: .9333em;
        }

        /*구분선*/
        .inquiry-view .info > div + div {
            border-left: 1px solid #d9d9db; /* 왼쪽 테두리를 1px 회색으로 설정 */
            padding-left: 10px;            /* 왼쪽에 여백 추가 */
            margin-left: 10px;             /* 구분선과 왼쪽 요소 사이에 여백 추가 */
        }

        .goListBtn {
            /* 버튼 기본 스타일 */
            background-color: #fff;
            color: #503396; /* 보라색 글자 */
            border: 1px solid #503396; /* 보라색 테두리 */
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        /* 마우스 호버 시 스타일 */
        .goListBtn:hover {
            background-color: #f1e9ff; /* 연한 보라색 배경 */
        }



    </style>
</head>
<body>
<h2 class="content-title">나의 문의내역</h2>
<div class="content-info">고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.</div>
<div class="inner-wrap">
    <div>


        <div class="table-wrap mt30">
            <c:if test="${requestScope.vo ne null}">
                <c:set var="vo" value="${requestScope.vo}"/>
            </c:if>

            <div class="inquiry-view">
                <div class="tit-area">
                    <div class="title">
                        <span>${vo.boardTitle}</span>
                    </div>
                    <div class="info">
                        <div>
                            <span class="tit">문의지점</span>
                            <span class="txt">서울 - 센터</span>
                        </div>
                        <div>
                            <span class="tit">답변상태</span>
                            <span class="txt">
                                <c:choose>
                                    <c:when test="${vo.is_answered == 0}">
                                        <div class="status-unanswered">미답변</div>
                                    </c:when>
                                    <c:when test="${vo.is_answered == 1}">
                                        <div class="status-available">답변완료</div>
                                    </c:when>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="mt10">
                        <span class="txt">${vo.boardRegDate}</span>
                    </div>

                    <div class="board-content">
                        <p>${vo.boardContent}</p>
                    </div>

                    <c:if test="${vo.bvo != null && not empty vo.bvo}">
                        <div class="board-content review" id="inqReplyCn">
                                ${vo.bvo.boardContent}
                        </div>
                    </c:if>
                </div>

                <div style="text-align: center;">
                    <button type="button" class="goListBtn" onclick="location.href='Controller?type=myPage&tab=myPrivateinquiry'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>