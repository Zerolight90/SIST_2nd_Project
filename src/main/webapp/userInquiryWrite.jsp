<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="./images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

    <style>
        /*body {
            font-family: '맑은 고딕', sans-serif;
            font-size: 14px;
            color: #333;
        }*/
        /*table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            text-align: left; !* 제목 왼쪽 정렬 *!
            padding: 10px;
            background: #f8f8f8;
            border: 1px solid #ddd;
            width: 140px;
            vertical-align: top;
        }
        td {
            text-align: left; !* 데이터 셀 왼쪽 정렬 *!
            padding: 10px;
            border: 1px solid #ddd;
            vertical-align: top;
        }
        input[type="text"], input[type="email"], input[type="password"], select, textarea {
            width: auto; !* 꽉 채우지 않음 *!
            padding: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            text-align: left;
        }
        textarea {
            height: 150px;
            resize: none;
        }
        .note {
            font-size: 12px;
            color: #777;
            margin-top: 5px;
            line-height: 1.4;
            text-align: left;
        }
        .file-btn {
            margin-top: 5px;
        }
        .required {
            color: red;
        }
        .btn {
            background: #999;
            color: white;
            padding: 7px 12px;
            border: none;
            cursor: pointer;
        }

        .bg-chk{
            content: '';
            display: block;
            position: absolute;
            left: 0;
            top: 50%;
            width: 28px;
            height: 28px;
            margin: -14px 0 0 0;
            cursor: pointer;
            background: url(https://img.megabox.co.kr/static/pc/images/common/bg/bg-checkbox.png) no-repeat 0 0;
        }

        .agree_info .agree-box dl dt {
            position: relative;
            padding: 0 30px;
            border-bottom: 1px solid #d8d9db;
            height: 50px;
            line-height: 48px;
        }

        .agree-box dl dt strong {
            font-size: 1.2em;
        }

        .mr10 {
            margin-right: 10px !important;
        }
        .font-orange {
            color: #e63e30 !important;
        }
        .bg-chk [type=checkbox] {
            position: absolute;
            left: -99999px;
        }


        select{
            width:100px;
        }*/

            /* 전체적인 테이블 레이아웃 */
        /* 동의 체크박스 스타일 */
        .agree_info {
            margin-bottom: 30px;
        }
        .agree-box {
            border: 1px solid #ddd;
            padding: 20px;
            background: #fcfcfc;
        }
        .agree-box dt {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        .agree-box dd {
            font-size: 13px;
            line-height: 1.6;
            margin-top: 10px;
        }

        .font-orange {
            color: #e63e30;
            font-weight: bold;
        }

        /* 체크박스 컨테이너 */
        .bg-chk {
            display: inline-block;
            position: relative;
            line-height: 24px;
            cursor: pointer;
        }

        /* 실제 체크박스 숨기기 */
        .bg-chk input[type="checkbox"] {
            position: absolute;
            opacity: 0;
        }

        /* 체크박스 이미지 표시 */
        .bg-chk label {
            position: relative;
            line-height: 24px;
            display: inline-block;
            background: url("./images/ico/check_circle.png") no-repeat left center; /* 기본 이미지 */
            background-size: 24px 24px; /* 이미지 크기 설정 */
        }

        /* 체크박스가 선택되면 배경 이미지 변경 */
        .bg-chk input[type="checkbox"]:checked + label {
            background: url("./images/ico/check_circle_purple.png") no-repeat left center; /* 체크된 이미지 */
            background-size: 24px 24px;
        }

        /* 라벨 텍스트 스타일 */
        .bg-chk label strong {
            font-weight: bold;
            font-size: 1.2em;
            vertical-align: middle;
            padding-left: 30px;
        }


        /* 추가된 스타일 */
        .direct_inquiry_info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .direct_inquiry_info > div {
            flex: 1;
        }
        .direct_inquiry_info .button-container {
            text-align: right;
        }
        .direct_inquiry_info .button-container .my-inquiry-btn {
            background-color: #503396;
            color: #fff;
            font-weight: bold;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
        }
    </style>
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
                <a href="#">1:1 문의</a>
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
                    <h2 class="tit">1:1 문의</h2>
                </div>


                <div class="direct_inquiry_info">
                    <ul>
                        <li>
                            <span><b>고객님의 문의에 답변하는 직원은</b> <b class="red">고객 여러분의 가족 중 한 사람일 수 있습니다.</b><br/></span>
                            <span>고객의 언어폭력(비하, 욕설, 협박, 성희롱 등)으로부터 직원을 보호하기 위해<br/></span>
                            <span>관련 법에 따라 수사기관에 필요한 조치를 요구할 수 있으며, 형법에 의해 처벌 대상이 될 수 있습니다.</span>
                        </li>
                        <li class="m30">
                            문의하시기 전 FAQ를 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다.
                        </li>
                    </ul>
                    <div class="button-container">
                        <a href="Controller?type=myPage&tab=myPrivateinquiry" class="my-inquiry-btn">나의 문의내역</a>
                    </div>
                </div>

                <form action="Controller?type=userInquiryWrite" method="post" enctype="multipart/form-data">
                <div class="agree_info m30">
                    <div class="agree-box">
                        <dl>
                            <dt>
							<span class="bg-chk mr10">
								<input type="checkbox" id="chk">
								<label for="chk"><strong>개인정보 수집에 대한 동의</strong></label>
							</span>

                                <span class="font-orange">[필수]</span>
                            </dt>
                            <dd style="font-size:13px;">
                                귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br><br>

                                [개인정보의 수집 및 이용목적]<br>
                                회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br><br>

                                [필수 수집하는 개인정보의 항목]<br>
                                이름, 휴대전화, 이메일, 문의내용<br><br>

                                [개인정보의 보유기간 및 이용기간]<br>
                                <span class="ismsimp">문의 접수 ~ 처리 완료 후 3년<br>
							(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
							자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</span>
                            </dd>
                        </dl>
                    </div>
                    <span>* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</span>
                </div>

                <div class="direct_inquiry_info">
                    <table>
                        <%--<tr>
                            <th>문의선택 <span class="required">*</span></th>
                            <td class="inquirType">
                                <label><input type="radio" name="type" checked> 고객센터문의</label>
                                <label><input type="radio" name="type"> 극장별문의</label>
                                <select>
                                    <option>지역선택</option>
                                </select>
                                <select>
                                    <option>극장선택</option>
                                </select>
                            </td>
                        </tr>--%>
                        <tr>
                            <th>이름 <span class="required">*</span></th>
                            <td>
                                <input type="text" id="u_name" name="u_name" value="${vo.mvo.name}">
                            </td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td>
                                <input type="tel" name="phone" id="phone" value="${vo.mvo.phone}">
                                <%--<input type="tel" name="u_phone" id="u_phone" value="${}"> -
                                <input type="tel" name="u_phone" id="u_phone" value="${}">--%>
                            </td>
                        </tr>
                        <tr>
                            <th>이메일 <span class="required">*</span></th>
                            <td>
                                <input type="email" name="email" id="email" value="${vo.mvo.email}">
                            </td>
                        </tr>
                        <tr>
                            <th>제목 <span class="required">*</span></th>
                            <td>
                                <input type="text" name="boardTitle" id="boardTitle">
                            </td>
                        </tr>
                        <tr>
                            <th>내용<span class="required">*</span></th>
                            <td>
                                <textarea id="boardContent" name="boardContent" placeholder="- 문의내용에 개인정보(이름, 연락처, 카드번호 등)가 포함되지 않도록 유의하시기 바랍니다.
                                        - 회원 로그인 후 문의가 가능합니다.
                                        - 회원로그인 후 문의작성시 나의 문의내역을 통해 답변을 확인하실 수 있습니다.
                                        - 온라인으로 재고현황 확인이 가능한 영화 이벤트 특전(오리지널 티켓/슬라이드, 드로잉 카드, MX4D 및 특수 포스터 등)의 경우, 선착순으로 지급되고 있어 자세한 잔여수량 답변이 어렵습니다.">

                                </textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>사진첨부</th>
                            <td>
                                <input type="file" class="file-btn" multiple>
                                <div class="note">
                                    * JPEG, PNG 형식의 5M 이하 파일만 첨부 가능합니다. (최대 5개)<br>
                                    * 개인정보가 포함된 이미지는 등록을 자제하여 주시기 바랍니다.
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>
                    <button type="button" id="save_btn" onclick="sendData()">등록</button>
                </form>
            </div>
        </div>
    </div>
</div>

    <footer>
        <jsp:include page="common/Footer.jsp"/>
    </footer>


<script>
    //게시글 등록
    function sendData(){

        //유효성 검사
        //제목
        /*let title = $("#boardTitle").val();
        if(title.trim().length < 1){
            alert("제목을 입력하세요!");
            $("#boardTitle").val("");
            $("#boardTitle").focus();
            return;
        }

        //시작일
        let startRegdate = $("#start_reg_date").val();
        if(startRegdate.trim().length < 1){
            alert("시작일을 입력하세요.");
            $("#start_reg_date").val("");
            $("#start_reg_date").focus();
            return;
        }

        //종료일
        let endRegdate = $("#end_reg_date").val();
        if(endRegdate.trim().length < 1){
            alert("종료일을 입력하세요.");
            $("#end_reg_date").val("");
            $("#end_reg_date").focus();
            return;
        }

        //게시글 내용
        //텍스트로 변환 후 길이 확인(에디터로 인해 html구조로 코드가 생성되어 비어보이지만 빈값으로 처리가 안됨)
        let contentHtml = $('#board_content').summernote('code');  // Summernote HTML 코드 가져오기

        if (isEmptySummernoteContent(contentHtml)) {
            alert("내용을 입력해주세요.");
            //기존 배운 방식은 textarea나 input요소에만 영향을 주므로,
            //summernote editer를 쓰는 경우, 아래와 같이 summernote로 하면 된다.
            $('#board_content').summernote('code', '');
            $("#board_content").summernote('focus');

            return;
        }*/
        document.forms[0].submit();
    }
</script>
</body>
</html>
