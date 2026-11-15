<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="animais.aspx.cs" Inherits="animais" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        .catalogo-wrapper {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            padding: 20px 0;
        }

        .pets-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
        }

        .pet-card {
            background-color: #FFFFFF;
            border: 1px solid #EAE2DB;
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            box-shadow: 0 4px 12px rgba(45, 31, 23, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

            .pet-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 20px rgba(45, 31, 23, 0.1);
            }

        .pet-foto {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
            background-color: #EAE2DB;
        }

        .pet-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .pet-nome {
            font-size: 20px;
            font-weight: 700;
            color: #2D1F17;
            margin-bottom: 4px;
        }

        .pet-subtitulo {
            font-size: 13px;
            color: #7A6558;
            margin-bottom: 12px;
        }

        .pet-historia {
            font-size: 13px;
            color: #5C463C;
            line-height: 1.5;
            margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .pet-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: auto;
            margin-bottom: 16px;
        }

        .pet-tag {
            font-size: 11px;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 20px;
            background-color: #FDF3E7;
            color: #C95A3B;
        }

            .pet-tag.secundaria {
                background-color: #EEF5F0;
                color: #4E7A5B;
            }

        .btn-conhecer {
            display: block;
            width: 100%;
            padding: 10px 0;
            text-align: center;
            background-color: transparent;
            color: #C95A3B;
            border: 1px solid #C95A3B;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            box-sizing: border-box;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

            .btn-conhecer:hover {
                background-color: #C95A3B;
                color: #FFFFFF;
            }

        /* Responsividade para telas menores */
        @media (max-width: 1024px) {
            .pets-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .pets-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Fundo escuro por cima dos cards */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(45, 31, 23, 0.55);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            padding: 20px;
            box-sizing: border-box;
        }

        /* Caixinha do formulário */
        .modal-box {
            background-color: #F3EAE2;
            border: 1px solid #D6C7BC;
            border-radius: 20px;
            max-width: 780px;
            width: 100%;
            padding: 36px 40px;
            position: relative;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        .btn-fechar-modal {
            position: absolute;
            top: 16px;
            right: 20px;
            background: transparent;
            border: none;
            font-size: 22px;
            font-weight: bold;
            color: #7A6558;
            cursor: pointer;
        }

            .btn-fechar-modal:hover {
                color: #C95A3B;
            }

        .modal-grid {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 32px;
            align-items: start;
        }

        .modal-pet-foto {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 14px;
            background-color: #EAE2DB;
            margin-bottom: 20px;
            display: block;
        }

        .modal-desc-titulo {
            font-size: 18px;
            font-weight: 700;
            color: #5C463C;
            margin-bottom: 8px;
        }

        .modal-desc-texto {
            font-size: 14px;
            color: #5C463C;
            line-height: 1.55;
        }

        .modal-pet-nome {
            font-size: 28px;
            font-weight: 700;
            color: #2D1F17;
            margin-bottom: 4px;
        }

        .modal-pet-sub {
            font-size: 14px;
            color: #5C463C;
            margin-bottom: 18px;
        }

        .modal-group {
            margin-bottom: 12px;
        }

            .modal-group label {
                display: block;
                font-size: 12px;
                font-weight: 700;
                color: #C95A3B;
                margin-bottom: 4px;
            }

        .modal-input {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #D6C7BC;
            border-radius: 8px;
            background-color: #FAF7F2;
            font-size: 14px;
            color: #2D1F17;
            box-sizing: border-box;
            outline: none;
        }

            .modal-input:focus {
                border-color: #C95A3B;
            }

        .btn-adotar-modal {
            width: 100%;
            padding: 12px;
            background-color: #C95A3B;
            color: #FFFFFF;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.2s;
        }

            .btn-adotar-modal:hover {
                background-color: #b04c30;
            }

        @media (max-width: 700px) {
            .modal-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="catalogo-wrapper">
        <div class="pets-grid">
            <asp:Repeater ID="rptPets" runat="server" OnItemCommand="rptPets_ItemCommand">
                <ItemTemplate>
                    <div class="pet-card">
                        <img src="imagens/HeroImageContainer.png" alt='<%# Eval("nome") %>' class="pet-foto" />

                        <div class="pet-body">
                            <h3 class="pet-nome"><%# Eval("nome") %></h3>
                            <p class="pet-subtitulo">
                                <%# Eval("especie") %> • Porte <%# Eval("porte") %> • <%# Eval("idade") %>
                            </p>

                            <p class="pet-historia"><%# Eval("historia") %></p>

                            <div class="pet-tags">
                                <span class="pet-tag"><%# Eval("genero") %></span>
                                <span class="pet-tag secundaria"><%# Eval("raca") %></span>
                            </div>

                            <asp:Button ID="btnConhecer" runat="server" Text="Quero adotar" 
                                        CssClass="btn-conhecer" style="cursor:pointer;"
                                        CommandName="Conhecer" CommandArgument='<%# Eval("id_animal") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Label ID="lblAviso" runat="server" Visible="false" ForeColor="#5C463C"
                   Text="Nenhum pet disponível para adoção no momento."></asp:Label>
    </div>

    <!-- MODAL DE ADOÇÃO -->
    <asp:Panel ID="pnlModalAdocao" runat="server" Visible="false" CssClass="modal-overlay">
        <div class="modal-box">
            <asp:HiddenField ID="hfIdAnimal" runat="server" />

            <asp:Button ID="btnFecharModal" runat="server" Text="✕" CssClass="btn-fechar-modal" OnClick="btnFecharModal_Click" />

            <div class="modal-grid">
                <!-- Coluna Esquerda: Foto e Descrição -->
                <div>
                    <img src="imagens/HeroImageContainer.png" alt="Pet" class="modal-pet-foto" />
                    <h4 class="modal-desc-titulo">Descrição:</h4>
                    <p class="modal-desc-texto">
                        <asp:Literal ID="litModalHistoria" runat="server"></asp:Literal>
                    </p>
                </div>

                <!-- Coluna Direita: Dados do Pet e Formulário -->
                <div>
                    <h2 class="modal-pet-nome">
                        <asp:Literal ID="litModalNome" runat="server"></asp:Literal>
                    </h2>
                    <p class="modal-pet-sub">
                        <asp:Literal ID="litModalSubtitulo" runat="server"></asp:Literal>
                    </p>

                    <div class="modal-group">
                        <label>Nome do Adotante:</label>
                        <asp:TextBox ID="txtAdotanteNome" runat="server" CssClass="modal-input" placeholder="Ex. João Silva"></asp:TextBox>
                    </div>

                    <div class="modal-group">
                        <label>Cpf:</label>
                        <asp:TextBox ID="txtAdotanteCpf" runat="server" CssClass="modal-input" placeholder="Ex. 123456789-00"></asp:TextBox>
                    </div>

                    <div class="modal-group">
                        <label>Telefone:</label>
                        <asp:TextBox ID="txtAdotanteTelefone" runat="server" CssClass="modal-input" placeholder="Ex. (12) 98888-8888"></asp:TextBox>
                    </div>

                    <div class="modal-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtAdotanteEmail" runat="server" CssClass="modal-input" TextMode="Email" placeholder="Ex. JoãoSilva@email.com"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnQueroAdotar" runat="server" Text="Quero Adotar!" CssClass="btn-adotar-modal" OnClick="btnQueroAdotar_Click" />

                    <asp:Label ID="lblModalMensagem" runat="server" Visible="false"
                               style="display:block; margin-top:10px; color:#C95A3B; font-weight:bold; text-align:center;"></asp:Label>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>