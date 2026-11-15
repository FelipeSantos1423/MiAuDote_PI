using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class animais : System.Web.UI.Page
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
            CarregarPets();
        }
    }

    private void CarregarPets()
    {
        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;
        string sql = "SELECT id_animal, nome, especie, raca, idade, porte, genero, historia FROM tb_animal WHERE status_animal = 'DISPONIVEL' ORDER BY id_animal DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptPets.DataSource = dt;
                        rptPets.DataBind();
                    }
                    else
                    {
                        lblAviso.Visible = true;
                    }
                }
            }
        }
    }

    protected void rptPets_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Conhecer")
        {
            string idAnimal = e.CommandArgument.ToString();
            hfIdAnimal.Value = idAnimal;

            string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

            using (SqlConnection con = new SqlConnection(strConexao))
            {
                con.Open();

                string sqlPet = "SELECT nome, especie, porte, idade, historia FROM tb_animal WHERE id_animal = @id";
                using (SqlCommand cmdPet = new SqlCommand(sqlPet, con))
                {
                    cmdPet.Parameters.AddWithValue("@id", idAnimal);
                    SqlDataReader drPet = cmdPet.ExecuteReader();
                    if (drPet.Read())
                    {
                        litModalNome.Text = drPet["nome"].ToString();
                        litModalSubtitulo.Text = drPet["especie"] + " • Porte " + drPet["porte"] + " • " + drPet["idade"];
                        litModalHistoria.Text = drPet["historia"].ToString();
                    }
                    drPet.Close();
                }

                string sqlUser = "SELECT nome, cpf, telefone, email FROM tb_usuario WHERE id_usuario = @id_usuario";
                using (SqlCommand cmdUser = new SqlCommand(sqlUser, con))
                {
                    cmdUser.Parameters.AddWithValue("@id_usuario", Session["id_usuario"].ToString());
                    SqlDataReader drUser = cmdUser.ExecuteReader();
                    if (drUser.Read())
                    {
                        txtAdotanteNome.Text = drUser["nome"].ToString();
                        txtAdotanteCpf.Text = drUser["cpf"].ToString();
                        txtAdotanteTelefone.Text = drUser["telefone"].ToString();
                        txtAdotanteEmail.Text = drUser["email"].ToString();
                    }
                    drUser.Close();
                }
            }

            lblModalMensagem.Visible = false;
            pnlModalAdocao.Visible = true;
        }
    }

    protected void btnFecharModal_Click(object sender, EventArgs e)
    {
        pnlModalAdocao.Visible = false;
    }

    protected void btnQueroAdotar_Click(object sender, EventArgs e)
    {
        // 1. Verifica se os campos do adotante estão preenchidos
        if (string.IsNullOrWhiteSpace(txtAdotanteNome.Text) ||
            string.IsNullOrWhiteSpace(txtAdotanteCpf.Text) ||
            string.IsNullOrWhiteSpace(txtAdotanteTelefone.Text) ||
            string.IsNullOrWhiteSpace(txtAdotanteEmail.Text))
        {
            lblModalMensagem.Style["color"] = "#C95A3B";
            lblModalMensagem.Text = "Preencha todos os seus dados antes de enviar.";
            lblModalMensagem.Visible = true;
            return;
        }

        int idUsuario = Convert.ToInt32(Session["id_usuario"]);
        int idAnimal = Convert.ToInt32(hfIdAnimal.Value);
        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            con.Open();

            // 2. Insere na tb_formulario_adocao e captura o id_formulario recém-criado
            string sqlForm = @"INSERT INTO tb_formulario_adocao (id_adotante, tipo_moradia, possui_outros_animais, motivo_adocao)
                               VALUES (@id_adotante, 'CASA', 0, 'Solicitação realizada pelo catálogo de pets.');
                               SELECT SCOPE_IDENTITY();";

            int idFormulario;
            using (SqlCommand cmdForm = new SqlCommand(sqlForm, con))
            {
                cmdForm.Parameters.AddWithValue("@id_adotante", idUsuario);
                idFormulario = Convert.ToInt32(cmdForm.ExecuteScalar());
            }

            // 3. Grava a solicitação na tb_solicitacao_adocao
            string sqlSolicitacao = @"INSERT INTO tb_solicitacao_adocao (id_animal, id_adotante, id_formulario)
                                      VALUES (@id_animal, @id_adotante, @id_formulario)";

            using (SqlCommand cmdSol = new SqlCommand(sqlSolicitacao, con))
            {
                cmdSol.Parameters.AddWithValue("@id_animal", idAnimal);
                cmdSol.Parameters.AddWithValue("@id_adotante", idUsuario);
                cmdSol.Parameters.AddWithValue("@id_formulario", idFormulario);
                cmdSol.ExecuteNonQuery();
            }
        }

        // 4. Mostra confirmação na tela
        lblModalMensagem.Style["color"] = "#4E7A5B";
        lblModalMensagem.Text = "Solicitação de adoção enviada com sucesso! Entraremos em contato.";
        lblModalMensagem.Visible = true;
    }
}