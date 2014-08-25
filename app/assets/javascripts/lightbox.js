function initializeLightbox() {
	//console.log("initializing magnific");
	$('#photo-container').magnificPopup({
	  delegate: 'a.view', // child items selector, by clicking on it popup will open
	  type: 'image',
	  // other options
	  gallery: {enabled:true},
	  image: {
		  titleSrc: function(item) {
		  	return  " <a href='" + item.el.attr('data-fullsize') + "' download class='' title='Download image'>DOWNLOAD</a>"
					+ " " + item.el.attr('title')
					+'<small>' 
						+ item.el.attr('data-capture-time') 					
						+ " (" + (item.el.attr('data-user') ? item.el.attr('data-user') : 'Ukendt bruger') + ")" 					+ '</small>';
		  }
	  }
	});
}
