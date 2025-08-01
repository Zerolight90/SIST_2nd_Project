<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/productadd.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body style="margin: auto">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
    <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
    <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
        <a href="Controller?typ=index">SIST</a>
        <a href="">로그아웃</a>
    </div>
</div>

<div class="dashBody">
    <div class="dashLeft">
        <jsp:include page="/admin.jsp"/>
    </div>
    <div class="adminContent">
        <div style="margin-left: 20px">
            <div class="producthead">
                <div>
                    <h2>상품 목록</h2>
                </div>
                <div>
                    <div class="button" onclick="addDialog()">새 상품 추가</div>
                </div>
            </div>
            <div>
                <table id="table">
                    <caption>상품 목록</caption>
                    <tbody>
                    <tr>
                        <td>상품번호</td>
                        <td>카테고리</td>
                        <td>상품명</td>
                        <td>상품설명</td>
                        <td>이미지</td>
                        <td>가격</td>
                        <td>재고</td>
                        <td>상품상태</td>
                        <td>관리</td>
                    </tr>

                    <!-- db의 상품 idx만큼 반복문으로 작업 -->
                    <tr>
                        <td>${vo.idx}</td>
                        <td>
                            <select name="category" id="category">
                                <!-- 반복문 돌면서 카테고리 출력 -->
                                <option value="${vo.category}">
                                    ${vo.category}
                                </option>
                            </select>
                        </td>
                        <td>${vo.id}</td>
                        <td>${vo.email}</td>
                        <td>
                            ${vo.phone}
                            ${vo.img}
                        </td>
                        <td>${vo.point}</td>
                        <td></td>
                        <td>
                            <select name="status" id="status">
                                <option value="${vo.stock}">
                                    ${vo.stock}
                                </option>
                            </select>
                        </td>
                        <td>
                            <div class="button" onclick="cerDialog()">수정</div>
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="addDialog" title="새 상품 추가">
    <form name="addForm" id="addForm">
        <table>
            <caption></caption>
            <tr>
                <td>카테고리:</td>
                <td>
                    <select name="category" id="category">
                        <option value="${vo.stock}">
                            ${vo.stock}
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품 이름:</td>
                <td>
                    <label id></label>
                </td>
            </tr>
            <tr>
                <td>상품 설명:</td>
                <td></td>
            </tr>
            <tr>
                <td>가격:</td>
                <td></td>
            </tr>
            <tr>
                <td>재고:</td>
                <td></td>
            </tr>
            <tr>
                <td>상품 이미지:</td>
                <td></td>
            </tr>
            <tr>
                <td>상품 상태:</td>
                <td>
                    <select name="status" id="status">
                        <option value="${vo.stock}">
                            ${vo.stock}
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="button">상품 추가</div>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="cerDialog" title="상품 수정">
    <form name="cerForm" id="cerForm">
        <table>
            <caption></caption>
            <tr>
                <td>카테고리:</td>
                <td>
                    <select>
                        <option value="${vo.stock}">
                            ${vo.stock}
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품 이름:</td>
                <td></td>
            </tr>
            <tr>
                <td>상품 설명:</td>
                <td></td>
            </tr>
            <tr>
                <td>가격:</td>
                <td></td>
            </tr>
            <tr>
                <td>재고:</td>
                <td></td>
            </tr>
            <tr>
                <td>상품 이미지:</td>
                <td></td>
            </tr>
            <tr>
                <td>상품 상태:</td>
                <td>
                    <select>
                        <option value="${vo.stock}">
                            ${vo.stock}
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="button">상품 추가</div>
                </td>
            </tr>
        </table>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    function addDialog() {
        $("#addDialog").dialog({
           width: 500,
           height: 500
        });
    }
    function cerDialog() {
        $("#cerDialog").dialog({
            width: 500,
            height: 500
        });
    }
</script>
</body>
</html>
