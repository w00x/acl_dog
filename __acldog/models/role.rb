class Role < ActiveRecord::Base
	validates :nombre, presence: true
end
