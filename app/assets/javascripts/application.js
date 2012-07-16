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
	$("input.date_picker").datepicker({
	    format: 'mm/dd/yyyy',
		autoclose: true
	});
	
	$("#expansion-link").click(function(e) {
	    e.preventDefault();
		if($(this).text().toLowerCase().indexOf("expand") >= 0){
			$(this).html("Collapse All <i class='icon-resize-small'></i>")
			$(".accordion-body").css('height', 'auto')
		}
		else{
			$(this).html("Expand All <i class='icon-resize-full'></i>")
			$(".accordion-body").css('height', '0px')
		}
		return false;
	});
	
	$("a.delete-confirm").click(function(e) {
	    e.preventDefault();
		var deleteHref = this.href;
	    bootbox.confirm("Are you sure you want to delete this child? This action cannot be undone.", "Cancel", "Delete", {
			'classname': 'btn-danger',
			'callback': function(result) {
			    if (result) {
					$('<form method="post" action="' + deleteHref.replace('/delete', '') + '" />')
		                .append('<input type="hidden" name="_method" value="delete" />')
		                .append('<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />')
		                .appendTo('body')
		                .submit();
			    }
			}
		}, {
			'header': 'Delete Confirm',
			'headerCloseButton': false,
			'animate': false
		});
		return false;
	});
	
	$("a.delete-user-confirm").click(function(e) {
	    e.preventDefault();
		var deleteHref = this.href;
	    bootbox.confirm("Are you sure you want to delete this user? This action cannot be undone.", "Cancel", "Delete", {
			'classname': 'btn-danger',
			'callback': function(result) {
			    if (result) {
					$('<form method="post" action="' + deleteHref.replace('/delete', '') + '" />')
		                .append('<input type="hidden" name="_method" value="delete" />')
		                .append('<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />')
		                .appendTo('body')
		                .submit();
			    }
			}
		}, {
			'header': 'Delete Confirm',
			'headerCloseButton': false,
			'animate': false
		});
		return false;
	});
	
	$("a.upload-link").click(function(e) {
	    e.preventDefault();
		var childId = this.href.substring(this.href.lastIndexOf('/')+1, this.href.length)

		var photoForm = '<form id="child-photo-form" enctype="multipart/form-data" method="post" action="/kibera_children/' + childId + '/child_photos' + '">'
			+ '<input type="hidden" name="_method" value="post" />'
            + '<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />'
			+ '<input type="hidden" name="kibera_child_id" value="' + childId + '" />'
			+ '<label for="image">Child Photo:</label>'
			+ '<input type="file" id="image" name="image"/>'
			+ '</form>';

		bootbox.dialog(photoForm, [{
		    "label" : "Cancel"
		}, {
		    "label" : "Upload",
		    "callback" : function() {
				$('#child-photo-form').ajaxForm({
					dataType: 'json',
					success: function(response, status){
						$('ul.thumbnails').append('<li class="span3"><a rel="nofollow" href="/kibera_children/' + response.kibera_child_id + '" data-method="delete" class="thumbnail delete-photo-confirm" title="Delete This Photo" id="' + response.id + '"><img alt="" onerror="displayImageError(this);" src="' + response.image.url + '"/><img alt="Cancel" class="cancel-photo-img" src="/assets/cancel.png"/></a></li>');
						$('ul.thumbnails #' + response.id).on('click', deletePhotoConfirm);
						$('.delete-images-info').show();
					},
					error: function(jqXHR, status, error){
						var errorMsg;
						if(error && error != 'OK'){
							errorMsg = error;
						}
						else if($.parseJSON(jqXHR.responseText).errors){
							//TODO what if multiple model object errors occur on save?
							errorMsg = $.parseJSON(jqXHR.responseText).errors;
						}
						else{
							errorMsg = "please try again later.";
						}
						showErrorNotification('An error occurred during image upload: ' + errorMsg);
					}
				});
		        $('#child-photo-form').submit();
		    }
		}], {
			'header': 'Photo Uploader'
		});
		return false;
	});
	
	$("a.delete-aws-photo-confirm").click(function(e){
		e.preventDefault();
		var photoLink = $(this);
		var href = photoLink.attr('href');
		var photoId = photoLink.attr('id');
		var childId = href.substring(href.lastIndexOf('/')+1, href.length);

		bootbox.dialog("Are you sure you want to delete this photo? This action cannot be undone.", [{
		    "label" : "Cancel"
		}, {
		    "label" : "Delete",
			"class" : 'btn-danger',
		    "callback" : function() {
				var deletePhotoForm = $('<form id="delete-aws-photo-form" method="delete" action="/kibera_children/' + childId + '/child_photos/aws">')
					.append('<input type="hidden" name="_method" value="delete" />')
		            .append('<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />')
					.append('<input type="hidden" name="kibera_child_id" value="' + childId + '" />')
					.append('<input type="hidden" name="id" value="aws" />')
					.append('<input type="hidden" name="key" value="' + photoId + '" />')
	                .appendTo('body').ajaxForm({
						dataType: 'json',
						success: function(response, status){
							photoLink.parent().remove();
							if($('ul.thumbnails li').length <= 0){
								$('.delete-images-info').hide();
							}
						},
						error: function(jqXHR, status, error){
							var errorMsg;
							if(error && error != 'OK'){
								errorMsg = error;
							}
							else if($.parseJSON(jqXHR.responseText).errors){
								//TODO what if multiple model object errors occur on save?
								errorMsg = $.parseJSON(jqXHR.responseText).errors;
							}
							else{
								errorMsg = "please try again later.";
							}
							showErrorNotification('An error occurred during image delete: ' + errorMsg);
						}
					}).submit();
		    }
		}], {
			'header': 'Delete Confirm'
		});
		return false;
	});
	
	$("a.delete-photo-confirm").click(deletePhotoConfirm);
});

