<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div class="movie-list">
    <!-- 영화 목록 반복 시작 (총 60개) -->
    <% for(int i=1; i<=60; i++){ %>
    <div class="movie-item <% if (i > 8) { %>hidden<% } %>">
        <a href="#" class="poster-link">
            <img src="https://via.placeholder.com/260x372.png/666666/FFFFFF?text=Coming+Soon+<%=i%>" alt="상영예정작 포스터 예시 <%=i%>">
        </a>
        <div class="movie-info">
            <h3>상영예정작 <%= i %></h3>
            <div class="movie-stats">
                <span>개봉예정일 2025.09.<%= String.format("%02d", i) %></span>
            </div>
            <div class="movie-actions">
                <button type="button" class="like-btn">
                    <span class="heart-icon"></span>
                    <span>9<%= i %></span>
                </button>
                <a href="#" class="reserve-btn" style="background-color: #999; border-color: #999; cursor: not-allowed;">개봉예정</a>
            </div>
        </div>
    </div>
    <% } %>
    <!-- 영화 목록 반복 끝 -->
</div>

<!-- 더보기 버튼 -->
<div class="more-btn-wrap">
    <button type="button" class="more-btn">더보기 <i class="fa-solid fa-chevron-down"></i></button>
</div>

<!-- TOP 버튼 (scheduled 탭 전용) -->
<button type="button" class="top-btn" data-tab-target="scheduled">
    <i class="fa-solid fa-arrow-up"></i>
    <span>TOP</span>
</button>

<script>
    if (!window.scheduledScriptLoaded) {
        window.scheduledScriptLoaded = true;

        function addLikeButtonListeners(selector) {
            document.querySelectorAll(selector).forEach(button => {
                if (button.dataset.eventAttached) return;
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    this.classList.toggle('liked');
                });
                button.dataset.eventAttached = 'true';
            });
        }

        addLikeButtonListeners('#scheduled .like-btn');

        const moreBtn = document.querySelector('#scheduled .more-btn');
        if (moreBtn) {
            moreBtn.addEventListener('click', function() {
                const hiddenItems = document.querySelectorAll('#scheduled .movie-item.hidden');
                const showCount = 20;

                for (let i = 0; i < showCount && i < hiddenItems.length; i++) {
                    hiddenItems[i].classList.remove('hidden');
                }

                addLikeButtonListeners('#scheduled .movie-item:not(.hidden) .like-btn');

                if (document.querySelectorAll('#scheduled .movie-item.hidden').length === 0) {
                    this.parentElement.style.display = 'none';
                }
            });
        }

        const topBtn = document.querySelector('.top-btn[data-tab-target="scheduled"]');
        if(topBtn) {
            window.addEventListener('scroll', () => {
                const currentTab = document.querySelector('.tab-content.active');
                if (currentTab && currentTab.id === 'scheduled' && window.scrollY > 200) {
                    topBtn.classList.add('visible');
                } else {
                    topBtn.classList.remove('visible');
                }
            });

            topBtn.addEventListener('click', () => {
                window.scrollTo({top: 0, behavior: 'smooth'});
            });
        }
    }
</script>
