class SenhasController < ApplicationController
  before_action :set_senha, only: [:show, :edit, :update, :destroy]

  # GET /senhas
  # GET /senhas.json
  def index
    @senhas = Senha.all
  end

  # GET /senhas/1
  # GET /senhas/1.json
  def show
  end

  # GET /senhas/new
  def new
    @senha = Senha.new
  end

  # GET /senhas/1/edit
  def edit
  end

  # POST /senhas
  # POST /senhas.json
  def create
    @senha = Senha.new(senha_params)

    respond_to do |format|
      if @senha.save
        format.html { redirect_to @senha, notice: 'Senha was successfully created.' }
        format.json { render :show, status: :created, location: @senha }
      else
        format.html { render :new }
        format.json { render json: @senha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /senhas/1
  # PATCH/PUT /senhas/1.json
  def update
    respond_to do |format|
      if @senha.update(senha_params)
        format.html { redirect_to @senha, notice: 'Senha was successfully updated.' }
        format.json { render :show, status: :ok, location: @senha }
      else
        format.html { render :edit }
        format.json { render json: @senha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /senhas/1
  # DELETE /senhas/1.json
  def destroy
    @senha.destroy
    respond_to do |format|
      format.html { redirect_to senhas_url, notice: 'Senha was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def call
    senha = Senha.where(chamado: true, dataChamado: nil).limit(1)
    for senhaChamada in senha.each
      senhaChamada.dataChamado = DateTime.now;
      senhaChamada.save;
    end
    # senha.save
    if(senhaChamada == nil)
      senha = Senha.where(rechamado: true, dataRechamado: nil, setor_id: 1).limit(1)
      for senhaChamada in senha.each
        senhaChamada.dataRechamado = DateTime.now;
        senhaChamada.save;
      end
      if(senhaChamada == nil)
        render json: {nothing: 1}
      else
        render json: senhaChamada
      end
    else
      render json: senhaChamada
    end
  end

  def callNext
    senha = Senha.where(chamado: false, dataChamado: nil, setor_id: 1).limit(1)
    for senhaChamada in senha.each
      senhaChamada.chamado = 1;
      senhaChamada.save;
    end
    # senha.save
    if(senhaChamada == nil)
      senha = Senha.where(rechamado: false, dataRechamado: nil, setor_id: 1).limit(1)
      for senhaChamada in senha.each
        senhaChamada.rechamado = 1;
        senhaChamada.save;
      end
      if(senhaChamada == nil)
        render json: {nothing: 1}
      else
        render json: senhaChamada
      end
      render json: {nothing: 1}
    else
      render json: senhaChamada
    end
  end

  def recall
    senha = Senha.where(rechamado: false, dataRechamado: nil, setor_id: 1, id: :id).limit(1)
    for senhaChamada in senha.each
      senhaChamada.rechamado = 1;
      senhaChamada.save;
    end
    if(senhaChamada == nil)
      render json: {nothing: 1}
    else
      render json: senhaChamada
    end
  end

  def last3
    render json: Senha.where(chamado: true).where.not(dataChamado: nil).order('-id').limit(3);
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_senha
      @senha = Senha.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def senha_params
      params.require(:senha).permit(:senha, :dataGeracao, :chamado, :dataChamado, :rechamado, :dataRechamado, :isPrioritario, :setor_id, :usuario_id)
    end
end
