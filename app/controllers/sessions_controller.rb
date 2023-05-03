require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionView.new
  end

  def sign_in
    # 1. Perguntar qual o username do usuário
    username = @view.ask_username
    # 2. Perguntar qual a senha do user
    password = @view.ask_password
    # 3. Procurar no repositório, o employee a partir do username recebido
    employee = @employee_repository.find_by_username(username) 

    # 4. Verificar se a senha está correta
    if employee && password == employee.password
    # 4.1 Caso a senha estiver correta, retornamos o employee
      return employee
    # 4.2 Caso a senha esteja INCORRETA, pedir novamente as credenciais.
    else
      @view.wrong_credentials
      sign_in
    end
  end
end