var deletePhotoConfirm = function(e){
	e.preventDefault();
	var photoLink = $(this);
	var href = photoLink.attr('href');
	var photoId = photoLink.attr('id');
	var childId = href.substring(href.lastIndexOf('/')+1, href.length);
	
	bootbox.dialog("Are you sure you want to delete this photo? This action cannot be undone.", [{
	    "label" : "Cancel"
	}, {
	    "label" : "Delete",
		"class" : 'btn-danger',
	    "callback" : function() {
			var deletePhotoForm = $('<form id="delete-photo-form" method="delete" action="/kibera_children/' + childId + '/child_photos/' + photoId + '">')
				.append('<input type="hidden" name="_method" value="delete" />')
	            .append('<input type="hidden" name="authenticity_token" value="' + AUTH_TOKEN + '" />')
				.append('<input type="hidden" name="kibera_child_id" value="' + childId + '" />')
				.append('<input type="hidden" name="id" value="' + photoId + '" />')
                .appendTo('body').ajaxForm({
					dataType: 'json',
					success: function(response, status){
						photoLink.parent().remove();
						if($('ul.thumbnails li').length <= 0){
							$('.delete-images-info').hide();
						}
					},
					error: function(jqXHR, status, error){
						var errorMsg;
						if(error && error != 'OK'){
							errorMsg = error;
						}
						else if($.parseJSON(jqXHR.responseText).errors){
							//TODO what if multiple model object errors occur on save?
							errorMsg = $.parseJSON(jqXHR.responseText).errors;
						}
						else{
							errorMsg = "please try again later.";
						}
						showErrorNotification('An error occurred during image delete: ' + errorMsg);
					}
				}).submit();
	    }
	}], {
		'header': 'Delete Confirm'
	});
	return false;
};

function showErrorNotification(msg){
	var errorHtml = '<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a>' + msg + '</div>';
	$('#content').before(errorHtml);
};

function displayImageError(elm){
	$(elm).attr('src', '/assets/image-failure.png');
};
