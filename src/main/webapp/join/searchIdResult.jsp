<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <link rel="stylesheet" href="<c:url value='/css/reset.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/join.css'/>" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <style>
        /* 간단한 모달 스타일 */
        #modalBackground {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        #modalBox {
            background: #fff;
            width: 360px;
            max-width: 90%;
            padding: 20px;
            border-radius: 6px;
            position: fixed;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            text-align: center;
        }
        .modal-close-btn {
            margin-top: 16px;
            padding: 8px 14px;
            cursor: pointer;
            border: none;
            background: #007BFF;
            color: #fff;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<!-- 결과 모달 -->
<div id="modalBackground">
    <div id="modalBox" role="dialog" aria-live="polite">
        <c:choose>
            <c:when test="${not empty foundId}">
                <p><strong><c:out value="${u_name}" /></strong>님의 아이디는</p>
                <p style="font-size:1.3em; color:#007BFF;">"<c:out value="${foundId}" />"</p>
                <p>입니다.</p>
            </c:when>
            <c:otherwise>
                <p style="color: #c0392b; font-weight:bold;">
                    <c:out value="${errorMsg != null ? errorMsg : '일치하는 회원 정보가 없습니다.'}" />
                </p>
            </c:otherwise>
        </c:choose>

        <button class="modal-close-btn" id="modalCloseBtn" type="button">닫기</button>
    </div>
</div>

<script>
    $(function(){
        // 서버에서 전달된 EL 값을 JS에서 읽어 빈값 여부로 모달 노출 판단
        var foundId = "${fn:escapeXml(foundId)}";
        var errorMsg = "${fn:escapeXml(errorMsg)}";

        // foundId 또는 errorMsg 중 하나라도 존재하면 모달을 보여줍니다.
        if ((foundId && foundId.trim() !== "") || (errorMsg && errorMsg.trim() !== "")) {
            $("#modalBackground").show();
        }

        // 닫기 버튼 동작: 모달 닫기 및 (선택) 검색 페이지로 이동
        $("#modalCloseBtn").on("click", function() {
            $("#modalBackground").hide();
            // 필요하면 검색 폼 페이지로 리다이렉트: 예) window.location.href = '/searchForm.jsp';
        });
    });
</script>

</body>
</html>
