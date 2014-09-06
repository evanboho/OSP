$('.comment[data-comment-id="<%= @comment.id %>').slideUp 'fast', ->
  $(@).remove()

  appr = $('.comment[data-approved="true"]').length
  unappr = $('.comment[data-approved="false"]').length

  $('h3#approved-comments-count .count').text(appr)
  $('h3#unapproved-comments-count .count').text(unappr)
