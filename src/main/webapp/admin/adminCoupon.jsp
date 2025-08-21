<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    /*#productAddModal{
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
    }*/
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

    .no-titlebar .ui-dialog-titlebar {
      display: none;
    }
  </style>
</head>
<body>
<!-- 관리자 화면 상단 헤더 -->
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">${sessionScope.vo.adminId} 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="Controller?type=index">로그아웃</a>
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
      <h2>쿠폰 목록</h2>
      <div>
        <a href="#" class="btn-add" onclick="giveModal()">쿠폰 발급</a>
        <a href="#" class="btn-add" onclick="addModal()">새 쿠폰 등록</a>
      </div>
    </div>

    <table class="product-table">
      <thead>
      <tr>
        <th>쿠폰명</th>
        <th>쿠폰정보</th>
        <th>쿠폰타입</th>
        <th>할인가격</th>
        <th>쿠폰 발급일</th>
        <th>쿠폰 만료일</th>
        <th>쿠폰 상태</th>
        <th>쿠폰 관리</th>
      </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
          <tr>
            <td>${vo.couponName}</td>
            <td>${vo.couponInfo}</td>
            <td>${vo.couponCategory}</td>
            <td>${vo.discountValue}</td>
            <td>${vo.couponRegDate}</td>
            <td>${vo.couponExpDate}</td>
            <td>${vo.couponStatus}</td>
            <td>
              <button type="button" class="btn-edit"
                      value="${vo.couponIdx}"
                      onclick="delCoupon(this)">삭제
              </button>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<!-- 쿠폰 발급 모달 -->
<div id="productGiveModal">
  <div class="modalTitle"><h2>쿠폰 발급</h2></div>
  <form action="Controller?type=productGive" method="post" id="productGiveForm">
    <div class="body">
      <div class="divs">
        <label for="addCategory">카테고리:</label>
        <select name="addCategory" id="addCategory" class="input">
          <option>영화</option>
          <option>매점</option>
          <option>기념일</option>
          <option>회원</option>
          <option>시간대</option>
          <option>요일</option>
          <option>이벤트</option>
        </select>
      </div>
      <div class="divs">
        <label for="addProductName">쿠폰명:</label>
        <input type="text" name="addProductName" id="addProductName" class="input editable" required>
      </div>
      <div class="divs">
        <label for="addDescription">쿠폰설명:</label>
        <input type="text" name="addDescription" id="addDescription" class="input editable" required>
      </div>
      <%--<div class="divs">
        <label for="addImg">발급일:</label>
        <input type="text" name="addImg" id="addImg" class="input editable">
      </div>--%>
      <%--<div class="divs">
        <label for="addPrice">만료일:</label>
        <input type="number" name="addPrice" id="addPrice" class="input editable" required>
      </div>--%>
      <%--<div class="divs">
        <label for="addStock">상태:</label>
        <input type="number" name="addStock" id="addStock" class="input editable" required>
      </div>--%>
      <div class="divs">
        <label for="addStock">할인값:</label>
        <input type="number" name="addStock" id="addStock" class="input editable" required>
      </div>
    </div>
    <div class="footer">
      <button type="button" class="btn btnMain">추가</button>
      <button type="button" class="btn btnSub">취소</button>
    </div>
  </form>
</div>

<!-- 쿠폰 추가 모달 -->
<div id="productAddModal">
  <div class="modalTitle"><h2>쿠폰 추가</h2></div>
  <form action="" method="post" id="productAddForm">
    <div class="body">
      <div class="divs">
        <label for="addCouponCategory">카테고리:</label>
        <select name="addCouponCategory" id="addCouponCategory" class="input">
          <option>영화</option>
          <option>매점</option>
          <option>기념일</option>
          <option>회원</option>
          <option>시간대</option>
          <option>요일</option>
          <option>이벤트</option>
        </select>
      </div>
      <div class="divs">
        <label for="addCouponName">쿠폰명:</label>
        <input type="text" name="addCouponName" id="addCouponName" class="input editable" required>
      </div>
      <div class="divs">
        <label for="addCouponDescription">쿠폰설명:</label>
        <input type="text" name="addCouponDescription" id="addCouponDescription" class="input editable" required>
      </div>
      <%--<div class="divs">
        <label for="addImg">발급일:</label>
        <input type="text" name="addImg" id="addImg" class="input editable">
      </div>--%>
      <%--<div class="divs">
        <label for="addPrice">만료일:</label>
        <input type="number" name="addPrice" id="addPrice" class="input editable" required>
      </div>--%>
      <%--<div class="divs">
        <label for="addStock">상태:</label>
        <input type="number" name="addStock" id="addStock" class="input editable" required>
      </div>--%>
      <div class="divs">
        <label for="addDiscountValue">할인값:</label>
        <input type="number" name="addDiscountValue" id="addDiscountValue" class="input editable" required>
      </div>
    </div>
    <div class="footer">
      <button type="button" class="btn btnMain">추가</button>
      <button type="button" class="btn btnSub">취소</button>
    </div>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
  $(document).ready(function () {
    $("#productGiveModal").dialog({
      autoOpen: false,
      modal: true,
      width: 550,
      resizable: false
    })

    $("#productAddModal").dialog({
      autoOpen: false,
      modal: true,
      width: 550,
      resizable: false
    });

    // 모달의 취소 버튼 클릭 시
    $(".btnSub").on("click", function () {
      // 가장 가까운 모달 div를 찾아서 숨기기
      $(this).closest("#productGiveModal, #productAddModal").dialog('close');
    });
  });

  // 새 상품 추가 버튼 클릭 시
  function addModal() {
    $("#productAddModal").dialog('open');
  }
  function giveModal() {
    $("#productGiveModal").dialog('open');
  }
  // 삭제 버튼 클릭 시
  function delCoupon(str) {
    let cIdx = $(str).val();

    location.href = "Controller?type=delCoupon&cIdx=" + cIdx;
  }

  $(function () {
    $("#productAddModal .btnMain").on('click', function () {
      $("#productAddForm").submit();
    })
  })
</script>
</body>
</html>
