$ ->

	funcControll = ->
		###html読み込み後処理###
		list_global = $('header').find('ul')
		menuBtn = $('.btn-menu')
		breakpointParts = $(".banner-list").find("li")

		###ページトップスクロールボタン処理###
		pageTopCreate()
		###グロナビ処理###
		globalToggle(list_global,menuBtn)
		###アコーディオン作成###
		if $('.hdg-03-10').length and $('.toggle-content').length
			createAccordion('.hdg-03-10', ".toggle-content", '.close-btn-01', breakpointParts)
		if $('.hdg-03-16').length and $('.toggle-content').length
			createAccordion('.hdg-03-16', ".toggle-content", '.close-btn-02')
		if $('.hdg-03-17').length and $('.toggle-content').length
			createAccordion('.hdg-03-17', ".toggle-content", '.close-btn-02')
		###高さ揃え###
		$(window).load ->
			if $('.top-column03-02').length and $('.top-box-02').length
				heightEqualizer('.top-column03-02', '.top-box-02',breakpointParts)
			if $('.column03-01').length and $('.box-03').length
				heightEqualizer('.column03-01', '.box-03',breakpointParts)
			if $('.column03-01').length and $('.box-05').length
				heightEqualizer('.column03-01', '.box-05',breakpointParts)
			if $('.column03-01').length and $('.equalize-box').length
				heightEqualizer('.column03-01', '.equalize-box',breakpointParts)
			if $('.column02-01').length and $('.box-03').length
				heightEqualizer('.column02-01', '.box-03',breakpointParts)
			return

	###
	グロナビのトグル
	------------------------------------
	list_global…グローバルナビゲーションのリスト
	menuBtn…グローバルナビゲーションのボタン
	------------------------------------
	###
	globalToggle = (list_global, menuBtn)  ->
		###メニューボタンが見えない時、ナビゲーションを隠す###
		if menuBtn.is(':visible') is true
			list_global.hide()
		###メニューボタンクリック時###
		menuBtn.click (event) ->
			###spサイズ時以外###
			if list_global.is(':visible') is false
				menuBtn.addClass('open')
				list_global.slideToggle('fast', -> list_global.removeAttr('style'))
			else
				###spサイズ時###
				menuBtn.removeClass('open')
				list_global.slideToggle('fast')
			###aクリック時のデフォルトイベントのキャンセル###
			event.preventDefault()
			return
		###ウインドウリサイズ時###
		$(window).resize ->
			###メニューボタンが見えない時、付加スタイル（非表示）を取る###
			if menuBtn.is(':visible') is false
				list_global.removeAttr('style')
			else
				###メニューボタン表示時、メニューボタンのクラスopenで開閉を認識、openが付加されている時にナビゲーションを開き、無い時は閉じる###
				if menuBtn.hasClass('open')
					list_global.removeAttr('style')
				else
					list_global.hide()
			return
		return

	###
	RWD高さ揃え
	------------------------------------
	target…グループの親要素
	targetChildren…高さを揃えたい要素
	breakpointParts…ブレークポイントの要となる共通パーツ
	columns…高さを揃えたい1グループあたりの要素数（デフォルトはtargetのtargetChildrenの数）
	------------------------------------
	###
	heightEqualizer = (target, targetChildren, breakpointParts, columns) ->
		equalizeFunc = ->
			$(target).each ->
				count = 0
				maxHeight = 0
				childs = []
				equalizeTarget = $(this).find(targetChildren)
				last = equalizeTarget.length - 1
				###columnが無い時（null）###
				if columns is undefined
					columns = equalizeTarget.length
				###ウインドウリサイズ時を想定して一度付加スタイルをリセットしています###
				return equalizeTarget.each (i) ->
					count = i % columns
					childs[count] = $(this)
					$(this).removeAttr('style')
					if count is 0 or $(this).height() > maxHeight
						maxHeight = $(this).height()
					if i is last or count == columns - 1
						$.each(childs, (i, t)-> t.height(maxHeight))
					return
				return
			return
		###ウインドウリサイズ時にspサイズ時は付加スタイル消去、他は再度リサイズ###
		$(window).resize ->
			if breakpointParts.css("float") isnt "none"
				equalizeFunc()
			else
				$(target).find(targetChildren).removeAttr('style')
			return

		###最初に一回高さ揃えを行う###
		if breakpointParts.css("float") isnt "none"
			equalizeFunc()
		return

	###
	トップページ戻るボタン
	------------------------------------
	###
	pageTopCreate = ->
		btnTop = $('#btn-top')
		btnTop.click (event) ->
			$('html,body').animate scrollTop: 0, 1000
			event.preventDefault()
			return
		return

	###
	RWDアコーディオン
	------------------------------------
	toggleBtn…アコーディオンのボタン要素
	toggleContent…アコーディオンのコンテンツ要素
	closeBtn…閉じるボタン
	_breakpointParts…ブレークポイントの要となる共通パーツ
	------------------------------------
	###
	createAccordion = (toggleBtn, toggleContent, closeBtn, _breakpointParts) ->
		###_breakpointPartsが指定されている時はbreakpointPartsに代入###
		if _breakpointParts isnt undefined
			breakpointParts = _breakpointParts
		$(toggleBtn).each ->
			###_breakpointPartsが指定されている時はsp時のみアコーディオンコンテンツを隠す###
			if breakpointParts
				if breakpointParts.css("float") is "none"
					$(this).next(toggleContent).hide()
			else
				###_breakpointPartsが指定されていない際はサイズ関係なく隠す###
				$(this).next(toggleContent).hide()
			return

		$(toggleBtn).click (event) ->
			###トグルの開閉処理。開いている時はボタンにcurrentクラスが付与される。_breakpointPartsが指定されている時はsp時のみ動作###
			if _breakpointParts
				if breakpointParts.css("float") is "none"
					nextContent = $(this).next(toggleContent)
					if nextContent.css('display') is 'block'
						$(this).removeClass('current')
					else
						$(this).addClass('current')
					nextContent.slideToggle()
					event.preventDefault()
				else
					event.preventDefault()
			else
				nextContent = $(this).next(toggleContent)
				if nextContent.css('display') is 'block'
					$(this).removeClass('current')
				else
					$(this).addClass('current')
				nextContent.slideToggle()
				event.preventDefault()
			return

		$(closeBtn).click (event) ->
			###閉じるボタンを押した際のトグルの閉じる処理。開いている時はボタンにcurrentクラスが付与される。_breakpointPartsが指定されている時は閉じるボタンのdata-scroll属性に入っているidにhashが指定される。###
			if _breakpointParts
				if breakpointParts.css("float") is "none"
					parentContent = $(this).parents(".toggle-content")
					beforetoggleBtn = $(this).parents(".toggle-content").prevAll(toggleBtn)
					if parentContent.css('display') is 'block'
						beforetoggleBtn.removeClass('current')
					else
						beforetoggleBtn.addClass('current')
					hasId = $(this).attr('data-scroll')
					if hasId
						location.hash = "";
						location.hash = hasId;
					parentContent.slideToggle()
					event.preventDefault()
					return
			else
				parentContent = $(this).parents(".toggle-content")
				beforetoggleBtn = $(this).parents(".toggle-content").prevAll(toggleBtn)
				if parentContent.css('display') is 'block'
					beforetoggleBtn.removeClass('current')
				else
					beforetoggleBtn.addClass('current')
				parentContent.slideToggle()
				event.preventDefault()
				return
			return

		###_breakpointPartsが指定されている時はリサイズ時にボタンの持つcurrentクラスの有無でアコーディオンコンテンツの表示非表示を切り替え###
		if _breakpointParts
			$(window).resize ->
				if breakpointParts.css("float") isnt "none"
					$(toggleBtn).each ->
						$(this).next(toggleContent).show()
						return
				else
					$(toggleBtn).each ->
						if $(this).hasClass('current')
							$(this).next(toggleContent).show()
						else
							$(this).next(toggleContent).hide()
						return
				return
		return

	###JavaScript処理開始###
	funcControll()

	return