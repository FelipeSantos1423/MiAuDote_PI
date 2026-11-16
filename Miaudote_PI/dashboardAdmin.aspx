<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dashboardAdmin.aspx.cs" Inherits="dashboardAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        /* Ajusta o container da MasterPage para a barra lateral encostar no topo e no rodapé */
        .container {
            padding: 0 !important;
            align-items: stretch !important;
            justify-content: flex-start !important;
        }

        .admin-layout {
            display: flex;
            width: 100%;
            min-height: calc(100vh - 160px);
        }

        /* BARRA LATERAL ESQUERDA */
        .admin-sidebar {
            width: 270px;
            background-color: #EAE2DB;
            border-right: 1px solid #D6C7BC;
            padding: 32px 22px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            flex-shrink: 0;
        }

        .sidebar-titulo {
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: #7A6558;
            margin-bottom: 6px;
            padding-left: 4px;
        }

        .btn-menu-admin {
            width: 100%;
            padding: 15px 18px;
            background-color: #C95A3B;
            color: #FFFFFF;
            border: 2px solid #C95A3B;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 3px 8px rgba(201, 90, 59, 0.18);
        }

        .btn-menu-admin:hover {
            background-color: #b04c30;
            border-color: #b04c30;
            transform: translateY(-1px);
        }

        .btn-menu-admin.ativo {
            background-color: #2D1F17;
            border-color: #2D1F17;
            box-shadow: 0 4px 12px rgba(45, 31, 23, 0.25);
        }

        /* ÁREA PRINCIPAL DIREITA */
        .admin-content {
            flex: 1;
            padding: 36px 44px;
            max-width: 1100px;
        }

        .admin-header {
            margin-bottom: 24px;
        }

        .admin-header h1 {
            font-size: 30px;
            color: #2D1F17;
            margin-bottom: 4px;
        }

        .admin-header h1 span {
            color: #C95A3B;
        }

        .admin-header p {
            color: #5C463C;
            font-size: 15px;
        }

        /* CARDS DE RESUMO NO TOPO */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }

        .stat-card {
            background-color: #FFFFFF;
            border: 1px solid #EAE2DB;
            border-radius: 14px;
            padding: 20px 24px;
            box-shadow: 0 4px 12px rgba(45, 31, 23, 0.04);
        }

        .stat-label {
            font-size: 13px;
            font-weight: 600;
            color: #7A6558;
            margin-bottom: 6px;
        }

        .stat-valor {
            font-size: 28px;
            font-weight: 700;
            color: #C95A3B;
        }

        /* CAIXA BRANCA/CREME DO CONTEÚDO ATIVO */
        .painel-box {
            background-color: #FFFFFF;
            border: 1px solid #EAE2DB;
            border-radius: 18px;
            padding: 32px 36px;
            box-shadow: 0 6px 20px rgba(45, 31, 23, 0.05);
        }

        .painel-box h2 {
            font-size: 22px;
            color: #2D1F17;
            margin-bottom: 6px;
        }

        .painel-box .sub {
            font-size: 14px;
            color: #7A6558;
            margin-bottom: 22px;
        }

        .form-grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .form-group {
            margin-bottom: 14px;
        }

        .form-group label {
            display: block;
            color: #C95A3B;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .form-campo {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #D6C7BC;
            border-radius: 8px;
            background-color: #FAF7F2;
            font-size: 15px;
            color: #2D1F17;
            box-sizing: border-box;
            outline: none;
        }

        .form-campo:focus {
            border-color: #C95A3B;
        }

        textarea.form-campo {
            resize: vertical;
            min-height: 85px;
        }

        .btn-acao-principal {
            padding: 13px 28px;
            background-color: #C95A3B;
            color: #FFFFFF;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 8px;
            transition: background-color 0.2s;
        }

        .btn-acao-principal:hover {
            background-color: #b04c30;
        }

        /* CARDS DE SOLICITAÇÃO E PROTETORES */
        .solicitacao-card {
            background-color: #FAF7F2;
            border: 1px solid #E5D9CE;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 16px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }

        .solicitacao-info h4 {
            font-size: 17px;
            color: #2D1F17;
            margin-bottom: 4px;
        }

        .solicitacao-meta {
            font-size: 13px;
            color: #7A6558;
            margin-bottom: 10px;
        }

        .solicitacao-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 10px;
            flex-wrap: wrap;
        }

        .badge-info {
            font-size: 12px;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 20px;
            background-color: #FDF3E7;
            color: #C95A3B;
        }

        .badge-status {
            font-size: 12px;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            background-color: #EAE2DB;
            color: #2D1F17;
        }

        .solicitacao-motivo {
            font-size: 14px;
            color: #5C463C;
            line-height: 1.5;
        }

        .solicitacao-acoes {
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex-shrink: 0;
        }

        .btn-aprovar {
            padding: 9px 18px;
            background-color: #4E7A5B;
            color: #FFFFFF;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-aprovar:hover {
            background-color: #3f644a;
        }

        .btn-contato {
            padding: 9px 18px;
            background-color: #D4883E;
            color: #FFFFFF;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-contato:hover {
            background-color: #b8722e;
        }

        .btn-rejeitar {
            padding: 9px 18px;
            background-color: transparent;
            color: #C95A3B;
            border: 1px solid #C95A3B;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-rejeitar:hover {
            background-color: #C95A3B;
            color: #FFFFFF;
        }

        @media (max-width: 900px) {
            .admin-layout {
                flex-direction: column;
            }
            .admin-sidebar {
                width: 100%;
                box-sizing: border-box;
            }
            .stats-grid, .form-grid-2 {
                grid-template-columns: 1fr;
            }
            .solicitacao-card {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="admin-layout">
        <!-- MENU LATERAL -->
        <aside class="admin-sidebar">
            <span class="sidebar-titulo">Painel Admin</span>

            <asp:Button ID="btnMenuAnimal" runat="server" Text="Cadastrar Animal"
                CssClass="btn-menu-admin ativo" CausesValidation="false" OnClick="btnMenuAnimal_Click" />

            <asp:Button ID="btnMenuProtetor" runat="server" Text="Adicionar Protetor"
                CssClass="btn-menu-admin" CausesValidation="false" OnClick="btnMenuProtetor_Click" />

            <asp:Button ID="btnMenuAdocoes" runat="server" Text="Pedidos de Adoção"
                CssClass="btn-menu-admin" CausesValidation="false" OnClick="btnMenuAdocoes_Click" />

            <asp:Button ID="btnMenuAdocoesFeitas" runat="server" Text="Adoções Realizadas"
                CssClass="btn-menu-admin" CausesValidation="false" OnClick="btnMenuAdocoesFeitas_Click" />

            <asp:Button ID="btnMenuInscricoes" runat="server" Text="Solicitações"
                CssClass="btn-menu-admin" CausesValidation="false" OnClick="btnMenuInscricoes_Click" />
        </aside>

        <!-- CONTEÚDO PRINCIPAL -->
        <section class="admin-content">
            <div class="admin-header">
                <h1>Gestão <span>MiAuDote</span></h1>
                <p>Cadastre novos pets, gerencie protetores e aprove pedidos de adoção e voluntariado.</p>
            </div>

            <!-- CARDS DE RESUMO -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Animais Disponíveis</div>
                    <div class="stat-valor">
                        <asp:Literal ID="litTotalAnimais" runat="server" Text="0" />
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Protetores Ativos</div>
                    <div class="stat-valor">
                        <asp:Literal ID="litTotalProtetores" runat="server" Text="0" />
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Adoções Pendentes</div>
                    <div class="stat-valor">
                        <asp:Literal ID="litTotalInscricoes" runat="server" Text="0" />
                    </div>
                </div>
            </div>

            <!-- PAINEL 1: CADASTRAR ANIMAL -->
            <asp:Panel ID="pnlAnimal" runat="server" CssClass="painel-box" Visible="true">
                <h2>Cadastrar Novo <span>Animal</span></h2>
                <p class="sub">Preencha os dados do pet para disponibilizá-lo no catálogo de adoção.</p>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Protetor Responsável:</label>
                        <asp:DropDownList ID="ddlProtetor" runat="server" CssClass="form-campo"></asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Nome do Pet:</label>
                        <asp:TextBox ID="txtAnimalNome" runat="server" CssClass="form-campo" placeholder="Ex. Bento"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Espécie:</label>
                        <asp:DropDownList ID="ddlEspecie" runat="server" CssClass="form-campo">
                            <asp:ListItem Text="Cachorro" Value="Cachorro" />
                            <asp:ListItem Text="Gato" Value="Gato" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Raça:</label>
                        <asp:TextBox ID="txtRaca" runat="server" CssClass="form-campo" placeholder="Ex. SRD (Vira-lata)"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Idade:</label>
                        <asp:TextBox ID="txtIdade" runat="server" CssClass="form-campo" placeholder="Ex. 2 anos"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Cor:</label>
                        <asp:TextBox ID="txtCor" runat="server" CssClass="form-campo" placeholder="Ex. Caramelo"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Porte:</label>
                        <asp:DropDownList ID="ddlPorte" runat="server" CssClass="form-campo">
                            <asp:ListItem Text="Pequeno" Value="PEQUENO" />
                            <asp:ListItem Text="Médio" Value="MEDIO" />
                            <asp:ListItem Text="Grande" Value="GRANDE" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Gênero:</label>
                        <asp:DropDownList ID="ddlGenero" runat="server" CssClass="form-campo">
                            <asp:ListItem Text="Macho" Value="MACHO" />
                            <asp:ListItem Text="Fêmea" Value="FEMEA" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Local Abrigado:</label>
                        <asp:TextBox ID="txtLocalAbrigado" runat="server" CssClass="form-campo" placeholder="Ex. Abrigo Central"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Status Inicial:</label>
                        <asp:DropDownList ID="ddlStatusAnimal" runat="server" CssClass="form-campo">
                            <asp:ListItem Text="Disponível para Adoção" Value="DISPONIVEL" />
                            <asp:ListItem Text="Indisponível (Em triagem)" Value="INDISPONIVEL" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label>História do Pet:</label>
                    <asp:TextBox ID="txtHistoria" runat="server" CssClass="form-campo" TextMode="MultiLine" placeholder="Conte um pouco sobre a personalidade e o resgate..."></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Detalhes / Saúde (Vacinas, Castração):</label>
                    <asp:TextBox ID="txtDetalhes" runat="server" CssClass="form-campo" placeholder="Ex. Vacinado, castrado e vermifugado."></asp:TextBox>
                </div>

                <asp:Button ID="btnSalvarAnimal" runat="server" Text="Salvar Animal" CssClass="btn-acao-principal" OnClick="btnSalvarAnimal_Click" />

                <asp:Label ID="lblMsgAnimal" runat="server" Visible="false"
                    Style="display: block; margin-top: 12px; font-weight: bold;"></asp:Label>
            </asp:Panel>

            <!-- PAINEL 2: ADICIONAR E VISUALIZAR PROTETORES -->
            <asp:Panel ID="pnlProtetor" runat="server" CssClass="painel-box" Visible="false">
                <h2>Adicionar Novo <span>Protetor</span></h2>
                <p class="sub">Cadastre um novo protetor ou vincule o cargo de protetor a um usuário existente pelo e-mail.</p>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Nome Completo:</label>
                        <asp:TextBox ID="txtProtetorNome" runat="server" CssClass="form-campo" placeholder="Ex. Mariana Costa"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>CPF:</label>
                        <asp:TextBox ID="txtProtetorCpf" runat="server" CssClass="form-campo" MaxLength="14" placeholder="Ex. 123.456.789-00"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>E-mail:</label>
                        <asp:TextBox ID="txtProtetorEmail" runat="server" CssClass="form-campo" TextMode="Email" placeholder="Ex. mariana@miaudote.org"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Telefone:</label>
                        <asp:TextBox ID="txtProtetorTelefone" runat="server" CssClass="form-campo" placeholder="Ex. (12) 99999-8888"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Senha de Acesso:</label>
                        <asp:TextBox ID="txtProtetorSenha" runat="server" CssClass="form-campo" TextMode="Password" placeholder="Senha inicial"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Local de Atuação:</label>
                        <asp:TextBox ID="txtLocalAtuacao" runat="server" CssClass="form-campo" placeholder="Ex. Abrigo Central / Lar Temporário"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Capacidade de Animais:</label>
                        <asp:TextBox ID="txtCapacidadeAnimais" runat="server" CssClass="form-campo" TextMode="Number" placeholder="Ex. 5"></asp:TextBox>
                    </div>
                </div>

                <asp:Button ID="btnSalvarProtetor" runat="server" Text="Cadastrar Protetor" CssClass="btn-acao-principal" OnClick="btnSalvarProtetor_Click" />

                <asp:Label ID="lblMsgProtetor" runat="server" Visible="false"
                    Style="display: block; margin-top: 12px; font-weight: bold;"></asp:Label>

                <hr style="border: none; height: 1px; background-color: #EAE2DB; margin: 28px 0;" />

                <h2>Protetores <span>Cadastrados</span></h2>
                <p class="sub">Lista de protetores vinculados à plataforma.</p>

                <asp:Repeater ID="rptProtetores" runat="server" OnItemCommand="rptProtetores_ItemCommand">
                    <ItemTemplate>
                        <div class="solicitacao-card">
                            <div class="solicitacao-info">
                                <h4><%# Eval("nome") %></h4>
                                <p class="solicitacao-meta">
                                    <%# Eval("email") %> • CPF: <%# Eval("cpf") %> • Tel: <%# Eval("telefone") %>
                                </p>

                                <div class="solicitacao-tags">
                                    <span class="badge-info">Local: <%# Eval("local_atuacao") %></span>
                                    <span class="badge-info">Capacidade: <%# Eval("capacidade_animais") != DBNull.Value ? Eval("capacidade_animais") + " animais" : "Não informada" %></span>
                                    <span class="badge-status"><%# Eval("status_aprovacao") %></span>
                                </div>
                            </div>

                            <div class="solicitacao-acoes">
                                <asp:Button ID="btnAlterarStatus" runat="server"
                                    Text='<%# Eval("status_aprovacao").ToString() == "ATIVO" ? "Inativar" : "Ativar" %>'
                                    CssClass='<%# Eval("status_aprovacao").ToString() == "ATIVO" ? "btn-rejeitar" : "btn-aprovar" %>'
                                    CommandName="AlternarStatus"
                                    CommandArgument='<%# Eval("id_usuario") + "|" + Eval("status_aprovacao") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblSemProtetores" runat="server" Visible="false" ForeColor="#7A6558"
                    Text="Nenhum protetor cadastrado no momento."></asp:Label>
            </asp:Panel>

            <!-- PAINEL 3: PEDIDOS DE ADOÇÃO -->
            <asp:Panel ID="pnlAdocoes" runat="server" CssClass="painel-box" Visible="false">
                <h2>Pedidos de <span>Adoção</span></h2>
                <p class="sub">Analise os interessados, marque quando estiver em contato ou aprove para registrar a adoção.</p>

                <asp:Label ID="lblMsgAdocao" runat="server" Visible="false"
                    Style="display: block; margin-bottom: 14px; font-weight: bold;"></asp:Label>

                <asp:Repeater ID="rptAdocoes" runat="server" OnItemCommand="rptAdocoes_ItemCommand">
                    <ItemTemplate>
                        <div class="solicitacao-card">
                            <div class="solicitacao-info">
                                <h4>Pet: <%# Eval("nome_animal") %> (<%# Eval("especie") %> • <%# Eval("porte") %>)</h4>
                                <p class="solicitacao-meta">
                                    <strong>Interessado:</strong> <%# Eval("nome_adotante") %> • CPF: <%# Eval("cpf") %> • Tel: <%# Eval("telefone") %> • <%# Eval("email") %>
                                </p>

                                <div class="solicitacao-tags">
                                    <span class="badge-info">Raça: <%# Eval("raca") %></span>
                                    <span class="badge-info">Pedido em: <%# Eval("data_solicitacao", "{0:dd/MM/yyyy}") %></span>
                                    <span class="badge-status"><%# Eval("status_solicitacao") %></span>
                                </div>

                                <p class="solicitacao-motivo"><strong>Observação:</strong> <%# Eval("motivo_adocao") %></p>
                            </div>

                            <div class="solicitacao-acoes" runat="server" visible='<%# Eval("status_solicitacao").ToString() == "PENDENTE" || Eval("status_solicitacao").ToString() == "EM_ANALISE" %>'>
                                <asp:Button ID="btnEmContato" runat="server" Text="Em Contato" CssClass="btn-contato"
                                    Visible='<%# Eval("status_solicitacao").ToString() == "PENDENTE" %>'
                                    CommandName="EmContato"
                                    CommandArgument='<%# Eval("id_solicitacao") + "|" + Eval("id_animal") %>' />

                                <asp:Button ID="btnAprovarAdocao" runat="server" Text="Aprovar" CssClass="btn-aprovar"
                                    CommandName="Aprovar"
                                    CommandArgument='<%# Eval("id_solicitacao") + "|" + Eval("id_animal") %>' />

                                <asp:Button ID="btnRecusarAdocao" runat="server" Text="Recusar" CssClass="btn-rejeitar"
                                    CommandName="Recusar"
                                    CommandArgument='<%# Eval("id_solicitacao") + "|" + Eval("id_animal") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblSemAdocoes" runat="server" Visible="false" ForeColor="#7A6558"
                    Text="Nenhuma solicitação de adoção registrada no momento."></asp:Label>
            </asp:Panel>

            <!-- PAINEL 4: ADOÇÕES REALIZADAS -->
            <asp:Panel ID="pnlAdocoesFeitas" runat="server" CssClass="painel-box" Visible="false">
                <h2>Adoções <span>Realizadas</span></h2>
                <p class="sub">Histórico oficial de pets que já encontraram um novo lar.</p>

                <asp:Repeater ID="rptAdocoesFeitas" runat="server">
                    <ItemTemplate>
                        <div class="solicitacao-card">
                            <div class="solicitacao-info">
                                <h4>Pet: <%# Eval("nome_animal") %> (<%# Eval("especie") %> • <%# Eval("porte") %>)</h4>
                                <p class="solicitacao-meta">
                                    <strong>Adotante:</strong> <%# Eval("nome_adotante") %> • CPF: <%# Eval("cpf") %> • Tel: <%# Eval("telefone") %> • <%# Eval("email") %>
                                </p>

                                <div class="solicitacao-tags">
                                    <span class="badge-info">Raça: <%# Eval("raca") %></span>
                                    <span class="badge-info">Adotado em: <%# Eval("data_adocao", "{0:dd/MM/yyyy}") %></span>
                                    <span class="badge-status"><%# Convert.ToBoolean(Eval("termo_assinado")) ? "Termo Assinado" : "Termo Pendente" %></span>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblSemAdocoesFeitas" runat="server" Visible="false" ForeColor="#7A6558"
                    Text="Nenhuma adoção foi concluída ainda."></asp:Label>
            </asp:Panel>

            <!-- PAINEL 5: SOLICITAÇÕES DE INSCRIÇÃO (VOLUNTÁRIOS) -->
            <asp:Panel ID="pnlInscricoes" runat="server" CssClass="painel-box" Visible="false">
                <h2>Solicitações de <span>Inscrição</span></h2>
                <p class="sub">Analise os candidatos a voluntário e aprove ou rejeite cada pedido.</p>

                <asp:Repeater ID="rptInscricoes" runat="server" OnItemCommand="rptInscricoes_ItemCommand">
                    <ItemTemplate>
                        <div class="solicitacao-card">
                            <div class="solicitacao-info">
                                <h4><%# Eval("nome") %></h4>
                                <p class="solicitacao-meta">
                                    <%# Eval("email") %> • CPF: <%# Eval("cpf") %> • Enviado em <%# Eval("data_inscricao", "{0:dd/MM/yyyy}") %>
                                </p>

                                <div class="solicitacao-tags">
                                    <span class="badge-info">Animais: <%# Eval("disponibilidade_animais") %></span>
                                    <span class="badge-info">Possui Local: <%# Convert.ToBoolean(Eval("disponibilidade_local")) ? "Sim" : "Não" %></span>
                                    <span class="badge-status"><%# Eval("status_analise") %></span>
                                </div>

                                <p class="solicitacao-motivo"><strong>Motivo:</strong> <%# Eval("motivo") %></p>
                            </div>

                            <div class="solicitacao-acoes" runat="server" visible='<%# Eval("status_analise").ToString() == "EM_ANALISE" %>'>
                                <asp:Button ID="btnAprovar" runat="server" Text="Aprovar" CssClass="btn-aprovar"
                                    CommandName="Aprovar" CommandArgument='<%# Eval("id_inscricao") %>' />
                                <asp:Button ID="btnRejeitar" runat="server" Text="Rejeitar" CssClass="btn-rejeitar"
                                    CommandName="Rejeitar" CommandArgument='<%# Eval("id_inscricao") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblSemInscricoes" runat="server" Visible="false" ForeColor="#7A6558"
                    Text="Nenhuma solicitação de inscrição encontrada no momento."></asp:Label>
            </asp:Panel>
        </section>
    </div>
</asp:Content>