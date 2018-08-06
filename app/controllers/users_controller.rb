class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
   @users = User.all
    unless logged_in?
      redirect_to login_path, :flash => { :danger => "Pour accéder à cette page, il faut d'abord vous connecter." }
      end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless logged_in?
      redirect_to login_path, :flash => { :danger => "Pour accéder à cette page, il faut d'abord vous connecter." }
      end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'Bienvenue à toi nouveau Moussaillon' }
        format.json { render :show, status: :created, location: @user }
      else
        flash[:danger] = "Email déjà existant OU Erreur de saisie - Verifier vos champs"
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'Ton profil a bien été modifié' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Oh non! On vient de perdre un Moussaillon :sob: !' }
      format.json { head :no_content }
    end
  end

   def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

     # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
        redirect_to root_url, :flash => { :danger => "Pour accéder à cette page, il faut d'abord vous connecter." } unless current_user?(@user)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
