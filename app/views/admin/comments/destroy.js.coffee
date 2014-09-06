$('.comment[data-comment-id="<%= @comment.id %>').slideUp 'fast', ->
  $(@).remove()

  Comment.updateCommentCounts()
