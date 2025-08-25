<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader ("Expires", 0); // Proxies
%>
<c:if test="${empty sessionScope.vo}">
    <c:redirect url="Controller?type=index"/>
</c:if>

<html>
<head>
    <title>관리자 - 상품 목록</title>
    <%-- 외부 CSS 파일 링크 --%>
    <link rel="stylesheet" href="../css/admin.css">
    <%-- jQuery UI CSS --%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

    <%-- 이 페이지에만 적용될 스타일 --%>
    <style>
        body {
            margin: 0; /* body의 모든 바깥 여백을 제거합니다. */
        }

        /* --- 전체 레이아웃 --- */
        .adminContent {
            width: 1200px;
            margin: 0 auto;
            padding: 20px 30px;
            border: none;
        }

        /* --- 페이지 상단 (제목 + 버튼) --- */
        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 50px;
            margin: 30px 0;
            border-bottom: 2px solid #333;
        }
        .product-header h2 {
            margin: 0;
            font-size: 34px;
        }
        .product-header .btn-add {
            background-color: #007bff;
            color: white;
            padding: 8px 20px;
            border-radius: 5px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            border: none;
        }
        .product-header .btn-add:hover {
            background-color: #0056b3;
        }

        /* --- 상품 목록 테이블 --- */
        .product-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            text-align: center;
        }
        .product-table thead {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }
        .product-table th,
        .product-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle; /* 내용물 세로 중앙 정렬 */
        }
        .product-table td {
            color: #555;
        }
        .product-table .align-left {
            text-align: left;
        }

        /* 테이블 내 이미지 스타일 */
        .product-table .product-image {
            max-width: 100px;
            height: auto;
            border: 1px solid #eee;
            border-radius: 4px;
        }

        /* 테이블 내 select 박스 스타일 */
        .product-table select {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
        }

        /* 테이블 내 수정 버튼 스타일 */
        .product-table .btn-edit {
            background-color: #17a2b8;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 13px;
            cursor: pointer;
            border: none;
        }
        .product-table .btn-edit:hover {
            background-color: #138496;
        }

        /* --- 모달 공통 스타일 --- */
        #productAddModal, #productCerModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border: 1px solid #ccc;
            z-index: 1000;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            border-radius: 8px;
            overflow: hidden;
            width: 500px;
        }
        .modalTitle {
            background-color: #20c997;
            color: white;
            padding: 15px 20px;
            font-size: 18px;
            font-weight: bold;
        }
        .modalTitle h2 { margin: 0; }
        .body { padding: 25px 20px; }
        .divs { display: flex; align-items: center; margin-bottom: 15px; }
        .divs label { width: 100px; font-weight: bold; text-align: right; padding-right: 15px; flex-shrink: 0; }
        .divs .input { width: 100%; height: 36px; padding: 0 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .divs .input.editable { background-color: #fff; }
        .footer { padding: 20px; text-align: center; border-top: 1px solid #eee; background-color: #f8f9fa; }
        .footer .btn { padding: 10px 30px; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; cursor: pointer; margin: 0 5px; }
        .footer .btnMain { background-color: #007bff; color: white; }
        .footer .btnSub { background-color: #6c757d; color: white; }
    </style>
</head>
<body>
<!-- 관리자 화면 상단 헤더 -->
<div class="dashHead bold">
    <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">${sessionScope.vo.adminId} 관리자님</p></div>
    <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
        <a href="">SIST</a>
        <a href="Controller?type=adminLogOut">로그아웃</a>
    </div>
</div>

<div class="dashBody">
    <!-- 왼쪽 사이드 메뉴 -->
    <div class="dashLeft">
        <jsp:include page="admin.jsp"/>
    </div>

    <!-- 오른쪽 메인 콘텐츠 -->
    <div class="admin-container">
        <div class="product-header">
            <h2>상품 목록</h2>
            <a href="#" class="btn-add" onclick="addModal()">새 상품 추가</a>
        </div>

        <table class="product-table">
            <thead>
            <tr>
                <th>상품 ID</th>
                <th>카테고리</th>
                <th>상품명</th>
                <th>상품설명</th>
                <th>상품이미지</th>
                <th>가격</th>
                <th>재고</th>
                <th>상품상태</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
                    <tr>
                        <td>${vo.prodIdx}</td>
                        <td>
                            <c:if test="${vo.prodCategory == 1}">
                                <%--<select name="category">
                                    <option value="goods" selected>음식</option>
                                    <option value="ticket">관람권</option>
                                </select>--%>
                                음식
                            </c:if>
                            <c:if test="${vo.prodCategory == 2}">
                                <%--<select name="category">
                                    <option value="goods">음식</option>
                                    <option value="ticket" selected>관람권</option>
                                </select>--%>
                                관람권
                            </c:if>
                        </td>
                        <td class="align-left">${vo.prodName}</td>
                        <td class="align-left">${vo.prodInfo}</td>
                        <td>
                            <img src="../images/store/${vo.prodImg}" alt="avatar_poster.jpg" class="product-image">
                        </td>
                        <td><fmt:formatNumber value="${vo.prodPrice}" type="number" pattern="#,###"/>&nbsp;원</td>
                        <td>${vo.prodStock}&nbsp;개</td>
                        <td>
                            <c:if test="${vo.prodStatus == 0}">
                                <%--<select name="status">
                                    <option value="sale" selected>판매중</option>
                                    <option value="soldout">품절</option>
                                </select>--%>
                                판매중
                            </c:if>
                            <c:if test="${vo.prodStatus == 1}">
                                <%--<select name="status">
                                    <option value="sale">판매중</option>
                                    <option value="soldout" selected>품절</option>
                                </select>--%>
                                품절
                            </c:if>
                        </td>
                        <td>
                            <button type="button" class="btn-edit"
                                    data-idx="${vo.prodIdx}"
                                    data-category="${vo.prodCategory}"
                                    data-name="${vo.prodName}"
                                    data-info="${vo.prodInfo}"
                                    data-img="${vo.prodImg}"
                                    data-price="${vo.prodPrice}"
                                    data-stock="${vo.prodStock}"
                                    data-status="${vo.prodStatus}"
                                    onclick="cerModal(this)">수정
                            </button>

                            <form action="Controller?type=productDelete" method="post" style="display:inline;">
                                <input type="hidden" name="prodIdx" value="${vo.prodIdx}">
                                <button type="submit" class="btn-edit" style="background-color:#f44336;">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 상품 추가 모달 -->
<div id="productAddModal">
    <div class="modalTitle"><h2>상품 추가</h2></div>
    <form action="Controller?type=productAdd" method="post" id="productAddForm">
        <div class="body">
            <div class="divs">
                <label for="addCategory">카테고리:</label>
                <select name="addCategory" id="addCategory" class="input">
                    <option value="1">음식</option>
                    <option value="2">관람권</option>
                </select>
            </div>
            <div class="divs">
                <label for="addProductName">상품명:</label>
                <input type="text" name="addProductName" id="addProductName" class="input editable" required>
            </div>
            <div class="divs">
                <label for="addDescription">상품설명:</label>
                <input type="text" name="addDescription" id="addDescription" class="input editable" required>
            </div>
            <div class="divs">
                <label for="addImg">이미지:</label>
                <input type="text" name="addImg" id="addImg" class="input editable">
            </div>
            <div class="divs">
                <label for="addPrice">가격:</label>
                <input type="number" name="addPrice" id="addPrice" class="input editable" required>
            </div>
            <div class="divs">
                <label for="addStock">재고:</label>
                <input type="number" name="addStock" id="addStock" class="input editable" required>
            </div>
        </div>
        <div class="footer">
            <button type="button" class="btn btnMain">추가</button>
            <button type="button" class="btn btnSub">취소</button>
        </div>
    </form>
</div>

<!-- 상품 수정 모달 -->
<div id="productCerModal">
    <c:set var="vo" value="${requestScope.ar}"/>
    <div class="modalTitle"><h2>상품 수정</h2></div>
    <form action="Controller?type=productCer" method="post" id="productCerForm">
        <div class="body">
            <div class="divs">
                <label for="cerCategory">카테고리:</label>
                <select name="cerCategory" id="cerCategory" class="input">
                    <option value="1">음식</option>
                    <option value="2">관람권</option>
                </select>
            </div>
            <div class="divs">
                <label for="cerProductName">상품명:</label>
                <input type="text" name="cerProductName" id="cerProductName" class="input editable" value="" required>
            </div>
            <div class="divs">
                <label for="cerDescription">상품설명:</label>
                <input type="text" name="cerDescription" id="cerDescription" class="input editable" required>
            </div>
            <div class="divs">
                <label for="cerImg">이미지:</label>
                <input type="text" name="cerImg" id="cerImg" class="input editable">
            </div>
            <div class="divs">
                <label for="cerPrice">가격:</label>
                <input type="number" name="cerPrice" id="cerPrice" class="input editable" required>
            </div>
            <div class="divs">
                <label for="cerStock">재고:</label>
                <input type="number" name="cerStock" id="cerStock" class="input editable" required>
            </div>
            <div class="divs">
                <%--<label for="cerStatus">상품 상태:</label>
                <input type="number" name="cerStatus" id="cerStatus" class="input editable" required>--%>

                <label for="cerStatus">상품 상태:</label>
                <select name="cerStatus" id="cerStatus" class="input">
                    <option value="0">판매중</option>
                    <option value="1">품절</option>
                </select>
            </div>
            <input type="hidden" id="pidx" name="pidx" value="">
        </div>
        <div class="footer">
            <button type="button" id="edit" class="btn btnMain">수정</button>
            <button type="button" class="btn btnSub">취소</button>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    $(document).ready(function () {
        // 모달의 취소 버튼 클릭 시
        $(".btnSub").on("click", function () {
            // 가장 가까운 모달 div를 찾아서 숨기기
            $(this).closest("#productAddModal, #productCerModal").hide();
        });
    });

    // 새 상품 추가 버튼 클릭 시
    function addModal() {
        $("#productAddModal").show();
    }
    // 수정 버튼 클릭 시
    function cerModal(str) {
        let prodIdx = $(str).data('idx');
        let prodCategory = $(str).data('category');
        let prodName = $(str).data('name');
        let prodInfo = $(str).data('info');
        let prodImg = $(str).data('img');
        let prodPrice = $(str).data('price');
        let prodStock = $(str).data('stock');
        let prodStatus = $(str).data('status');

        // 3. 가져온 값들을 수정 모달(#productCerModal) 안의 각 input에 채워 넣습니다.
        $("#pidx").val(prodIdx);
        $("#productCerModal").find("#cerCategory").val(prodCategory);
        $("#productCerModal").find("#cerProductName").val(prodName);
        $("#productCerModal").find("#cerDescription").val(prodInfo);
        $("#productCerModal").find("#cerImg").val(prodImg);
        $("#productCerModal").find("#cerPrice").val(prodPrice);
        $("#productCerModal").find("#cerStock").val(prodStock);
        $("#productCerModal").find("#cerStatus").val(prodStatus);

        // 4. 데이터가 채워진 모달 창을 보여줍니다.
        $("#productCerModal").show();

        /*// 여기에 수정할 상품의 데이터를 가져와서 모달 폼에 채워넣는 로직이 필요 !
        let prodIdx = $(button).data('idx');
        let prodCategory = $(button).data('category');
        let prodName = $(button).data('name');
        let prodInfo = $(button).data('info');
        let prodImg = $(button).data('img');
        let prodPrice = $(button).data('price');
        let prodStock = $(button).data('stock');

        $("#cerCategory").val(prodCategory);
        $("#cerProductName").val(prodName);
        $("#cerDescription").val(prodInfo);
        $("#cerImg").val(prodImg);
        $("#cerPrice").val(prodPrice);
        $("#cerStock").val(prodStock);

        $("#productCerModal").show();*/
    }

    $(function () {
        $("#productAddModal .btnMain").on('click', function () {
            $("#productAddForm").submit();
        })

        $("#edit").on('click', function () {
            $("#productCerForm").submit();
        })
    })
</script>
</body>
</html>
