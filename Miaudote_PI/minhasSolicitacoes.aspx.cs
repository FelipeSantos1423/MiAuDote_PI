using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class minhasSolicitacoes : System.Web.UI.Page
{
    string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["id_usuario"] == null)
        {
            Response.Redirect("login.aspx?retorno=minhasSolicitacoes.aspx");
            return;
        }

        if (!IsPostBack)
        {
            CarregarMeusPedidos();
            CarregarMinhaInscricao();
        }
    }

    private void CarregarMeusPedidos()
    {
        int idUsuario = Convert.ToInt32(Session["id_usuario"]);

        string sql = @"SELECT s.id_solicitacao, s.status_solicitacao, s.data_solicitacao,
                              a.nome AS nome_animal, a.especie, a.porte, ISNULL(a.raca, 'SRD') AS raca
                       FROM tb_solicitacao_adocao s
                       INNER JOIN tb_animal a ON s.id_animal = a.id_animal
                       WHERE s.id_adotante = @id_usuario
                       ORDER BY s.data_solicitacao DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptMeusPedidos.DataSource = dt;
                    rptMeusPedidos.DataBind();
                    pnlSemPedidos.Visible = (dt.Rows.Count == 0);
                }
            }
        }
    }

    private void CarregarMinhaInscricao()
    {
        int idUsuario = Convert.ToInt32(Session["id_usuario"]);

        string sql = @"SELECT id_inscricao, disponibilidade_animais, motivo, status_analise, data_inscricao
                       FROM tb_inscricao_protetor_voluntario
                       WHERE id_usuario = @id_usuario
                       ORDER BY data_inscricao DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptMinhaInscricao.DataSource = dt;
                    rptMinhaInscricao.DataBind();
                    pnlSemInscricao.Visible = (dt.Rows.Count == 0);
                }
            }
        }
    }

    protected void rptMeusPedidos_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Cancelar")
        {
            int idSolicitacao = Convert.ToInt32(e.CommandArgument);
            int idUsuario = Convert.ToInt32(Session["id_usuario"]);

            string sql = "UPDATE tb_solicitacao_adocao SET status_solicitacao = 'CANCELADA' WHERE id_solicitacao = @id AND id_adotante = @id_usuario AND status_solicitacao = 'PENDENTE'";

            using (SqlConnection con = new SqlConnection(strConexao))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", idSolicitacao);
                    cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            CarregarMeusPedidos();
        }
    }

    // =========================================================
    // MÉTODOS AUXILIARES PARA EXIBIR TEXTO E COR DO STATUS
    // =========================================================
    protected string ObterTextoStatus(string status)
    {
        switch (status)
        {
            case "PENDENTE":
                return "Pendente";
            case "EM_ANALISE":
                return "Em Contato / Em Análise";
            case "APROVADA":
            case "APROVADO":
                return "Aprovada!";
            case "RECUSADA":
            case "REJEITADO":
                return "Não Aprovada";
            case "CANCELADA":
                return "Cancelada";
            default:
                return status;
        }
    }

    protected string ObterClasseStatus(string status)
    {
        switch (status)
        {
            case "EM_ANALISE":
                return "status-pill status-contato";
            case "APROVADA":
            case "APROVADO":
                return "status-pill status-aprovado";
            case "RECUSADA":
            case "REJEITADO":
            case "CANCELADA":
                return "status-pill status-recusado";
            default:
                return "status-pill status-pendente";
        }
    }

    protected string ObterMensagemStatus(string status)
    {
        switch (status)
        {
            case "PENDENTE":
                return "Recebemos sua solicitação! Em breve nossa equipe entrará em contato.";
            case "EM_ANALISE":
                return "Nossa equipe já está avaliando seu perfil e entrando em contato para alinhar os detalhes.";
            case "APROVADA":
                return "Parabéns! Sua adoção foi aprovada e registrada com sucesso.";
            case "RECUSADA":
                return "Desta vez o pet seguiu com outro perfil compatível, mas há vários outros amigos esperando por você.";
            case "CANCELADA":
                return "Você cancelou esta solicitação.";
            default:
                return "";
        }
    }
}