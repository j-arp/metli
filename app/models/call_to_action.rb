class CallToAction < ActiveRecord::Base
  belongs_to :chapter
  has_many :actions
end
