using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dashboardAdmin : System.Web.UI.Page
{
    string strConexao = ConfigurationManager.ConnectionStrings["ConexaoMiAuDote"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["id_usuario"] == null)
        {
            Response.Redirect("login.aspx?retorno=dashboardAdmin.aspx");
            return;
        }

        bool podeDashboard = (Session["pode_dashboard"] != null && (bool)Session["pode_dashboard"]);
        if (!podeDashboard)
        {
            Response.Redirect("home.aspx");
            return;
        }

        if (!IsPostBack)
        {
            CarregarResumo();
            CarregarProtetoresDropdown();
            CarregarProtetoresLista();
            CarregarAdocoes();
            CarregarAdocoesFeitas();
            CarregarInscricoes();
        }
    }

    private void AlternarAba(string aba)
    {
        pnlAnimal.Visible = (aba == "ANIMAL");
        pnlProtetor.Visible = (aba == "PROTETOR");
        pnlAdocoes.Visible = (aba == "ADOCOES");
        pnlAdocoesFeitas.Visible = (aba == "ADOCOES_FEITAS");
        pnlInscricoes.Visible = (aba == "INSCRICOES");

        btnMenuAnimal.CssClass = (aba == "ANIMAL") ? "btn-menu-admin ativo" : "btn-menu-admin";
        btnMenuProtetor.CssClass = (aba == "PROTETOR") ? "btn-menu-admin ativo" : "btn-menu-admin";
        btnMenuAdocoes.CssClass = (aba == "ADOCOES") ? "btn-menu-admin ativo" : "btn-menu-admin";
        btnMenuAdocoesFeitas.CssClass = (aba == "ADOCOES_FEITAS") ? "btn-menu-admin ativo" : "btn-menu-admin";
        btnMenuInscricoes.CssClass = (aba == "INSCRICOES") ? "btn-menu-admin ativo" : "btn-menu-admin";

        if (aba == "ANIMAL") CarregarProtetoresDropdown();
        if (aba == "PROTETOR") CarregarProtetoresLista();
        if (aba == "ADOCOES") CarregarAdocoes();
        if (aba == "ADOCOES_FEITAS") CarregarAdocoesFeitas();
        if (aba == "INSCRICOES") CarregarInscricoes();
    }

    protected void btnMenuAnimal_Click(object sender, EventArgs e)
    {
        AlternarAba("ANIMAL");
    }

    protected void btnMenuProtetor_Click(object sender, EventArgs e)
    {
        AlternarAba("PROTETOR");
    }

    protected void btnMenuAdocoes_Click(object sender, EventArgs e)
    {
        AlternarAba("ADOCOES");
    }

    protected void btnMenuAdocoesFeitas_Click(object sender, EventArgs e)
    {
        AlternarAba("ADOCOES_FEITAS");
    }

    protected void btnMenuInscricoes_Click(object sender, EventArgs e)
    {
        AlternarAba("INSCRICOES");
    }

    // =========================================================
    // CARDS DE RESUMO DO TOPO
    // =========================================================
    private void CarregarResumo()
    {
        using (SqlConnection con = new SqlConnection(strConexao))
        {
            con.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM tb_animal WHERE status_animal = 'DISPONIVEL'", con))
                litTotalAnimais.Text = cmd.ExecuteScalar().ToString();

            string sqlProt = @"SELECT COUNT(*) FROM tb_usuario_cargo uc
                               INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                               WHERE c.nome_cargo = 'PROTETOR' AND uc.status_aprovacao = 'ATIVO'";
            using (SqlCommand cmd = new SqlCommand(sqlProt, con))
                litTotalProtetores.Text = cmd.ExecuteScalar().ToString();

            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM tb_solicitacao_adocao WHERE status_solicitacao IN ('PENDENTE', 'EM_ANALISE')", con))
                litTotalInscricoes.Text = cmd.ExecuteScalar().ToString();
        }
    }

    // =========================================================
    // ABA 1: CADASTRAR ANIMAL
    // =========================================================
    private void CarregarProtetoresDropdown()
    {
        string sql = @"SELECT u.id_usuario, u.nome + ' (' + u.email + ')' AS nome_exibicao
                       FROM tb_usuario u
                       INNER JOIN tb_usuario_cargo uc ON u.id_usuario = uc.id_usuario
                       INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                       WHERE c.nome_cargo = 'PROTETOR' AND uc.status_aprovacao = 'ATIVO'
                       ORDER BY u.nome";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlProtetor.Items.Clear();

                if (dt.Rows.Count > 0)
                {
                    ddlProtetor.DataSource = dt;
                    ddlProtetor.DataTextField = "nome_exibicao";
                    ddlProtetor.DataValueField = "id_usuario";
                    ddlProtetor.DataBind();
                }
                else
                {
                    ddlProtetor.Items.Add(new ListItem("Cadastre um protetor primeiro...", ""));
                }
            }
        }
    }

    protected void btnSalvarAnimal_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlProtetor.SelectedValue))
        {
            lblMsgAnimal.Style["color"] = "#C95A3B";
            lblMsgAnimal.Text = "Cadastre ou vincule um protetor ativo antes de cadastrar um animal.";
            lblMsgAnimal.Visible = true;
            return;
        }

        if (string.IsNullOrWhiteSpace(txtAnimalNome.Text))
        {
            lblMsgAnimal.Style["color"] = "#C95A3B";
            lblMsgAnimal.Text = "Preencha pelo menos o nome do pet.";
            lblMsgAnimal.Visible = true;
            return;
        }

        string sql = @"INSERT INTO tb_animal 
                       (id_protetor, nome, especie, raca, idade, cor, porte, genero, historia, local_abrigado, detalhes, status_animal)
                       VALUES 
                       (@id_protetor, @nome, @especie, @raca, @idade, @cor, @porte, @genero, @historia, @local_abrigado, @detalhes, @status_animal)";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id_protetor", Convert.ToInt32(ddlProtetor.SelectedValue));
                cmd.Parameters.AddWithValue("@nome", txtAnimalNome.Text.Trim());
                cmd.Parameters.AddWithValue("@especie", ddlEspecie.SelectedValue);
                cmd.Parameters.AddWithValue("@raca", string.IsNullOrWhiteSpace(txtRaca.Text) ? (object)DBNull.Value : txtRaca.Text.Trim());
                cmd.Parameters.AddWithValue("@idade", string.IsNullOrWhiteSpace(txtIdade.Text) ? (object)DBNull.Value : txtIdade.Text.Trim());
                cmd.Parameters.AddWithValue("@cor", string.IsNullOrWhiteSpace(txtCor.Text) ? (object)DBNull.Value : txtCor.Text.Trim());
                cmd.Parameters.AddWithValue("@porte", ddlPorte.SelectedValue);
                cmd.Parameters.AddWithValue("@genero", ddlGenero.SelectedValue);
                cmd.Parameters.AddWithValue("@historia", string.IsNullOrWhiteSpace(txtHistoria.Text) ? (object)DBNull.Value : txtHistoria.Text.Trim());
                cmd.Parameters.AddWithValue("@local_abrigado", string.IsNullOrWhiteSpace(txtLocalAbrigado.Text) ? (object)DBNull.Value : txtLocalAbrigado.Text.Trim());
                cmd.Parameters.AddWithValue("@detalhes", string.IsNullOrWhiteSpace(txtDetalhes.Text) ? (object)DBNull.Value : txtDetalhes.Text.Trim());
                cmd.Parameters.AddWithValue("@status_animal", ddlStatusAnimal.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        txtAnimalNome.Text = "";
        txtRaca.Text = "";
        txtIdade.Text = "";
        txtCor.Text = "";
        txtLocalAbrigado.Text = "";
        txtHistoria.Text = "";
        txtDetalhes.Text = "";

        lblMsgAnimal.Style["color"] = "#4E7A5B";
        lblMsgAnimal.Text = "Animal cadastrado com sucesso!";
        lblMsgAnimal.Visible = true;

        CarregarResumo();
    }

    // =========================================================
    // ABA 2: ADICIONAR, LISTAR E GERENCIAR PROTETORES
    // =========================================================
    protected void btnSalvarProtetor_Click(object sender, EventArgs e)
    {
        string nome = txtProtetorNome.Text.Trim();
        string cpf = txtProtetorCpf.Text.Trim();
        string email = txtProtetorEmail.Text.Trim();
        string telefone = txtProtetorTelefone.Text.Trim();
        string senha = txtProtetorSenha.Text.Trim();
        string local = txtLocalAtuacao.Text.Trim();

        if (string.IsNullOrEmpty(email))
        {
            lblMsgProtetor.Style["color"] = "#C95A3B";
            lblMsgProtetor.Text = "Informe pelo menos o e-mail do protetor.";
            lblMsgProtetor.Visible = true;
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(strConexao))
            {
                con.Open();

                int idUsuario = 0;
                using (SqlCommand cmdBusca = new SqlCommand("SELECT id_usuario FROM tb_usuario WHERE email = @email", con))
                {
                    cmdBusca.Parameters.AddWithValue("@email", email);
                    object result = cmdBusca.ExecuteScalar();
                    if (result != null) idUsuario = Convert.ToInt32(result);
                }

                if (idUsuario == 0)
                {
                    if (string.IsNullOrEmpty(nome) || string.IsNullOrEmpty(cpf) || string.IsNullOrEmpty(senha))
                    {
                        lblMsgProtetor.Style["color"] = "#C95A3B";
                        lblMsgProtetor.Text = "Para cadastrar uma pessoa nova, preencha Nome, CPF, E-mail e Senha.";
                        lblMsgProtetor.Visible = true;
                        return;
                    }

                    string sqlNovoUser = @"INSERT INTO tb_usuario (nome, cpf, email, senha, telefone)
                                           VALUES (@nome, @cpf, @email, @senha, @telefone);
                                           SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmdUser = new SqlCommand(sqlNovoUser, con))
                    {
                        cmdUser.Parameters.AddWithValue("@nome", nome);
                        cmdUser.Parameters.AddWithValue("@cpf", cpf);
                        cmdUser.Parameters.AddWithValue("@email", email);
                        cmdUser.Parameters.AddWithValue("@senha", senha);
                        cmdUser.Parameters.AddWithValue("@telefone", string.IsNullOrEmpty(telefone) ? (object)DBNull.Value : telefone);

                        idUsuario = Convert.ToInt32(cmdUser.ExecuteScalar());
                    }
                }

                int idCargoProtetor;
                using (SqlCommand cmdCargo = new SqlCommand("SELECT id_cargo FROM tb_cargo WHERE nome_cargo = 'PROTETOR'", con))
                {
                    idCargoProtetor = Convert.ToInt32(cmdCargo.ExecuteScalar());
                }

                string sqlVinculo = @"IF EXISTS (SELECT 1 FROM tb_usuario_cargo WHERE id_usuario = @id_usuario AND id_cargo = @id_cargo)
                                        UPDATE tb_usuario_cargo 
                                        SET local_atuacao = @local, capacidade_animais = @cap, status_aprovacao = 'ATIVO'
                                        WHERE id_usuario = @id_usuario AND id_cargo = @id_cargo
                                      ELSE
                                        INSERT INTO tb_usuario_cargo (id_usuario, id_cargo, local_atuacao, capacidade_animais, status_aprovacao)
                                        VALUES (@id_usuario, @id_cargo, @local, @cap, 'ATIVO')";

                using (SqlCommand cmdVinculo = new SqlCommand(sqlVinculo, con))
                {
                    cmdVinculo.Parameters.AddWithValue("@id_usuario", idUsuario);
                    cmdVinculo.Parameters.AddWithValue("@id_cargo", idCargoProtetor);
                    cmdVinculo.Parameters.AddWithValue("@local", string.IsNullOrEmpty(local) ? (object)DBNull.Value : local);

                    int cap;
                    if (int.TryParse(txtCapacidadeAnimais.Text.Trim(), out cap))
                        cmdVinculo.Parameters.AddWithValue("@cap", cap);
                    else
                        cmdVinculo.Parameters.AddWithValue("@cap", DBNull.Value);

                    cmdVinculo.ExecuteNonQuery();
                }
            }

            txtProtetorNome.Text = "";
            txtProtetorCpf.Text = "";
            txtProtetorEmail.Text = "";
            txtProtetorTelefone.Text = "";
            txtProtetorSenha.Text = "";
            txtLocalAtuacao.Text = "";
            txtCapacidadeAnimais.Text = "";

            lblMsgProtetor.Style["color"] = "#4E7A5B";
            lblMsgProtetor.Text = "Protetor cadastrado e vinculado com sucesso!";
            lblMsgProtetor.Visible = true;

            CarregarResumo();
            CarregarProtetoresDropdown();
            CarregarProtetoresLista();
        }
        catch (SqlException ex)
        {
            lblMsgProtetor.Style["color"] = "#C95A3B";
            if (ex.Number == 2627 || ex.Number == 2601)
                lblMsgProtetor.Text = "Este CPF já pertence a outro usuário cadastrado.";
            else
                lblMsgProtetor.Text = "Erro ao salvar protetor: " + ex.Message;

            lblMsgProtetor.Visible = true;
        }
    }

    private void CarregarProtetoresLista()
    {
        string sql = @"SELECT u.id_usuario, u.nome, u.email, u.cpf,
                              ISNULL(u.telefone, 'Não informado') AS telefone,
                              ISNULL(uc.local_atuacao, 'Não informado') AS local_atuacao,
                              uc.capacidade_animais, uc.status_aprovacao
                       FROM tb_usuario u
                       INNER JOIN tb_usuario_cargo uc ON u.id_usuario = uc.id_usuario
                       INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                       WHERE c.nome_cargo = 'PROTETOR'
                       ORDER BY u.nome";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptProtetores.DataSource = dt;
                rptProtetores.DataBind();
                lblSemProtetores.Visible = (dt.Rows.Count == 0);
            }
        }
    }

    protected void rptProtetores_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "AlternarStatus")
        {
            string[] dados = e.CommandArgument.ToString().Split('|');
            int idUsuario = Convert.ToInt32(dados[0]);
            string statusAtual = dados[1];
            string novoStatus = (statusAtual == "ATIVO") ? "INATIVO" : "ATIVO";

            string sql = @"UPDATE uc
                           SET uc.status_aprovacao = @novoStatus
                           FROM tb_usuario_cargo uc
                           INNER JOIN tb_cargo c ON uc.id_cargo = c.id_cargo
                           WHERE uc.id_usuario = @id_usuario AND c.nome_cargo = 'PROTETOR'";

            using (SqlConnection con = new SqlConnection(strConexao))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@novoStatus", novoStatus);
                    cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            CarregarProtetoresLista();
            CarregarProtetoresDropdown();
            CarregarResumo();
        }
    }

    // =========================================================
    // ABA 3: PEDIDOS DE ADOÇÃO (APROVAR -> tb_adocao)
    // =========================================================
    private void CarregarAdocoes()
    {
        string sql = @"SELECT s.id_solicitacao, s.id_animal, s.status_solicitacao, s.data_solicitacao,
                              a.nome AS nome_animal, a.especie, a.porte, ISNULL(a.raca, 'SRD') AS raca,
                              u.nome AS nome_adotante, u.cpf, ISNULL(u.telefone, 'Não informado') AS telefone, u.email,
                              ISNULL(f.motivo_adocao, 'Sem observações') AS motivo_adocao
                       FROM tb_solicitacao_adocao s
                       INNER JOIN tb_animal a ON s.id_animal = a.id_animal
                       INNER JOIN tb_usuario u ON s.id_adotante = u.id_usuario
                       LEFT JOIN tb_formulario_adocao f ON s.id_formulario = f.id_formulario
                       ORDER BY CASE WHEN s.status_solicitacao IN ('PENDENTE', 'EM_ANALISE') THEN 0 ELSE 1 END, s.data_solicitacao DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptAdocoes.DataSource = dt;
                rptAdocoes.DataBind();
                lblSemAdocoes.Visible = (dt.Rows.Count == 0);
            }
        }
    }

    protected void rptAdocoes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string[] dados = e.CommandArgument.ToString().Split('|');
        int idSolicitacao = Convert.ToInt32(dados[0]);
        int idAnimal = Convert.ToInt32(dados[1]);

        try
        {
            using (SqlConnection con = new SqlConnection(strConexao))
            {
                con.Open();

                if (e.CommandName == "EmContato")
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE tb_solicitacao_adocao SET status_solicitacao = 'EM_ANALISE' WHERE id_solicitacao = @id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", idSolicitacao);
                        cmd.ExecuteNonQuery();
                    }

                    lblMsgAdocao.Style["color"] = "#D4883E";
                    lblMsgAdocao.Text = "Status atualizado para Em Contato / Em Análise.";
                    lblMsgAdocao.Visible = true;
                }
                else if (e.CommandName == "Aprovar")
                {
                    // 1. Marca a solicitação como APROVADA
                    using (SqlCommand cmd = new SqlCommand("UPDATE tb_solicitacao_adocao SET status_solicitacao = 'APROVADA' WHERE id_solicitacao = @id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", idSolicitacao);
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Grava na tb_adocao (colunas: id_solicitacao, data_adocao, termo_assinado)
                    string sqlAdocao = @"IF NOT EXISTS (SELECT 1 FROM tb_adocao WHERE id_solicitacao = @id_sol)
                                         INSERT INTO tb_adocao (id_solicitacao, data_adocao, termo_assinado)
                                         VALUES (@id_sol, GETDATE(), 1)";
                    using (SqlCommand cmd = new SqlCommand(sqlAdocao, con))
                    {
                        cmd.Parameters.AddWithValue("@id_sol", idSolicitacao);
                        cmd.ExecuteNonQuery();
                    }

                    // 3. Muda o status do animal para ADOTADO
                    using (SqlCommand cmd = new SqlCommand("UPDATE tb_animal SET status_animal = 'ADOTADO' WHERE id_animal = @id_animal", con))
                    {
                        cmd.Parameters.AddWithValue("@id_animal", idAnimal);
                        cmd.ExecuteNonQuery();
                    }

                    // 4. Recusa outros pedidos abertos para o mesmo animal
                    using (SqlCommand cmd = new SqlCommand("UPDATE tb_solicitacao_adocao SET status_solicitacao = 'RECUSADA' WHERE id_animal = @id_animal AND id_solicitacao <> @id_sol AND status_solicitacao IN ('PENDENTE', 'EM_ANALISE')", con))
                    {
                        cmd.Parameters.AddWithValue("@id_animal", idAnimal);
                        cmd.Parameters.AddWithValue("@id_sol", idSolicitacao);
                        cmd.ExecuteNonQuery();
                    }

                    lblMsgAdocao.Style["color"] = "#4E7A5B";
                    lblMsgAdocao.Text = "Adoção aprovada e registrada com sucesso!";
                    lblMsgAdocao.Visible = true;
                }
                else if (e.CommandName == "Recusar")
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE tb_solicitacao_adocao SET status_solicitacao = 'RECUSADA' WHERE id_solicitacao = @id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", idSolicitacao);
                        cmd.ExecuteNonQuery();
                    }

                    lblMsgAdocao.Style["color"] = "#C95A3B";
                    lblMsgAdocao.Text = "Pedido de adoção recusado.";
                    lblMsgAdocao.Visible = true;
                }
            }

            CarregarAdocoes();
            CarregarAdocoesFeitas();
            CarregarResumo();
        }
        catch (SqlException ex)
        {
            lblMsgAdocao.Style["color"] = "#C95A3B";
            lblMsgAdocao.Text = "Erro ao processar adoção: " + ex.Message;
            lblMsgAdocao.Visible = true;
        }
    }

    // =========================================================
    // ABA 4: ADOÇÕES REALIZADAS (HISTÓRICO tb_adocao)
    // =========================================================
    private void CarregarAdocoesFeitas()
    {
        string sql = @"SELECT ad.id_adocao, ad.data_adocao, ISNULL(ad.termo_assinado, 0) AS termo_assinado,
                              a.nome AS nome_animal, a.especie, a.porte, ISNULL(a.raca, 'SRD') AS raca,
                              u.nome AS nome_adotante, u.cpf, ISNULL(u.telefone, 'Não informado') AS telefone, u.email
                       FROM tb_adocao ad
                       INNER JOIN tb_solicitacao_adocao s ON ad.id_solicitacao = s.id_solicitacao
                       INNER JOIN tb_animal a ON s.id_animal = a.id_animal
                       INNER JOIN tb_usuario u ON s.id_adotante = u.id_usuario
                       ORDER BY ad.data_adocao DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptAdocoesFeitas.DataSource = dt;
                rptAdocoesFeitas.DataBind();
                lblSemAdocoesFeitas.Visible = (dt.Rows.Count == 0);
            }
        }
    }

    // =========================================================
    // ABA 5: SOLICITAÇÕES DE VOLUNTARIADO
    // =========================================================
    private void CarregarInscricoes()
    {
        string sql = @"SELECT i.id_inscricao, u.nome, u.email, u.cpf, i.disponibilidade_animais, 
                              i.disponibilidade_local, i.motivo, i.status_analise, i.data_inscricao
                       FROM tb_inscricao_protetor_voluntario i
                       INNER JOIN tb_usuario u ON i.id_usuario = u.id_usuario
                       ORDER BY CASE WHEN i.status_analise = 'EM_ANALISE' THEN 0 ELSE 1 END, i.data_inscricao DESC";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptInscricoes.DataSource = dt;
                rptInscricoes.DataBind();
                lblSemInscricoes.Visible = (dt.Rows.Count == 0);
            }
        }
    }

    protected void rptInscricoes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int idInscricao = Convert.ToInt32(e.CommandArgument);
        int idAdmin = Convert.ToInt32(Session["id_usuario"]);
        string novoStatus = (e.CommandName == "Aprovar") ? "APROVADO" : "REJEITADO";

        using (SqlConnection con = new SqlConnection(strConexao))
        {
            con.Open();

            string sqlUpd = @"UPDATE tb_inscricao_protetor_voluntario
                              SET status_analise = @status, data_analise = GETDATE(), id_administrador = @admin
                              WHERE id_inscricao = @id";

            using (SqlCommand cmd = new SqlCommand(sqlUpd, con))
            {
                cmd.Parameters.AddWithValue("@status", novoStatus);
                cmd.Parameters.AddWithValue("@admin", idAdmin);
                cmd.Parameters.AddWithValue("@id", idInscricao);
                cmd.ExecuteNonQuery();
            }

            if (novoStatus == "APROVADO")
            {
                string sqlCargoVol = @"DECLARE @idCandidato INT, @motivo VARCHAR(MAX), @idCargoVol INT;
                                       SELECT @idCandidato = id_usuario, @motivo = motivo FROM tb_inscricao_protetor_voluntario WHERE id_inscricao = @id;
                                       SELECT @idCargoVol = id_cargo FROM tb_cargo WHERE nome_cargo = 'VOLUNTARIO';

                                       IF NOT EXISTS (SELECT 1 FROM tb_usuario_cargo WHERE id_usuario = @idCandidato AND id_cargo = @idCargoVol)
                                           INSERT INTO tb_usuario_cargo (id_usuario, id_cargo, status_aprovacao, motivo_voluntario)
                                           VALUES (@idCandidato, @idCargoVol, 'ATIVO', @motivo)
                                       ELSE
                                           UPDATE tb_usuario_cargo SET status_aprovacao = 'ATIVO'
                                           WHERE id_usuario = @idCandidato AND id_cargo = @idCargoVol;";

                using (SqlCommand cmdVol = new SqlCommand(sqlCargoVol, con))
                {
                    cmdVol.Parameters.AddWithValue("@id", idInscricao);
                    cmdVol.ExecuteNonQuery();
                }
            }
        }

        CarregarInscricoes();
        CarregarResumo();
    }
}