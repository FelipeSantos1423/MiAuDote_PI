using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CarregarAnimais();
        }
    }

    private void CarregarAnimais()
    {
        string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;
        string sql = "SELECT id_animal, nome, especie, raca, idade, porte, genero FROM tb_animal WHERE status_animal = 'DISPONIVEL' ORDER BY id_animal DESC";

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
                        rptAnimais.DataSource = dt;
                        rptAnimais.DataBind();
                    }
                    else
                    {
                        lblMensagemAnimais.Visible = true;
                    }
                }
            }
        }
    }

    protected void btnOng_Click(object sender, EventArgs e)
    {
        Response.Redirect("sobreNos.aspx");
    }

    protected void btnInscricao_Click(object sender, EventArgs e)
    {
        Response.Redirect("inscricaoVoluntario.aspx");
    }

    protected void btnPet_Click(object sender, EventArgs e)
    {
        Response.Redirect("animais.aspx");
    }
}