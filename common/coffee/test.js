// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var $currentCircle, $mainVisual, $slideItem, $slideNum, activeNav, fadeSpeed, funcControll, i, loopSlideTimer, loopSpeed, slideShowFunc, slideSwitch, stopTimerfunc, _i;
    $mainVisual = $("#box-mainvisual");
    $mainVisual.prepend('<ul id="nav-carousel-01"></ul>');
    $slideItem = $("#list-main-visual").find("li");
    $slideNum = $slideItem.length;
    $currentCircle = $mainVisual.find("#nav-carousel-01");
    activeNav = 0;
    fadeSpeed = 300;
    loopSpeed = 3000;
    /*
    	グローバル変数
    	------------------
    */

    for (i = _i = 0; 0 <= $slideNum ? _i <= $slideNum : _i >= $slideNum; i = 0 <= $slideNum ? ++_i : --_i) {
      if ($slideNum > i) {
        $currentCircle.append("<li><a href>" + [i + 1] + "</a></li>");
      }
    }
    $currentCircle.find("li").eq(0).find("a").addClass("current");
    /*
    	インジケーターセット
    	------------------
    */

    slideShowFunc = function() {
      var slideActive, slideNext;
      slideActive = $("#list-main-visual").find("li.active");
      if (slideActive.length === 0) {
        slideActive = $("#list-main-visual").find("li:last");
      }
      slideNext = (slideActive.next().length ? slideActive.next() : $("#list-main-visual").find("li").eq(0));
      if (activeNav >= $slideNum - 1) {
        activeNav = -1;
      }
      activeNav++;
      $currentCircle.find("li").find("a.current").removeClass("current");
      $currentCircle.find("li").find("a").eq(activeNav).addClass("current");
      slideActive.addClass("active-after");
      slideNext.css({
        opacity: 0
      }).addClass("active").animate({
        opacity: 1
      }, fadeSpeed, function() {
        slideActive.removeClass("active active-after");
      });
    };
    /*
    	自動ループ
    	------------------
    */

    slideSwitch = function() {
      var slideCurrentNum;
      slideCurrentNum = 0;
      return $currentCircle.find("li").find("a").click(function() {
        clearInterval(loopSlideTimer);
        $currentCircle.find("a").removeClass("current");
        $(this).addClass("current");
        slideCurrentNum = $currentCircle.find("li").find("a").index(this);
        $slideItem.css({
          opacity: 0
        });
        $("#list-main-visual").find("li.active").addClass("active-after").css({
          opacity: 1
        });
        $slideItem.eq(slideCurrentNum).css({
          opacity: 0
        }).addClass("active").animate({
          opacity: 1
        }, fadeSpeed, function() {
          $slideItem.removeClass("active-after active");
          return $slideItem.eq(slideCurrentNum).addClass("active");
        });
        activeNav = slideCurrentNum;
        return false;
      });
    };
    /*
    	ボタンを押したときの処理
    	------------------
    */

    loopSlideTimer = setInterval(function() {
      slideShowFunc();
    }, loopSpeed);
    /*
    	タイマー
    	------------------
    */

    stopTimerfunc = function() {
      $mainVisual.mouseenter(function() {
        return clearInterval(loopSlideTimer);
      });
      $mainVisual.mouseleave(function() {
        clearInterval(loopSlideTimer);
        loopSlideTimer = setInterval(function() {
          slideShowFunc();
        }, loopSpeed);
      });
      $mainVisual.find("a").focus(function() {
        return clearInterval(loopSlideTimer);
      });
      $mainVisual.find("a").blur(function() {
        clearInterval(loopSlideTimer);
        loopSlideTimer = setInterval(function() {
          slideShowFunc();
        }, loopSpeed);
      });
    };
    /*
    	ストップタイマー処理
    	------------------
    */

    funcControll = function() {
      slideSwitch();
      stopTimerfunc();
    };
    /*
    	ファンクションコントロール
    	------------------
    */

    return funcControll();
    /*
    	実行
    	------------------
    */

  });

}).call(this);
