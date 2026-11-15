using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cadastroUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        string nome = txtNome.Text.Trim();
        string dataNasc = txtDataNasc.Text.Trim();
        string email = txtEmail.Text.Trim();
        string cpf = txtCpf.Text.Trim();
        string senha = txtSenha.Text.Trim();
        string telefone = txtTelefone.Text.Trim();

        // 1. Valida os campos obrigatórios da tabela tb_usuario
        if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(cpf) || string.IsNullOrEmpty(senha))
        {
            lblMensagem.Text = "Preencha pelo menos Nome, E-mail, CPF e Senha.";
            lblMensagem.Visible = true;
            return;
        }

        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

        string sql = @"INSERT INTO tb_usuario (nome, data_nascimento, cpf, email, senha, telefone) 
                       VALUES (@nome, @data_nascimento, @cpf, @email, @senha, @telefone)";

        try
        {
            using (SqlConnection con = new SqlConnection(strConexao))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@nome", nome);
                    cmd.Parameters.AddWithValue("@cpf", cpf);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@senha", senha);

                    // 2. Se data ou telefone ficarem em branco, envia NULL para o banco não dar erro
                    if (string.IsNullOrEmpty(dataNasc))
                        cmd.Parameters.AddWithValue("@data_nascimento", DBNull.Value);
                    else
                        cmd.Parameters.AddWithValue("@data_nascimento", dataNasc);

                    if (string.IsNullOrEmpty(telefone))
                        cmd.Parameters.AddWithValue("@telefone", DBNull.Value);
                    else
                        cmd.Parameters.AddWithValue("@telefone", telefone);

                    // 3. Abre a conexão e executa o INSERT
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // 4. Cadastro concluído: manda o usuário para fazer login
            Response.Redirect("login.aspx");
        }
        catch (SqlException ex)
        {
            // Códigos 2627 e 2601 significam violação de UNIQUE (CPF ou E-mail já cadastrado)
            if (ex.Number == 2627 || ex.Number == 2601)
            {
                lblMensagem.Text = "Este CPF ou E-mail já está cadastrado no sistema.";
            }
            else
            {
                lblMensagem.Text = "Erro ao salvar no banco: " + ex.Message;
            }
            lblMensagem.Visible = true;
        }
    }
}