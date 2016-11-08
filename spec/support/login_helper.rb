module LoginHelper
  def login(user)
    session[:user_id] = user.id
  end
end
