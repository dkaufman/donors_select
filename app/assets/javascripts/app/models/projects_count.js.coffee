class ProjectsCount extends Spine.Model
  @configure 'ProjectsCount', 'count'
  @extend Spine.Model.Ajax

  @url = "/projects_counts"

window.ProjectsCount = ProjectsCount