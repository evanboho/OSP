$('.comment.featurebox[data-comment-id="<%= @comment.id %>"]').fadeOut ->
  $(@).remove()

  box = if <%= @comment.approved? %> then '#approved-box' else '#unapproved-box'

  $(box).prepend "<%= j render 'comments/comment', comment: @comment %>"

  Comment.updateCommentCounts()
