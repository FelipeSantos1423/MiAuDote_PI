<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="inscricaoVoluntario.aspx.cs" Inherits="inscricaoVoluntario" %>

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
            min-height: calc(100vh - 160px);
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
            height: 90px;
        }

        .inline-group {
            display: flex;
            gap: 30px;
            align-items: center;
            margin-top: 6px;
        }

        .inline-group span {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: #2D1F17;
            font-size: 15px;
        }

        .inline-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #C95A3B;
            cursor: pointer;
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
            gap: 8px;
            cursor: pointer;
            color: #2D1F17;
            font-size: 15px;
        }

        .radio-group input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #C95A3B;
            cursor: pointer;
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
            <h2>Inscrição de <span>Voluntário</span></h2>
            <p class="subtitle">Preencha os seus dados para fazer parte da nossa causa.</p>

            <div class="form-group">
                <asp:Label ID="lblNome" runat="server" AssociatedControlID="txtNome" Text="Nome:"></asp:Label>
                <asp:TextBox ID="txtNome" runat="server" CssClass="form-campo" placeholder="Ex. Claudia Raia"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDataNasc" runat="server" AssociatedControlID="txtDataNasc" Text="Data Nascimento:"></asp:Label>
                <asp:TextBox ID="txtDataNasc" runat="server" CssClass="form-campo" placeholder="Ex. 01/01/1978"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email:"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-campo" TextMode="Email" placeholder="Ex. claudiaraia123@email.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCpf" runat="server" AssociatedControlID="txtCpf" Text="CPF:"></asp:Label>
                <asp:TextBox ID="txtCpf" runat="server" CssClass="form-campo" placeholder="Ex. 123.456.789-12"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDispAnimais" runat="server" Text="Disponibilidade para Animais:"></asp:Label>
                <div class="inline-group">
                    <asp:CheckBox ID="chkCachorro" runat="server" Text="Cachorro" />
                    <asp:CheckBox ID="chkGato" runat="server" Text="Gato" />
                </div>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDispLocal" runat="server" Text="Disponibilidade de Local:"></asp:Label>
                <div class="radio-group">
                    <asp:RadioButtonList ID="rblLocal" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Sim" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Não" Value="0"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="form-group">
                <asp:Label ID="lblMotivo" runat="server" AssociatedControlID="txtMotivo" Text="Motivo:"></asp:Label>
                <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-campo" TextMode="MultiLine" placeholder="Por que você deseja ser voluntário?"></asp:TextBox>
            </div>

            <asp:Button ID="btnCadastrar" runat="server" Text="Cadastrar Inscrição" CssClass="btn-enviar" OnClick="btnCadastrar_Click" />

            <asp:Label ID="lblMensagem" runat="server" Visible="false"
                       style="display:block; margin-top:12px; color:#C95A3B; font-weight:bold; text-align:center;"></asp:Label>
        </div>
    </div>
</asp:Content>