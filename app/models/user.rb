class User < ActiveRecord::Base
  attr_accessible :cell_number, :email, :password_digest
end
