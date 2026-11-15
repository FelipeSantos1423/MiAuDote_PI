<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cadastroAnimal.aspx.cs" Inherits="cadastroAnimal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            width: 100%;
        }

        .form-card {
            background-color: #EAE2DB;
            border: 1px solid #D6C7BC;
            border-radius: 20px;
            padding: 45px 55px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
        }

            .form-card h2 {
                color: #2D1F17;
                font-size: 36px;
                font-weight: 700;
                margin-bottom: 4px;
            }

                .form-card h2 span {
                    color: #C95A3B;
                }

        .subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 24px;
        }

        .form-group {
            margin-bottom: 14px;
        }

            .form-group label {
                display: block;
                color: #C95A3B;
                font-size: 14px;
                font-weight: bold;
                margin-bottom: 4px;
            }

        .form-campo {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #D6C7BC;
            border-radius: 8px;
            background-color: #FAF7F2;
            font-size: 16px;
            color: #2D1F17;
            outline: none;
            box-sizing: border-box;
        }

            .form-campo:focus {
                border-color: #C95A3B;
            }

            .form-campo::placeholder {
                color: #B5A99A;
            }

        textarea.form-campo {
            resize: none;
            height: 80px;
        }

        .radio-group table {
            border-collapse: collapse;
            margin-top: 4px;
        }

        .radio-group td {
            padding-right: 30px;
        }

        .radio-group span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            color: #2D1F17;
            font-size: 15px;
        }

        .radio-group input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #C95A3B;
            cursor: pointer;
            margin: 0;
        }

        .btn-enviar {
            width: 100%;
            padding: 15px;
            background-color: #C95A3B;
            color: #FFFFFF;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 18px;
            transition: background-color 0.2s;
        }

            .btn-enviar:hover {
                background-color: #b04c30;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-wrapper">
        <div class="form-card">
            <h2>Cadastro de <span>Animal</span></h2>
            <p class="subtitle">Preencha as informações do pet para cadastrá-lo no sistema.</p>

            <div class="form-group">
                <asp:Label ID="lblNome" runat="server" AssociatedControlID="txtNome" Text="Nome:"></asp:Label>
                <asp:TextBox ID="txtNome" runat="server" CssClass="form-campo" placeholder="Ex. Mel"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEspecie" runat="server" AssociatedControlID="ddlEspecie" Text="Espécie:"></asp:Label>
                <asp:DropDownList ID="ddlEspecie" runat="server" CssClass="form-campo">
                    <asp:ListItem Text="Selecione a espécie..." Value="" Selected="True" Disabled="true" />
                    <asp:ListItem Text="Cachorro" Value="Cachorro" />
                    <asp:ListItem Text="Gato" Value="Gato" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Label ID="lblRaca" runat="server" AssociatedControlID="txtRaca" Text="Raça:"></asp:Label>
                <asp:TextBox ID="txtRaca" runat="server" CssClass="form-campo" placeholder="Ex. SRD (Sem Raça Definida)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblIdade" runat="server" AssociatedControlID="txtIdade" Text="Idade:"></asp:Label>
                <asp:TextBox ID="txtIdade" runat="server" CssClass="form-campo" placeholder="Ex. 2 anos"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCor" runat="server" AssociatedControlID="txtCor" Text="Cor:"></asp:Label>
                <asp:TextBox ID="txtCor" runat="server" CssClass="form-campo" placeholder="Ex. Caramelo e Branco"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPorte" runat="server" AssociatedControlID="ddlPorte" Text="Porte:"></asp:Label>
                <asp:DropDownList ID="ddlPorte" runat="server" CssClass="form-campo">
                    <asp:ListItem Text="Selecione o porte..." Value="" Selected="True" Disabled="true" />
                    <asp:ListItem Text="Pequeno" Value="Pequeno" />
                    <asp:ListItem Text="Médio" Value="Médio" />
                    <asp:ListItem Text="Grande" Value="Grande" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Label ID="lblGenero" runat="server" Text="Gênero:"></asp:Label>
                <div class="radio-group">
                    <asp:RadioButtonList ID="rblGenero" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Macho" Value="Macho" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Fêmea" Value="Fêmea"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label ID="lblHistoria" runat="server" AssociatedControlID="txtHistoria" Text="História:"></asp:Label>
                <asp:TextBox ID="txtHistoria" runat="server" CssClass="form-campo" TextMode="MultiLine" placeholder="Conte um pouco sobre o resgate ou personalidade do pet..."></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblLocalAbrigado" runat="server" AssociatedControlID="txtLocalAbrigado" Text="Local Abrigado:"></asp:Label>
                <asp:TextBox ID="txtLocalAbrigado" runat="server" CssClass="form-campo" placeholder="Ex. Canil Central / Lar Temporário"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDetalhes" runat="server" AssociatedControlID="txtDetalhes" Text="Detalhes:"></asp:Label>
                <asp:TextBox ID="txtDetalhes" runat="server" CssClass="form-campo" TextMode="MultiLine" placeholder="Vacinas, castração, necessidades especiais..."></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDisponibilidadeAdocao" runat="server" Text="Disponibilidade Adoção:"></asp:Label>
                <div class="radio-group">
                    <asp:RadioButtonList ID="rblDisponibilidade" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Disponível" Value="Disponível" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Indisponível (Em tratamento)" Value="Indisponível"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <asp:Button ID="btnCadastrarAnimal" runat="server" Text="Cadastrar Animal" CssClass="btn-enviar" />
        </div>
    </div>
</asp:Content>

