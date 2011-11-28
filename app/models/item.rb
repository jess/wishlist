class Item < ActiveRecord::Base
  belongs_to :list
  validates_format_of :url, :with => URI::regexp(%w(http https)), :if => :url?
end
