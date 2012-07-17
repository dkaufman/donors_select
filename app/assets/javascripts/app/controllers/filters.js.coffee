class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"
    "click .grade_button" : "gradeList"

  constructor: ->
    super

  filterByState: (e) ->
    $(".filter_button").removeClass("active")
    $("#state-button").addClass("active")
    @filterActions.empty()
    @el.height(700)
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      $("path").attr "class", "state"
      $("path").attr "fill", "#333"
      $("rect").attr "fill", "#333"
      $(event.originalEvent.target).attr "fill", "#FF0000"
      $(event.originalEvent.target).attr "style", "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "
      $(event.originalEvent.target).attr "class", "active-state"
      console.log $(event.originalEvent.target)
      $("#state-button").text "State: "+data.name

  filterBySubject: (e) ->
    $(".filter_button").removeClass("active")
    $("#subject-button").addClass("active")
    @el.height(150)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    $(".filter_button").removeClass("active")
    $("#grade-button").addClass("active")
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))

window.Filterer = Filterer