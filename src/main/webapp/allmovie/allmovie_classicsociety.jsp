<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div class="movie-list">
  <!-- 클래식소사이어티 영화 60개 예시 -->
  <% for(int i=1; i<=60; i++){ %>
  <div class="movie-item <% if (i > 8) { %>hidden<% } %>">
    <a href="#" class="poster-link">
      <img src="https://via.placeholder.com/260x372.png/36454F/FFFFFF?text=Classic+Society+<%=i%>" alt="클래식소사이어티 포스터 예시 <%=i%>">
    </a>
    <div class="movie-info">
      <h3>클래식소사이어티 영화 <%= i %></h3>
      <div class="movie-stats">
        <span>개봉일 2025.12.<%= String.format("%02d", i) %></span>
      </div>
      <div class="movie-actions">
        <button type="button" class="like-btn">
          <span class="heart-icon"></span>
          <span>7<%= i %></span>
        </button>
        <a href="../booking.jsp" class="reserve-btn">예매</a>
      </div>
    </div>
  </div>
  <% } %>
</div>

<div class="more-btn-wrap">
  <button type="button" class="more-btn">더보기 <i class="fa-solid fa-chevron-down"></i></button>
</div>

<button type="button" class="top-btn" data-tab-target="classicsociety">
  <i class="fa-solid fa-arrow-up"></i>
  <span>TOP</span>
</button>

<script>
  if (!window.classicsocietyScriptLoaded) {
    window.classicsocietyScriptLoaded = true;

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

    addLikeButtonListeners('#classicsociety .like-btn');

    const moreBtn = document.querySelector('#classicsociety .more-btn');
    if (moreBtn) {
      moreBtn.addEventListener('click', function() {
        const hiddenItems = document.querySelectorAll('#classicsociety .movie-item.hidden');
        const showCount = 20;

        for (let i = 0; i < showCount && i < hiddenItems.length; i++) {
          hiddenItems[i].classList.remove('hidden');
        }

        addLikeButtonListeners('#classicsociety .movie-item:not(.hidden) .like-btn');

        if (document.querySelectorAll('#classicsociety .movie-item.hidden').length === 0) {
          this.parentElement.style.display = 'none';
        }
      });
    }

    const topBtn = document.querySelector('.top-btn[data-tab-target="classicsociety"]');
    if(topBtn) {
      window.addEventListener('scroll', () => {
        const currentTab = document.querySelector('.tab-content.active');
        if (currentTab && currentTab.id === 'classicsociety' && window.scrollY > 200) {
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
