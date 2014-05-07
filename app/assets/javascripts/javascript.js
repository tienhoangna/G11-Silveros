// JavaScript Document
$(document).ready(function(e) {
    $(".typingArea").click(function(e) {
        $(this).animate({height: "122px"}).css("background", "url(images/typing-area2.png)").css("background-repeat", "no-repeat");
		$(".typingArea textarea").css("display", "block");
		document.getElementById("typing").focus();
		$("#all").css("height", "1580px");
    });
	
	$(".typingArea textarea").blur(function(e){
		$(this).css("display", "none");
		$(".typingArea").animate({height: "55px"}).css("background", "url(images/typing-area.png)").css("background-repeat", "no-repeat");
		$("#all").css("height", "1510px");
	})
	
	$("#searchBar").focus(function(){
		document.getElementById("searchBar").value = "";
	})
	
	$("#searchBar").blur(function(){
		document.getElementById("searchBar").value = "Enter name you want to search...";	
	})
	
	$(".rightArrow").click(function(e) {
        $(".each").slideUp(100);
		$(".eachNext").slideDown(100);
    });
	
	$(".leftArrow").click(function(e) {
        $(".each").slideDown(100);
		$(".eachNext").slideUp(100);
    });
});