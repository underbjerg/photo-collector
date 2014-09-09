// Author: Erik L. Underbjerg (erik@underbjerg.com)
// Small jQuery plugin for layouting a bunch of images to both fill and fit the width of the container,
// and preserve the aspect ratio of all the images
// The image elements must have an 'aspect-ratio' attribute, which should be equal to (width * 100 / height) of the image
// 
// Usage: $("#container-selector").initializeImageLayouter("img.element-selector");


(function( $ ) {
	
	var container;
	var imgSelector;
	var viewport_width;
	var ideal_height;
	var photo_margin = 7;
	
	function getDimensions() {
		//viewport_width = $(window).width() - 60;
		viewport_width = container.width();
		console.log("Container width: " + viewport_width);
	
		ideal_height = parseInt($(window).height() * 4 / 7);
		if(ideal_height > 480) {
			ideal_height = 480; // cap images to 480px in height
		}
	};
	
	function partition(imageElements) {
		var result = [];
	
		var current_row = [];
		var row_width = 0;
	
		$.each(imageElements, function(key, value) {
			var aspect = $(value).data('aspect-ratio');
			var ideal_width = Math.floor((ideal_height*aspect)/100);
			//console.log("element " + key + " with aspect ratio " + aspect + " has ideal height " + ideal_height + " and ideal width " + ideal_width);
		
			row_width += ideal_width;
			row_width += photo_margin; // Take photo margins into account
		
			var cell = {"element": value, "ideal_width": ideal_width, "ideal_height": ideal_height, "aspect": aspect};
			current_row.push(cell);
		
			if(row_width >= viewport_width) {
				//console.log("Current row " + current_row + " is wider than viewport (" + row_width + " vs. " + viewport_width + "). Starting new row");
				// Row has reach screen border, begin new row
				result.push(current_row);
				current_row = [];
				row_width = 0;
			}
		});
	
		return result;
	};

	function resizeRow(row) {
		var ideal_row_width = 0;
		$.each(row, function(key, cell){
			ideal_row_width += cell["ideal_width"] + photo_margin;
		});
	
		//console.log("Row is " + ideal_row_width + " wide, but viewport is only " + viewport_width);
	
		var shrink_ratio = viewport_width / ideal_row_width;
		var new_height = Math.floor(ideal_height * shrink_ratio);
	
		// resize elements
		$.each(row, function(key, cell){
			var new_width = Math.floor(cell["ideal_width"] * shrink_ratio);
			cell["element"].width = new_width;
			cell["element"].height = new_height;
		});
	};

	function resizePhotos() {
		getDimensions();

		var rows = partition($(imgSelector));		

		$.each(rows, function(key, row) {
			resizeRow(row);
		});
	};
	
 
    $.fn.initializeImageLayouter = function( elementSelector ) {
 
        container = this;
		imgSelector = elementSelector;
		
		resizePhotos();
		
		$(window).resize(function () {
			resizePhotos();
		});
		
		
		return this;
    };
	

	
 
}( jQuery ));




