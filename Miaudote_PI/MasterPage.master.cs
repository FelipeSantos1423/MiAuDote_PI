using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool estaLogado = (Session["id_usuario"] != null);
        bool podeDashboard = (Session["pode_dashboard"] != null && (bool)Session["pode_dashboard"]);

        btnLogout.Visible = estaLogado;
        btnAdmin.Visible = estaLogado && podeDashboard;
        lnkLogin.Visible = !estaLogado;
        lnkMinhasSolicitacoes.Visible = estaLogado;
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        Response.Redirect("login.aspx");
    }

    protected void btnAdmin_Click(object sender, EventArgs e)
    {
        Response.Redirect("dashboardAdmin.aspx");
    }
}
