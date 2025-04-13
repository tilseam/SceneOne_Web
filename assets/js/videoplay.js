$(document).ready(function() {
    // 绑定点击事件到document，使用事件代理
    $(document).on('click', '.card-single h1, .card-single h2, .card-single h6, .card-single img, #playVideoLink', function(e) {
      e.preventDefault();
      console.log('1111');
      openVideo();
    });
    
    const modal = document.getElementById('videoModal');
    const closeBtn = document.getElementById('closeBtn');
    const biliPlayer = document.getElementById('bili-player');
    
    function setVideoHeight() {
      biliPlayer.style.height = biliPlayer.offsetWidth * 0.5625 + 'px';
    }
    
    $(window).resize(setVideoHeight);
    setVideoHeight();
    
    function openVideo() {
      // 打印到控制台
      console.log('打开视频');
      // 显示模态框
      $(modal).css('display', 'flex');
      let src = biliPlayer.src;
      if (src.indexOf('autoplay=0') !== -1) {
        biliPlayer.src = src.replace('autoplay=0', 'autoplay=1');
      }
      setVideoHeight();
    }
    
    $(closeBtn).click(function() {
      closeVideo();
    });
    
    $(modal).click(function(e) {
      if (e.target === modal) {
        closeVideo();
      }
    });
    
    function closeVideo() {
      let src = biliPlayer.src;
      biliPlayer.src = src.replace('autoplay=1', 'autoplay=0');
      $(modal).css('display', 'none');
    }
  });