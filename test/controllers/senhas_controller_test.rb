require 'test_helper'

class SenhasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @senha = senhas(:one)
  end

  test "should get index" do
    get senhas_url
    assert_response :success
  end

  test "should get new" do
    get new_senha_url
    assert_response :success
  end

  test "should create senha" do
    assert_difference('Senha.count') do
      post senhas_url, params: { senha: { chamado: @senha.chamado, dataChamado: @senha.dataChamado, dataGeracao: @senha.dataGeracao, dataRechamado: @senha.dataRechamado, isPrioritario: @senha.isPrioritario, rechamado: @senha.rechamado, senha: @senha.senha, setor_id: @senha.setor_id, usuario_id: @senha.usuario_id } }
    end

    assert_redirected_to senha_url(Senha.last)
  end

  test "should show senha" do
    get senha_url(@senha)
    assert_response :success
  end

  test "should get edit" do
    get edit_senha_url(@senha)
    assert_response :success
  end

  test "should update senha" do
    patch senha_url(@senha), params: { senha: { chamado: @senha.chamado, dataChamado: @senha.dataChamado, dataGeracao: @senha.dataGeracao, dataRechamado: @senha.dataRechamado, isPrioritario: @senha.isPrioritario, rechamado: @senha.rechamado, senha: @senha.senha, setor_id: @senha.setor_id, usuario_id: @senha.usuario_id } }
    assert_redirected_to senha_url(@senha)
  end

  test "should destroy senha" do
    assert_difference('Senha.count', -1) do
      delete senha_url(@senha)
    end

    assert_redirected_to senhas_url
  end
end
