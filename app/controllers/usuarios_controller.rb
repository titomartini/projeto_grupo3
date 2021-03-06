class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:new, :create]
  before_action :correct_usuario?, only: [:edit, :update, :destroy]
  
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
	@usuario = Usuario.find_by(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
	
    respond_to do |format|
      if @usuario.save
		
		session[:usuario_id] = @usuario.id
		if @usuario.tipo == "fa"
			format.html { redirect_to new_fa_path, notice: 'Usuario was successfully created.' }
			format.json { render :new, status: :created, location: @fa }
		else
		    format.html { redirect_to new_banda_path, notice: 'Usuario was successfully created.' }
			format.json { render :new, status: :created, location: @banda }
		end 
        #format.html { redirect_to @usuario, notice: 'Usuario was successfully created.' }
        #format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
	@usuario = Usuario.find_by(params[:id])
	if @usuario.update_attributes(usuario_params)
		redirect_to usuarios_path
	else
		render action: :edit
	end
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
	@usuario = Usuario.find_by(params[:id])
    @usuario.destroy
	sign_out
	redirect_to root_path
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:username, :password, :password_confirmation, :email, :tipo)
    end
end
