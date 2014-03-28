$ ->
	$mainVisual = $("#box-mainvisual")
	$mainVisual.prepend('<ul id="nav-carousel-01"></ul>')
	$slideItem = $("#list-main-visual").find("li")
	$slideNum = $slideItem.length
	$currentCircle = $mainVisual.find("#nav-carousel-01")
	activeNav = 0
	fadeSpeed = 300
	loopSpeed = 3000
	###
	グローバル変数
	------------------
	###
	
	#fragment = document.createDocumentFragment()
	for i in [0..$slideNum]
		if $slideNum > i
			$currentCircle.append("<li><a href>" + [i+1] + "</a></li>")
			#fragment.append("<li><a href>" + [i+1] + "</a></li>")
	$currentCircle.find("li").eq(0).find("a").addClass("current")


	###
	インジケーターセット
	------------------
	###

	slideShowFunc = ->
		#ローカル変数
		slideActive = $("#list-main-visual").find("li.active")
		slideActive = $("#list-main-visual").find("li:last")  if slideActive.length is 0
		slideNext = ((if slideActive.next().length then slideActive.next() else $("#list-main-visual").find("li").eq(0)))
		activeNav = -1  if activeNav >= $slideNum - 1
		activeNav++
		$currentCircle.find("li").find("a.current").removeClass "current"
		$currentCircle.find("li").find("a").eq(activeNav).addClass "current"
		slideActive.addClass "active-after"
		slideNext.css(opacity: 0).addClass("active").animate
	    opacity: 1
		, fadeSpeed, ->
	    slideActive.removeClass "active active-after"
	    return
	  return

	###
	自動ループ
	------------------
	###

	slideSwitch = ->
		slideCurrentNum = 0
		$currentCircle.find("li").find("a").click ->
			clearInterval(loopSlideTimer)
			$currentCircle.find("a").removeClass "current"
			$(@).addClass("current")
			slideCurrentNum = $currentCircle.find("li").find("a").index(@)
			$slideItem.css(opacity:0)
			#一回すべてを要素を0にする。
			$("#list-main-visual").find("li.active").addClass("active-after").css(opacity:1)
			#.activeクラスをもっている要素に.active-afterを付与
			$slideItem.eq(slideCurrentNum).css(opacity: 0).addClass("active").animate
				opacity: 1 , fadeSpeed, ->
					$slideItem.removeClass "active-after active"
					$slideItem.eq(slideCurrentNum).addClass "active"		
			activeNav = slideCurrentNum #インジケーターのカレント修正
			return false

	###
	ボタンを押したときの処理
	------------------
	###


	loopSlideTimer = setInterval ->
	    slideShowFunc()
	    return
	  , loopSpeed

	###
	タイマー
	------------------
	###

	#Stop timer
	stopTimerfunc = ->
	  $mainVisual.mouseenter ->
	    clearInterval loopSlideTimer

	  $mainVisual.mouseleave ->
	    clearInterval loopSlideTimer
	    loopSlideTimer = setInterval(->
	      slideShowFunc()
	      return
	    , loopSpeed)
	    return

	  $mainVisual.find("a").focus ->
	    clearInterval loopSlideTimer

	  $mainVisual.find("a").blur ->
	    clearInterval loopSlideTimer
	    loopSlideTimer = setInterval(->
	      slideShowFunc()
	      return
	    , loopSpeed)
	    return

	  return


	###
	ストップタイマー処理
	------------------
	###

	funcControll = ->	
		slideSwitch() #アニメーション
		stopTimerfunc() #ストップ処理・再スタート処理
		return

	###
	ファンクションコントロール
	------------------
	###

	funcControll()

	###
	実行
	------------------
	###





