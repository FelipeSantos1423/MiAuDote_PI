using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class inscricaoVoluntario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["id_usuario"] == null)
        {
            Response.Redirect("login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            CarregarDadosUsuario();
        }
    }

    private void CarregarDadosUsuario()
    {
        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;
        string sql = "SELECT nome, data_nascimento, email, cpf FROM tb_usuario WHERE id_usuario = @id";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", Session["id_usuario"].ToString());
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtNome.Text = dr["nome"].ToString();
                    txtEmail.Text = dr["email"].ToString();
                    txtCpf.Text = dr["cpf"].ToString();

                    if (dr["data_nascimento"] != DBNull.Value)
                    {
                        DateTime dataNasc = Convert.ToDateTime(dr["data_nascimento"]);
                        txtDataNasc.Text = dataNasc.ToString("dd/MM/yyyy");
                    }
                }
            }
        }
    }

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        // 1. Verifica se pelo menos um animal foi marcado
        if (!chkCachorro.Checked && !chkGato.Checked)
        {
            lblMensagem.Style["color"] = "#C95A3B";
            lblMensagem.Text = "Selecione pelo menos um tipo de animal (Cachorro ou Gato).";
            lblMensagem.Visible = true;
            return;
        }

        // 2. Verifica se o motivo foi preenchido
        string motivo = txtMotivo.Text.Trim();
        if (string.IsNullOrEmpty(motivo))
        {
            lblMensagem.Style["color"] = "#C95A3B";
            lblMensagem.Text = "Por favor, conte o motivo pelo qual deseja ser voluntário.";
            lblMensagem.Visible = true;
            return;
        }

        // 3. Monta o texto da disponibilidade de animais conforme os CheckBoxes marcados
        string disponibilidadeAnimais;
        if (chkCachorro.Checked && chkGato.Checked)
            disponibilidadeAnimais = "Cachorro e Gato";
        else if (chkCachorro.Checked)
            disponibilidadeAnimais = "Cachorro";
        else
            disponibilidadeAnimais = "Gato";

        // 4. Converte o RadioButtonList ("1" ou "0") para bool (tipo BIT no SQL Server)
        bool disponibilidadeLocal = (rblLocal.SelectedValue == "1");
        int idUsuario = Convert.ToInt32(Session["id_usuario"]);

        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;
        string sql = @"INSERT INTO tb_inscricao_protetor_voluntario 
                       (id_usuario, disponibilidade_animais, disponibilidade_local, motivo)
                       VALUES (@id_usuario, @disponibilidade_animais, @disponibilidade_local, @motivo)";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                cmd.Parameters.AddWithValue("@disponibilidade_animais", disponibilidadeAnimais);
                cmd.Parameters.AddWithValue("@disponibilidade_local", disponibilidadeLocal);
                cmd.Parameters.AddWithValue("@motivo", motivo);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // 5. Limpa os campos da inscrição e exibe confirmação
        chkCachorro.Checked = false;
        chkGato.Checked = false;
        txtMotivo.Text = "";

        lblMensagem.Style["color"] = "#4E7A5B";
        lblMensagem.Text = "Inscrição enviada com sucesso! Ela está em análise pela nossa equipe.";
        lblMensagem.Visible = true;
    }
}