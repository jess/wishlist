module ListsHelper
  def share_title
    @list.name
  end

  def share_description
    name = @list.user.name
    "#{name} is using Wish List For All App to share a wish list with you"
  end

  def share_url
    share_list_url(@list)
  end
end
