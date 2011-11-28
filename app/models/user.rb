class User < ActiveRecord::Base
  has_many :lists

  def self.create_fb_user(auth,graph)
    create! do |user|
      graph = graph.get_object("me")
      user.uid = auth['user_id']
      user.name = graph["name"]
      user.email = graph["email"]
    end
  end
  
end
