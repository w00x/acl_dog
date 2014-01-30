class Acl < ActiveRecord::Base
  belongs_to :role

  validates :action, presence: true
  validates :controller, presence: true
  validates :role_id, numericality: true
end
