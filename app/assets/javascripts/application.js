// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widget

//= require bootstrap.min

// The Templates plugin is included to render the upload/download listings -->
//= require javascript-templates/js/tmpl.min.js
// The Load Image plugin is included for the preview images and image resizing functionality -->
//= require javascript-load-image/js/load-image.min.js

// The Iframe Transport is required for browsers without support for XHR file uploads -->
//= require jquery-file-upload/js/jquery.iframe-transport.js
// The basic File Upload plugin -->
//= require jquery-file-upload/js/jquery.fileupload.js
// The File Upload processing plugin -->
//= require jquery-file-upload/js/jquery.fileupload-process.js
// The File Upload image preview & resize plugin -->
//= require jquery-file-upload/js/jquery.fileupload-image.js
// The File Upload audio preview plugin -->
// require jquery-file-upload/js/jquery.fileupload-audio.js
// The File Upload video preview plugin -->
// require jquery-file-upload/js/jquery.fileupload-video.js
// The File Upload validation plugin -->
//= require jquery-file-upload/js/jquery.fileupload-validate.js
// The File Upload user interface plugin -->
//= require jquery-file-upload/js/jquery.fileupload-ui.js

//  require facebook

//= require magnific-popup
//= require imagesloaded.pkgd.min.js

//= require lightbox



var viewport_width;
var ideal_height;
var photo_margin = 7;

function getDimensions() {
	var container = $("body > div.container-fluid");
	//viewport_width = $(window).width() - 60;
	viewport_width = $(container).width();
	console.log("Container width: " + viewport_width);
	
	ideal_height = parseInt($(window).height() / 2);
}
	
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
}

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
}

function resizePhotos() {
	getDimensions();
	
	/*
	if(viewport_width < 768) {
		// For small screens, just let CSS handle the sizing
		$.each($(".photo-elem img"), function(key, value) {
			$(value).width = "";
			$(value).height = "";
		});
	} else {
	*/
		var rows = partition($(".photo-elem img"));		
		//console.log("Rows: " + rows);
	
		$.each(rows, function(key, value) {
			resizeRow(value);
		});
		//}
	
}