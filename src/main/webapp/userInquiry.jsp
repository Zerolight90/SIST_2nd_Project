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
        .red{
            color:red;
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
                </div>

                <div class="agree_info">
                    <table style="width:830px;">
                        <thead style="text-align:left; padding:20px;">
                            <tr>
                                <th style="text-align:left; padding:20px;"><span>개인정보 수집에 대한 동의</span> <span class="red">[필수]</span></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="text-align:left; padding:20px;">귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br/><br/><br/>

                                    [개인정보의 수집 및 이용목적]<br/>
                                    회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br/><br/>

                                    [필수 수집하는 개인정보의 항목]<br/>
                                    이름, 휴대전화, 이메일, 문의내용<br/><br/>

                                    [개인정보의 보유기간 및 이용기간]<br/>
                                    <b>문의 접수 ~ 처리 완료 후 3년<br/>
                                    (단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br/>
                                    자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.<b>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <span>* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</span>
                </div>

                <div>
                    <table>
                        <%--<tr>
                            <th class="row">문의선택 <em class="red">*</em></th>
                            <td colspan="3">
                                <input type="radio" id="centerQ" name="centerQ" value="고객센터문의" checked="">
                                <label for="centerQ">고객센터문의</label>

                                <input type="radio" id="theaterQ" name="theaterQ" value="극장별문의">
                                <label for="theaterQ">극장별문의</label>

                                <div class="select_location">
                                    <select id="theaterQ" name="theaterQ" class="small ml10" title="지역선택" disabled="disabled" tabindex="-98">
                                        <option class="bs-title-option" value=""></option>
                                    <option value="">지역선택</option>

                                    <option value="10">서울</option>

                                    <option value="30">경기</option>

                                    <option value="35">인천</option>

                                    <option value="45">대전/충청/세종</option>

                                    <option value="55">부산/대구/경상</option>

                                    <option value="65">광주/전라</option>

                                    <option value="70">강원</option>

                                    <option value="80">제주</option>

                                </select><button type="button" class="btn dropdown-toggle disabled bs-placeholder btn-default" data-toggle="dropdown" role="button" data-id="theater" tabindex="-1" aria-disabled="true" title="지역선택"><div class="filter-option"><div class="filter-option-inner"><div class="filter-option-inner-inner">지역선택</div></div> </div><span class="bs-caret"><span class="caret"></span></span></button><div class="dropdown-menu open" role="combobox" style="max-height: 842.672px; overflow: hidden; min-height: 92px;"><div class="inner open" role="listbox" aria-expanded="false" tabindex="-1" style="max-height: 840.672px; overflow-y: auto; min-height: 90px;"><ul class="dropdown-menu inner "><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">지역선택</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">서울</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">경기</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">인천</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">대전/충청/세종</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">부산/대구/경상</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">광주/전라</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">강원</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">제주</span></a></li></ul></div></div></div>
                                <div class="dropdown bootstrap-select disabled small ml10 bs3"><select name="brchNo" id="theater02" class="small ml10" title="극장선택" disabled="disabled" tabindex="-98"><option class="bs-title-option" value=""></option>

                                    <option value="">극장선택</option></select><button type="button" class="btn dropdown-toggle disabled bs-placeholder btn-default" data-toggle="dropdown" role="button" data-id="theater02" tabindex="-1" aria-disabled="true" title="극장선택"><div class="filter-option"><div class="filter-option-inner"><div class="filter-option-inner-inner">극장선택</div></div> </div><span class="bs-caret"><span class="caret"></span></span></button><div class="dropdown-menu open" role="combobox" style="max-height: 842.547px; overflow: hidden; min-height: 0px;"><div class="inner open" role="listbox" aria-expanded="false" tabindex="-1" style="max-height: 840.547px; overflow-y: auto; min-height: 0px;"><ul class="dropdown-menu inner "><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">극장선택</span></a></li></ul></div></div></div>
                            </td>
                        </tr>--%>

                        <tr>
                            <th>문의선택</th>
                            <th>문의유형</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>휴대전화</th>
                            <th>제목</th>
                            <th>내용</th>
                        </tr>
                        <tr>
                            <td>문의 내용</td>
                            <td>
                                <textarea rows="12" cols="50" id="boardContent" name="boardContent" placeholder="aa.">
                                </textarea>
                            </td>

                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>



    <footer>
        <jsp:include page="common/Footer.jsp"/>
    </footer>

</body>
</html>
