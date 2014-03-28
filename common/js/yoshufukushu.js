function() {

	$("h1").children().andSelf().contents().each(function() {
    	if (this.nodeType == 3) {
        	$(this).replaceWith($(this).text().replace(/(\S)/g, '<span>$1</span>'));
    	}
	});

});