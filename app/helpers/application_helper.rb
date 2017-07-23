module ApplicationHelper
  # workaround for agglomerating content_for bug
  # e.g. calling `content_for :foo` multiple times makes all
  # prior calls of `content_for :foo` render alongside new content when calling `yield :foo`
  def yield_content!(key)
    view_flow.content.delete(key)
  end
end
