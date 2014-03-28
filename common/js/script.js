$(function(){
		var Wrapper = $("#box-mainvisual").prepend('<p class="back"><a href="#">前へ</a></p><p class="next"><a href="#">次へ</a></p>');
		var obj = $(Wrapper),		
		bnrList = $(obj).find("#list-main-visual"),
		bnrListWidth = 0,
		bnrItem = $(obj).find("#list-main-visual").find("li"),
		bnrItemLink = $(obj).find("#list-main-visual").find("li").find("a"),
		bnrNum = $(bnrItem).length,
		btnBack = $(obj).find(".back").find("a"),
		btnNext = $(obj).find(".next").find("a"),
		defaultImageSize = 838,//max-main-visual-size
		windowSize = $(window).width(),
		slideSpeed = 500, //slide speed
		loopSpeed = 5000, //loop speed
		anmFlg = false;

		//GET List width
		for(var i=0; bnrNum+1 > i; i++){
			bnrListWidth = bnrListWidth + $(bnrItem[i]).width();
		}

		//Write slide list width
		$(bnrList).css({width:bnrListWidth});
		$(bnrItem).css('display', 'table-cell');
		
		//reload
		reloadFunction();
		//resize
		resizeFunction();

		//Next Button
		$(btnNext).click(function(){
			moveSlide(true);
		});
		
		//Back Button
		$(btnBack).click(function(){
			moveSlide(false);
		});

		//Stop timer
		Wrapper.each(function(){
			$(this).mouseout(function(){
				console.log("stop timer(hover)");
				stopTimer(true,false);
			});

			$(this).mouseleave(function(){
				console.log("start timer(mouse out)");
				stopTimer(false,false);
			});
		});

		//Stop timer
		var arrayItem = [btnNext,btnBack];
		$.each(arrayItem, function(){	
			this.focus(function(){　// stop timer by focus
				console.log("ストップ・フォーカス");
				stopTimer(false,true);
			});
			this.blur(function(){　// start timer by focus out
				console.log("スタート・フォーカス");
				stopTimer(false,false);
			});
		});


		/* -----------------------------------
			Function
		----------------------------------- */

		//Reload
		function reloadFunction(){
			window.onload = function() {
				if(838 > windowSize){
					defaultImageSize = windowSize;
				}
			};
		}

		//Resize
		function resizeFunction() {
			$(window).resize(function() {
				windowSize = $(window).width();
				bnrListResize = bnrNum * windowSize;
				if(838<=windowSize){
					$(bnrItem).css(
						"width", 838
					);
					bnrList.css(
						"width", 838 * bnrNum
					);
					defaultImageSize = 838;
				}else if(838>windowSize){
					$(bnrItem).css(
						"width", windowSize
					);
					bnrList.css(
						"width", bnrListResize
					);
					defaultImageSize = windowSize;
				}
			});
		}

		//Slider
		function moveSlide(status) {
			if(anmFlg === false){
				anmFlg = true;
				//Animation move right	
				if(status === true) {
					$(bnrList).animate({marginLeft : -defaultImageSize},slideSpeed,function(){				
					$(bnrList).css({marginLeft : 0});
					$(bnrList).find("li:last").after($(bnrList).find("li").eq(0));
					anmFlg = false;
					});
					return false;
				//Animation move left
				}else if(status === false) {				
					$(bnrList).css({marginLeft : -defaultImageSize});
					$(bnrList).find("li").eq(0).before($(bnrList).find("li:last"));
					$(bnrList).animate({marginLeft : 0},slideSpeed,function(){
						anmFlg = false;
					}); 
					return false;
				}else{
					alert("error");
				}
			}else{
				return false;
			}
		}


	//Timer
	var loopSlideTimer = setInterval(function(){
		moveSlide(true);
		},loopSpeed);


		//Stop timer function
	function stopTimer(mouseOver, focusIn) {
		if(mouseOver === true && focusIn === false) {
			clearInterval(loopSlideTimer);
		}else if(mouseOver === false && focusIn === true) {
			clearInterval(loopSlideTimer);
		}else{
			loopSlideTimer = setInterval(
					function(){moveSlide(true);},loopSpeed);
					console.log("moveing");
		}
	}
});