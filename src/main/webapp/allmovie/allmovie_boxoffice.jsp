<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div class="movie-list">
  <!-- 영화 목록 반복 시작 (총 60개) -->
  <% for(int i=1; i<=60; i++){ %>
  <div class="movie-item <% if (i > 8) { %>hidden<% } %>">
    <a href="#" class="poster-link">
      <img src="https://via.placeholder.com/260x372.png/503396/FFFFFF?text=Movie+<%=i%>" alt="영화 포스터 예시">
    </a>
    <div class="movie-info">
      <h3>영화 제목 <%= i %></h3>
      <div class="movie-stats">
        <span>예매율 10.<%= i %>%</span>
        <span style="margin: 0 5px;">|</span>
        <span>개봉일 2025.08.<%= String.format("%02d", i) %></span>
      </div>
      <div class="movie-actions">
        <button type="button" class="like-btn">
          <span class="heart-icon"></span>
          <span>11<%= i %></span>
        </button>
        <a href="../booking.jsp" class="reserve-btn">예매</a>
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

<!-- TOP 버튼 (boxoffice 탭 전용) -->
<button type="button" class="top-btn" data-tab-target="boxoffice">
  <i class="fa-solid fa-arrow-up"></i>
  <span>TOP</span>
</button>

<script>
  if (!window.boxofficeScriptLoaded) {
    window.boxofficeScriptLoaded = true;

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

    addLikeButtonListeners('#boxoffice .like-btn');

    const moreBtn = document.querySelector('#boxoffice .more-btn');
    if (moreBtn) {
      moreBtn.addEventListener('click', function() {
        const hiddenItems = document.querySelectorAll('#boxoffice .movie-item.hidden');
        const showCount = 20;

        for (let i = 0; i < showCount && i < hiddenItems.length; i++) {
          hiddenItems[i].classList.remove('hidden');
        }

        addLikeButtonListeners('#boxoffice .movie-item:not(.hidden) .like-btn');

        if (document.querySelectorAll('#boxoffice .movie-item.hidden').length === 0) {
          this.parentElement.style.display = 'none';
        }
      });
    }

    const topBtn = document.querySelector('.top-btn[data-tab-target="boxoffice"]');
    if(topBtn) {
      window.addEventListener('scroll', () => {
        const currentTab = document.querySelector('.tab-content.active');
        if (currentTab && currentTab.id === 'boxoffice' && window.scrollY > 200) {
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
