<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="vo" value="${requestScope.vo}"/>
<table class="adSaveInquiry">
    <tr>
        <th class="w100">제목</th>
        <td>[답변] ${vo.boardTitle}</td>
    </tr>
    <tr>
        <th class="w100">지점명</th>
        <td>${vo.tvo.tName}</td>
    </tr>
    <tr>
        <th class="w100">내용</th>
        <td>${vo.bvo.boardContent}</td>
    </tr>
    <c:if test="${vo.file_name ne null and vo.file_name.length() > 4}">
        <tr>
            <th class="w100">첨부파일:</th>
            <td>
                <input type="file" id="file" name="file"/>
            </td>
        </tr>
    </c:if>
</table>