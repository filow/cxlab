class Manage::Profession < ActiveRecord::Base
    has_many :students
end
