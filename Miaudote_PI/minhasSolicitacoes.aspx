<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="minhasSolicitacoes.aspx.cs" Inherits="minhasSolicitacoes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        .solicitacoes-wrapper {
            width: 100%;
            max-width: 980px;
            margin: 0 auto;
            padding: 44px 24px 72px;
            box-sizing: border-box;
        }

        .solicitacoes-header {
            margin-bottom: 32px;
        }

            .solicitacoes-header h1 {
                font-size: 34px;
                color: #2D1F17;
                margin-bottom: 6px;
            }

                .solicitacoes-header h1 span {
                    color: #C95A3B;
                }

            .solicitacoes-header p {
                font-size: 16px;
                color: #5C463C;
            }

        .secao-box {
            background-color: #FFFFFF;
            border: 1px solid #EAE2DB;
            border-radius: 18px;
            padding: 30px 34px;
            box-shadow: 0 6px 20px rgba(45, 31, 23, 0.05);
            margin-bottom: 28px;
        }

            .secao-box h2 {
                font-size: 22px;
                color: #2D1F17;
                margin-bottom: 6px;
            }

                .secao-box h2 span {
                    color: #C95A3B;
                }

            .secao-box .sub {
                font-size: 14px;
                color: #7A6558;
                margin-bottom: 22px;
            }

        .pedido-card {
            background-color: #FAF7F2;
            border: 1px solid #E5D9CE;
            border-radius: 14px;
            padding: 20px 24px;
            margin-bottom: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .pedido-info h4 {
            font-size: 18px;
            color: #2D1F17;
            margin-bottom: 4px;
        }

        .pedido-meta {
            font-size: 13px;
            color: #7A6558;
            margin-bottom: 8px;
        }

        .pedido-detalhe {
            font-size: 14px;
            color: #5C463C;
        }

        .pedido-direita {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
            flex-shrink: 0;
        }

        /* BADGES DE STATUS COLORIDOS */
        .status-pill {
            font-size: 13px;
            font-weight: 700;
            padding: 6px 16px;
            border-radius: 20px;
            display: inline-block;
        }

        .status-pendente {
            background-color: #EAE2DB;
            color: #5C463C;
        }

        .status-contato {
            background-color: #FDF3E7;
            color: #D4883E;
            border: 1px solid #E8C79B;
        }

        .status-aprovado {
            background-color: #E6F2EA;
            color: #4E7A5B;
            border: 1px solid #B5D4BE;
        }

        .status-recusado {
            background-color: #FBEAE6;
            color: #C95A3B;
            border: 1px solid #E6B5A8;
        }

        .btn-cancelar-pedido {
            padding: 7px 14px;
            background-color: transparent;
            color: #C95A3B;
            border: 1px solid #C95A3B;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
        }

            .btn-cancelar-pedido:hover {
                background-color: #C95A3B;
                color: #FFFFFF;
            }

        .vazio-box {
            text-align: center;
            padding: 20px 10px;
            color: #7A6558;
            font-size: 15px;
        }

            .vazio-box a {
                color: #C95A3B;
                font-weight: 700;
                text-decoration: none;
            }

        @media (max-width: 768px) {
            .pedido-card {
                flex-direction: column;
                align-items: flex-start;
            }

            .pedido-direita {
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="solicitacoes-wrapper">
        <div class="solicitacoes-header">
            <h1>Minhas <span>Solicitações</span></h1>
            <p>Acompanhe em tempo real o andamento dos seus pedidos de adoção e inscrição na equipe.</p>
        </div>

        <!-- BLOCO 1: PEDIDOS DE ADOÇÃO -->
        <div class="secao-box">
            <h2>Pedidos de <span>Adoção</span></h2>
            <p class="sub">Veja se a equipe já entrou em contato ou se a sua adoção foi aprovada.</p>

            <asp:Repeater ID="rptMeusPedidos" runat="server" OnItemCommand="rptMeusPedidos_ItemCommand">
                <ItemTemplate>
                    <div class="pedido-card">
                        <div class="pedido-info">
                            <h4><%# Eval("nome_animal") %> (<%# Eval("especie") %>)</h4>
                            <p class="pedido-meta">
                                Raça: <%# Eval("raca") %> • Porte: <%# Eval("porte") %> • Solicitado em <%# Eval("data_solicitacao", "{0:dd/MM/yyyy}") %>
                            </p>
                            <p class="pedido-detalhe">
                                <%# ObterMensagemStatus(Eval("status_solicitacao").ToString()) %>
                            </p>
                        </div>

                        <div class="pedido-direita">
                            <span class='<%# ObterClasseStatus(Eval("status_solicitacao").ToString()) %>'>
                                <%# ObterTextoStatus(Eval("status_solicitacao").ToString()) %>
                            </span>

                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar Pedido"
                                CssClass="btn-cancelar-pedido"
                                Visible='<%# Eval("status_solicitacao").ToString() == "PENDENTE" %>'
                                CommandName="Cancelar"
                                CommandArgument='<%# Eval("id_solicitacao") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlSemPedidos" runat="server" Visible="false" CssClass="vazio-box">
                Você ainda não fez nenhuma solicitação de adoção. <a href="animais.aspx">Conhecer nossos pets disponíveis →</a>
            </asp:Panel>
        </div>

        <!-- BLOCO 2: INSCRIÇÃO DE VOLUNTÁRIO / PROTETOR -->
        <div class="secao-box">
            <h2>Inscrição de <span>Voluntário / Protetor</span></h2>
            <p class="sub">Status da sua candidatura para atuar na rede de apoio do MiAuDote.</p>

            <asp:Repeater ID="rptMinhaInscricao" runat="server">
                <ItemTemplate>
                    <div class="pedido-card">
                        <div class="pedido-info">
                            <h4>Candidatura para Protetor / Voluntário</h4>
                            <p class="pedido-meta">
                                Enviada em <%# Eval("data_inscricao", "{0:dd/MM/yyyy}") %> • Animais: <%# Eval("disponibilidade_animais") %>
                            </p>
                            <p class="pedido-detalhe">
                                <strong>Motivo informado:</strong> <%# Eval("motivo") %>
                            </p>
                        </div>

                        <div class="pedido-direita">
                            <span class='<%# ObterClasseStatus(Eval("status_analise").ToString()) %>'>
                                <%# ObterTextoStatus(Eval("status_analise").ToString()) %>
                            </span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlSemInscricao" runat="server" Visible="false" CssClass="vazio-box">
                Você ainda não enviou inscrição para ser voluntário ou protetor. <a href="InscricaoVoluntario.aspx">Quero me inscrever →</a>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

