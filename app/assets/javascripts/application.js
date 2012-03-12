// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {
	$("a.delete-confirm").click(function(e) {
	    e.preventDefault();
		var deleteHref = this.href;
	    bootbox.confirm("Are you sure you want to delete this child?", function(result) {
		    if (result) {
				$('<form method="post" action="' + deleteHref.replace('/delete', '') + '" />')
	                .append('<input type="hidden" name="_method" value="delete" />')
	                .append('<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />')
	                .appendTo('body')
	                .submit();
		    }
		});
		return false;
	});
});