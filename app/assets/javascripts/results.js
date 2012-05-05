// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
/**
 * give the scrolling animation to folder image
 */
$().ready(function() {
	var $scrollingDiv = $("#scrollingDiv");
	$(window).scroll(function() {
		$scrollingDiv.stop().animate({
			"marginTop" : ($(window).scrollTop() + 30) + "px"
		}, "slow");
	});
});
