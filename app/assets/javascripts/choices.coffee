# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#choices').on 'cocoon:after-insert', ->
    if $('#choices .nested-fields').length >= 0
        $('#add-choice　a.').hide();
    else
        $('#add-choice').show();
        $('#demo1').text('hoge1');
