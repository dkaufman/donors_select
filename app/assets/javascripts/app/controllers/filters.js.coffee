class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"
    "click .grade_button" : "gradeList"
    "click #math-science-button" : "showMathSubjects"
    "click #music-arts-button" : "showMusicSubjects"
    "click #literacy-language-button" : "showLiteracySubjects"
    "click #history-civics-button" : "showHistorySubjects"
    "click #applied-learning-button" : "showAppliedLearningSubjects"
    "click #health-sports-button" : "showHealthSubjects"
    "click .subject" : "subjectFilter"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @el.height(700)
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      $("#state-button").text(data.name)
      console.log(data.name)

  filterBySubject: (e) ->
    @el.height(150)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  # subjectFilter: (e) ->
  #   console.log($(e.target))

  showMathSubjects: (e) ->
    $("#math-science-subjects").show()
    $(".subject").hide()

  showMusicSubjects: (e) ->
    $("#music-art-subjects").show()
    $(".subject").hide()

  showLiteracySubjects: (e) ->
    $("#literacy-language-subjects").show()
    $(".subject").hide()

  showHistorySubjects: (e) ->
    $("#history-civics-subjects").show()
    $(".subject").hide()

  showAppliedLearningSubjects: (e) ->
    $("#applied-learning-subjects").show()
    $(".subject").hide()

  showHealthSubjects: (e) ->
    $("#health-sports-subjects").show()
    $(".subject").hide()

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))



window.Filterer = Filterer
