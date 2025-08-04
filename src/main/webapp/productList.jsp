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
        <jsp:include page="admin/admin.jsp"/>
    </div>
    <div class="adminContent">
        <div style="margin-left: 20px">
            <div class="producthead">
                <div>
                    <h2>상품 목록</h2>
                </div>
                <div>
                    <div class="button" onclick="addModal()">새 상품 추가</div>
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
                            <div class="button" onclick="cerModal()">수정</div>
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 상품 추가 모달 -->
<div id="productAddModal">
    <div class="modalTitle"><h2>새 상품 추가</h2></div>

    <form action="Controller?type=productAdd" method="post" id="productAddForm">
        <div class="body">
            <div class="divs">
                <label for="addCategory">카테고리:</label>
                <select name="addCategory" id="addCategory">
                    <c:forEach var="category" items="${categoryList}">
                        <option value="${category.value}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="divs">
                <label for="productName">상품명:</label>
                <input type="text" name="addProductName" id="addProductName" class="input editable" required>
            </div>
            <div class="divs">
                <label for="description">상품설명:</label>
                <input type="text" name="addDescription" id="addDescription" class="input editable" required>
            </div>
            <div class="divs">
                <label for="img">이미지:</label>
                <input type="text" name="addImg" id="addImg" class="input editable">
            </div>
            <div class="divs">
                <label for="price">가격:</label>
                <input type="number" name="addPrice" id="addPrice" class="input editable" required>
            </div>
            <div class="divs">
                <label for="stock">재고:</label>
                <input type="number" name="addStock" id="addStock" class="input editable" required>
            </div>
            <div class="divs">
                <label for="status">상품상태:</label>
                <input type="text" name="addStatus" id="addStatus" class="input" readonly value="정상">
            </div>
        </div>

        <div class="footer">
            <button type="submit" class="btn btnMain">추가</button>
            <button type="button" class="btn btnSub">취소</button>
        </div>
    </form>
</div>

<!-- 상품 수정 모달 -->
<div id="productCerModal">
    <div class="modalTitle"><h2>상품 수정</h2></div>

    <form action="Controller?type=productCer" method="post" id="productCerForm">
        <div class="body">
            <div class="divs">
                <label for="CerCategory">카테고리:</label>
                <select name="cerCategory" id="cerCategory">
                    <c:forEach var="category" items="${categoryList}">
                        <option value="${category.value}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="divs">
                <label for="productName">상품명:</label>
                <input type="text" name="cerProductName" id="cerProductName" class="input editable" required>
            </div>
            <div class="divs">
                <label for="description">상품설명:</label>
                <input type="text" name="cerDescription" id="cerDescription" class="input editable" required>
            </div>
            <div class="divs">
                <label for="img">이미지:</label>
                <input type="text" name="cerImg" id="cerImg" class="input editable">
            </div>
            <div class="divs">
                <label for="price">가격:</label>
                <input type="number" name="cerPrice" id="cerPrice" class="input editable" required>
            </div>
            <div class="divs">
                <label for="stock">재고:</label>
                <input type="number" name="cerStock" id="cerStock" class="input editable" required>
            </div>
            <div class="divs">
                <label for="status">상품상태:</label>
                <input type="text" name="csrStatus" id="csrStatus" class="input" readonly value="정상">
            </div>
        </div>

        <div class="footer">
            <button type="submit" class="btn btnMain">수정</button>
            <button type="button" class="btn btnSub">취소</button>
        </div>
    </form>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>

    $(document).ready(function () {
        $(".btnSub").on("click", function () {
            if($("#productAddModal").fadeIn()){
                $("#productAddModal").hide();
            }
            if($("#productCerModal").fadeIn()){
                $("#productCerModal").hide();
            }
        });
    });

    function addModal() {
        console.log("addModal 실행됨");
        $("#productAddModal").show();
    }
    function cerModal() {
        console.log("cerModal 실행됨");
        $("#productCerModal").show();
    }
</script>
</body>
</html>