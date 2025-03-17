document.addEventListener('DOMContentLoaded', function() {
    const cardSingle = document.querySelector('.card-single');
    const modal = document.getElementById('videoModal');
    const closeBtn = document.getElementById('closeBtn');
    const biliPlayer = document.getElementById('bili-player');
    
    // 设置视频比例函数
    function setVideoHeight() {
      biliPlayer.style.height = biliPlayer.offsetWidth * 0.5625 + 'px';
    }
    
    // 页面加载和窗口大小改变时设置视频高度
    window.addEventListener('resize', setVideoHeight);
    setVideoHeight();
    
    // 事件委托 - 监听卡片内部点击
    cardSingle.addEventListener('click', function(e) {
      // 检查点击的是否为h1、h2、h6元素或img元素
      if (
        e.target.tagName === 'H1' || 
        e.target.tagName === 'H2' || 
        e.target.tagName === 'H6' ||
        e.target.tagName === 'IMG' || // 添加对图片的检测
        (e.target.tagName === 'A' && e.target.id === 'playVideoLink')
      ) {
        e.preventDefault();
        openVideo();
      }
    });
    
    // 如果保留了原来的链接，也可以直接监听它
    const playVideoLink = document.getElementById('playVideoLink');
    if (playVideoLink) {
      playVideoLink.addEventListener('click', function(e) {
        e.preventDefault();
        openVideo();
      });
    }
    
    function openVideo() {
      modal.style.display = 'flex';
      let src = biliPlayer.src;
      if (src.indexOf('autoplay=0') !== -1) {
        biliPlayer.src = src.replace('autoplay=0', 'autoplay=1');
      }
      setVideoHeight();
    }
    
    // 关闭弹窗
    closeBtn.addEventListener('click', function() {
      closeVideo();
    });
    
    // 点击背景关闭弹窗
    modal.addEventListener('click', function(e) {
      if (e.target === modal) {
        closeVideo();
      }
    });
    
    function closeVideo() {
      let src = biliPlayer.src;
      biliPlayer.src = src.replace('autoplay=1', 'autoplay=0');
      modal.style.display = 'none';
    }
  });