console.log window.location.pathname
# console.log parent.location.pathname

parent.history.pushState {}, '', window.location.pathname
