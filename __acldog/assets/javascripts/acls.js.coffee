# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('#action_check').on 'click', ->
		act = $(this).prop 'checked'
		
		if act
			$("#acl_action").val '[all]'
		else
			$("#acl_action").val ''

	$('#controller_check').on 'click', ->
		con = $(this).prop 'checked'
		
		if con
			$("#acl_controller").val '[all]'
		else
			$("#acl_controller").val ''