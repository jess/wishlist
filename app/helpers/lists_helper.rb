module ListsHelper
  def share_title
    name = @list.user.name
    #CGI::escape("#{name} is using Wish List For All App to share a wish list with you")
    "#{name} is using Wish List For All App to share a wish list with you"
  end

  def share_url
    share_list_url(@list)
  end
end
