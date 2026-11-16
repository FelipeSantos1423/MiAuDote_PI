using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string senha = txtSenha.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(senha))
        {
            lblMensagem.Text = "Por favor, preencha o e-mail e a senha.";
            lblMensagem.Visible = true;
            return;
        }

        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            con.Open();

            // 1. Valida e-mail e senha
            string sql = "SELECT id_usuario, nome FROM tb_usuario WHERE email = @email AND senha = @senha AND status_conta = 'ATIVO'";
            string idUsuario = null;
            string nomeUsuario = null;

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@senha", senha);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        idUsuario = reader["id_usuario"].ToString();
                        nomeUsuario = reader["nome"].ToString();
                    }
                }
            }

            if (idUsuario == null)
            {
                lblMensagem.Text = "E-mail ou senha inválidos.";
                lblMensagem.Visible = true;
                return;
            }

            // 2. Verifica na tb_usuario_cargo se esse usuário é ADMINISTRADOR
            string sqlAdmin = @"SELECT COUNT(*) 
                                FROM tb_usuario_cargo uc
                                INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                                WHERE uc.id_usuario = @id_usuario 
                                  AND c.nome_cargo = 'ADMINISTRADOR'
                                  AND uc.status_aprovacao = 'ATIVO'";

            bool isAdmin = false;
            using (SqlCommand cmdCargo = new SqlCommand(sqlAdmin, con))
            {
                cmdCargo.Parameters.AddWithValue("@id_usuario", idUsuario);
                isAdmin = (Convert.ToInt32(cmdCargo.ExecuteScalar()) > 0);
            }

            // 2.1 Verifica se é ADMINISTRADOR ou PROTETOR para liberar o botão do dashboard
            string sqlDash = @"SELECT COUNT(*) 
                               FROM tb_usuario_cargo uc
                               INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                               WHERE uc.id_usuario = @id_usuario 
                                 AND c.nome_cargo IN ('ADMINISTRADOR', 'PROTETOR')
                                 AND uc.status_aprovacao = 'ATIVO'";

            bool podeDashboard = false;
            using (SqlCommand cmdDash = new SqlCommand(sqlDash, con))
            {
                cmdDash.Parameters.AddWithValue("@id_usuario", idUsuario);
                podeDashboard = (Convert.ToInt32(cmdDash.ExecuteScalar()) > 0);
            }

            // 3. Salva tudo na Session
            Session["id_usuario"] = idUsuario;
            Session["nome_usuario"] = nomeUsuario;
            Session["is_admin"] = isAdmin;
            Session["pode_dashboard"] = podeDashboard;

            // 4. Manda para a página de origem (?retorno=...) ou direto para o painel certo
            string paginaRetorno = Request.QueryString["retorno"];

            if (!string.IsNullOrEmpty(paginaRetorno))
                Response.Redirect(paginaRetorno);
            else if (isAdmin)
                Response.Redirect("dashboardAdmin.aspx");
            else
                Response.Redirect("animais.aspx");
        }
    }
}