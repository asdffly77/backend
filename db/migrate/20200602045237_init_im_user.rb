class InitImUser < ActiveRecord::Migration[6.0]
  def change
    User.all.each(&:create_im_user)
  end
end
