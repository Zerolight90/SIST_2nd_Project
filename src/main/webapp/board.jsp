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
                <a href="Controller?type=board">공지사항</a>
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

                <div class="ec-base-tab typeLight notice-tab-wrap ">
                    <ul class="notice-tab menu">
                        <li class="tabBtn on selected"><a class="btn">전체</a></li>
                        <li class="tabBtn"><a class="btn">메가박스 공지</a></li>
                        <li class="tabBtn"><a class="btn">지점 공지</a></li>
                    </ul>
                </div>

                <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">3,773</em>건</strong></div>

                        <div class="dropdown">
                            <select id="dropdown-select" title="지역 선택" class="mr07" tabindex="-98">
                                <option class="bs-title-option" value="">지역 선택</option>
                                <option value="">지역 선택</option>
                                <option value="10">서울</option>
                                <option value="30">경기</option>
                                <option value="35">인천</option>
                                <option value="45">대전/충청/세종</option>
                                <option value="55">부산/대구/경상</option>
                                <option value="65">광주/전라</option>
                                <option value="70">강원</option>
                                <option value="80">제주</option>
                            </select>

                            <select id="dropdown-mv" title="극장 선택" class="mr07" tabindex="-98">
                                <option class="bs-title-option" value="">극장 선택</option>
                                <option value="">지역 선택</option>
                                <option value="10">서울지점</option>
                                <option value="30">경기지점</option>
                                <option value="35">인천지점</option>
                                <option value="45">대전/충청/세종지점</option>
                                <option value="55">부산/대구/경상지점</option>
                                <option value="65">광주/전라지점</option>
                                <option value="70">강원지점</option>
                                <option value="80">제주지점</option>
                            </select>
                        </div>

                        <div class="board-search">
                            <input type="text" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtn" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <!-- 공지사항 테이블 -->
                    <div class="notice-board-wrapper">
                        <table class="notice-board">
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>극장</th>
                                <th>구분</th>
                                <th>제목</th>
                                <th>등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>메가박스</td>
                                <td>공지</td>
                                <td><a href="#">[메가박스] 전관 대관 행사 안내(7/26)</a></td>
                                <td>2025.07.21</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>신촌</td>
                                <td>공지</td>
                                <td><a href="#">[신촌] 시스템 점검 안내</a></td>
                                <td>2025.07.19</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <nav class="pagination">
                        <a title="처음 페이지 보기" href="javascript:void(0)" class="control first" pagenum="1">first</a>
                        <a title="이전 10페이지 보기" href="javascript:void(0)" class="control prev" pagenum="351">prev</a>
                        <strong class="active">361</strong>
                        <a title="1페이지보기" href="javascript:void(0)" pagenum="362">362</a>
                        <a title="2페이지보기" href="javascript:void(0)" pagenum="363">363</a>
                        <a title="3페이지보기" href="javascript:void(0)" pagenum="364">364</a>
                        <a title="4페이지보기" href="javascript:void(0)" pagenum="365">365</a>
                        <a title="5페이지보기" href="javascript:void(0)" pagenum="366">366</a>
                        <a title="6페이지보기" href="javascript:void(0)" pagenum="367">367</a>
                        <a title="7페이지보기" href="javascript:void(0)" pagenum="368">368</a>
                        <a title="8페이지보기" href="javascript:void(0)" pagenum="369">369</a>
                        <a title="9페이지보기" href="javascript:void(0)" pagenum="370">370</a>
                        <a title="이후 10페이지 보기" href="javascript:void(0)" class="control next" pagenum="371">next</a>
                        <a title="마지막 페이지 보기" href="javascript:void(0)" class="control last" pagenum="378">last</a>
                    </nav>
                </div>

                <div id="tabCont1_2" class="tabCont" style="display:none; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">3,773</em>건</strong></div>

                        <div class="board-search"   style="margin-left: auto;" >
                            <input type="text" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtn" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <!-- 공지사항 테이블 -->
                    <div class="notice-board-wrapper">
                        <table class="notice-board">
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>극장</th>
                                <th>구분</th>
                                <th>제목</th>
                                <th>등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>메가박스</td>
                                <td>공지</td>
                                <td><a href="#">[메가박스] 전관 대관 행사 안내(7/26)</a></td>
                                <td>2025.07.21</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>메가박스</td>
                                <td>공지</td>
                                <td><a href="#">[메가박스] 전관 대관 행사 안내(7/26)</a></td>
                                <td>2025.07.21</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <nav class="pagination">
                        <a title="처음 페이지 보기" href="javascript:void(0)" class="control first" pagenum="1">first</a>
                        <a title="이전 10페이지 보기" href="javascript:void(0)" class="control prev" pagenum="351">prev</a>
                        <strong class="active">361</strong>
                        <a title="1페이지보기" href="javascript:void(0)" pagenum="362">362</a>
                        <a title="2페이지보기" href="javascript:void(0)" pagenum="363">363</a>
                        <a title="3페이지보기" href="javascript:void(0)" pagenum="364">364</a>
                        <a title="4페이지보기" href="javascript:void(0)" pagenum="365">365</a>
                        <a title="5페이지보기" href="javascript:void(0)" pagenum="366">366</a>
                        <a title="6페이지보기" href="javascript:void(0)" pagenum="367">367</a>
                        <a title="7페이지보기" href="javascript:void(0)" pagenum="368">368</a>
                        <a title="8페이지보기" href="javascript:void(0)" pagenum="369">369</a>
                        <a title="9페이지보기" href="javascript:void(0)" pagenum="370">370</a>
                        <a title="이후 10페이지 보기" href="javascript:void(0)" class="control next" pagenum="371">next</a>
                        <a title="마지막 페이지 보기" href="javascript:void(0)" class="control last" pagenum="378">last</a>
                    </nav>
                </div>

                <div id="tabCont1_3" class="tabCont" style="display:none; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">3,773</em>건</strong></div>

                        <div class="dropdown">
                            <select id="dropdown-select" title="지역 선택" class="mr07" tabindex="-98">
                                <option class="bs-title-option" value="">지역 선택</option>
                                <option value="">지역 선택</option>
                                <option value="10">서울</option>
                                <option value="30">경기</option>
                                <option value="35">인천</option>
                                <option value="45">대전/충청/세종</option>
                                <option value="55">부산/대구/경상</option>
                                <option value="65">광주/전라</option>
                                <option value="70">강원</option>
                                <option value="80">제주</option>
                            </select>

                            <select id="dropdown-mv" title="극장 선택" class="mr07" tabindex="-98">
                                <option class="bs-title-option" value="">극장 선택</option>
                                <option value="">지역 선택</option>
                                <option value="10">서울지점</option>
                                <option value="30">경기지점</option>
                                <option value="35">인천지점</option>
                                <option value="45">대전/충청/세종지점</option>
                                <option value="55">부산/대구/경상지점</option>
                                <option value="65">광주/전라지점</option>
                                <option value="70">강원지점</option>
                                <option value="80">제주지점</option>
                            </select>
                        </div>

                        <div class="board-search">
                            <input type="text" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtn" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <!-- 공지사항 테이블 -->
                    <div class="notice-board-wrapper">
                        <table class="notice-board">
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>극장</th>
                                <th>구분</th>
                                <th>제목</th>
                                <th>등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>메가박스</td>
                                <td>공지</td>
                                <td><a href="#">[메가박스] 전관 대관 행사 안내(7/26)</a></td>
                                <td>2025.07.21</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>신촌</td>
                                <td>공지</td>
                                <td><a href="#">[신촌] 시스템 점검 안내</a></td>
                                <td>2025.07.19</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <nav class="pagination">
                        <a title="처음 페이지 보기" href="javascript:void(0)" class="control first" pagenum="1">first</a>
                        <a title="이전 10페이지 보기" href="javascript:void(0)" class="control prev" pagenum="351">prev</a>
                        <strong class="active">361</strong>
                        <a title="1페이지보기" href="javascript:void(0)" pagenum="362">362</a>
                        <a title="2페이지보기" href="javascript:void(0)" pagenum="363">363</a>
                        <a title="3페이지보기" href="javascript:void(0)" pagenum="364">364</a>
                        <a title="4페이지보기" href="javascript:void(0)" pagenum="365">365</a>
                        <a title="5페이지보기" href="javascript:void(0)" pagenum="366">366</a>
                        <a title="6페이지보기" href="javascript:void(0)" pagenum="367">367</a>
                        <a title="7페이지보기" href="javascript:void(0)" pagenum="368">368</a>
                        <a title="8페이지보기" href="javascript:void(0)" pagenum="369">369</a>
                        <a title="9페이지보기" href="javascript:void(0)" pagenum="370">370</a>
                        <a title="이후 10페이지 보기" href="javascript:void(0)" class="control next" pagenum="371">next</a>
                        <a title="마지막 페이지 보기" href="javascript:void(0)" class="control last" pagenum="378">last</a>
                    </nav>
                </div>

            </div>
        </div>
    </div>

</div>



    <footer>
        <jsp:include page="common/Footer.jsp"/>
    </footer>

    <script>
        // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
        const tabs = document.querySelectorAll('.menu li');
        const tabContents = document.querySelectorAll('.tabCont');

        // 2. 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
        tabs.forEach((tab, index) => {
            tab.addEventListener('click', (e) => {
                // a 태그의 기본 동작(페이지 이동)을 막습니다.
                e.preventDefault();

                // 3. 모든 탭에서 'selected' 클래스를 제거합니다.
                tabs.forEach(item => item.classList.remove('selected'));

                // 4. 방금 클릭한 탭에만 'selected' 클래스를 추가합니다.
                tab.classList.add('selected');

                // 5. 모든 내용 영역을 숨깁니다.
                tabContents.forEach(content => content.style.display = 'none');

                // 6. 클릭한 탭과 순서가 맞는 내용 영역만 보여줍니다.
                tabContents[index].style.display = 'block';
            });
        });

    </script>
</body>
</html>
