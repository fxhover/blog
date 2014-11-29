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
//= require turbolinks
//= require bootstrap
//= require twitter/bootstrap/rails/confirm
//= require html5shiv.min.js
//= require respond.min.js
//= require markdown-toolbar
//= require jquery.remotipart
//= require social-share-button
//= require_tree .

$.fn.twitter_bootstrap_confirmbox.defaults = {
    title: '提示',
    cancel: '取消',
    cancel_class: 'btn cancel',
    proceed: '确定',
    proceed_class: 'btn proceed btn-primary'
}

//markdown preview
function preview(text_area_id, content_id){
    content = $('#' + text_area_id).val();
    $.post('/blogs/preview', {content: content}, function(data){
       if (data.status){
           $('#' + content_id).html(data.message);
       }
    });
}