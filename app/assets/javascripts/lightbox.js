function initializeLightbox() {
	//console.log("initializing magnific");
	$('#photo-container').magnificPopup({
	  delegate: 'a.view', // child items selector, by clicking on it popup will open
	  type: 'image',
	  closeOnContentClick: true,
	  // other options
	  gallery: {enabled:true},
	  mainClass: 'mfp-img-mobile mfp-no-margins',
	  closeBtnInside: false,
	  fixedContentPos: true,
	  //mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
	  image: {
		  verticalFit: true,
		  titleSrc: function(item) {
		  	return  " <a href='" + item.el.attr('data-fullsize') + "' download class='' title='Download image'>DOWNLOAD</a>  "
					//+ " &middot; " + item.el.attr('title')
					+'<small>' 
						+ item.el.attr('data-capture-time') 					
						+ " (by " + (item.el.attr('data-user') ? item.el.attr('data-user') : 'Ukendt bruger') + ")" 					+ '</small>';
		  }
	  }
	});
}
