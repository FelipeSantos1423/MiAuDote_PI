<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cadastroUsuario.aspx.cs" Inherits="cadastroUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        border-radius: 16px;
        padding: 45px 55px;
        max-width: 650px;
        width: 100%;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
    }

    .form-card h2 {
        color: #2D1F17;
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 4px;
    }

    .form-card h2 span {
        color: #C95A3B;
    }

    .subtitle {
        color: #5C463C;
        font-size: 15px;
        margin-bottom: 24px;
    }

    .form-group {
        margin-bottom: 14px;
    }

    .form-group label {
        display: block;
        color: #C95A3B;
        font-size: 13px;
        font-weight: bold;
        margin-bottom: 4px;
    }

    .form-campo {
        width: 100%;
        padding: 11px 14px;
        border: 1px solid #D6C7BC;
        border-radius: 8px;
        background-color: #FAF7F2;
        font-size: 15px;
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

    .btn-enviar {
        width: 100%;
        padding: 13px;
        background-color: #C95A3B;
        color: #FFFFFF;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 15px;
        transition: background-color 0.2s;
    }

    .btn-enviar:hover {
        background-color: #b04c30;
    }

    .login-link {
        text-align: center;
        margin-top: 18px;
    }

    .login-link p {
        color: #5C463C;
        font-size: 14px;
    }

    .login-link a {
        color: #C95A3B;
        font-weight: bold;
        text-decoration: none;
    }

    .login-link a:hover {
        text-decoration: underline;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="page-wrapper">
        <div class="form-card">
            <h2>Cadastro de <span>Usuário</span></h2>
            <p class="subtitle">Preencha os seus dados para começar.</p>

            <div class="form-group">
                <asp:Label ID="lblNome" runat="server" AssociatedControlID="txtNome" Text="Nome:"></asp:Label>
                <asp:TextBox ID="txtNome" runat="server" CssClass="form-campo" placeholder="Ex. Claudia Raia"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblDataNasc" runat="server" AssociatedControlID="txtDataNasc" Text="Data Nascimento:"></asp:Label>
                <asp:TextBox ID="txtDataNasc" runat="server" CssClass="form-campo" TextMode="Date"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email:"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-campo" TextMode="Email" placeholder="Ex. claudiaraia123@email.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCpf" runat="server" AssociatedControlID="txtCpf" Text="CPF:"></asp:Label>
                <asp:TextBox ID="txtCpf" runat="server" CssClass="form-campo" MaxLength="14" placeholder="Ex. 123.456.789-12"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEndereco" runat="server" AssociatedControlID="txtEndereco" Text="Endereço:"></asp:Label>
                <asp:TextBox ID="txtEndereco" runat="server" CssClass="form-campo" placeholder="Ex. Rua da Fatec, 123 - Vila Shibata"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenha" runat="server" AssociatedControlID="txtSenha" Text="Senha:"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" CssClass="form-campo" TextMode="Password" placeholder="Ex. 123$456#"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblTelefone" runat="server" AssociatedControlID="txtTelefone" Text="Telefone:"></asp:Label>
                <asp:TextBox ID="txtTelefone" runat="server" CssClass="form-campo" MaxLength="20" placeholder="Ex. (12) 98888-8888"></asp:TextBox>
            </div>

            <asp:Button ID="btnCadastrar" runat="server" Text="Cadastrar" CssClass="btn-enviar" OnClick="btnCadastrar_Click" />

            <asp:Label ID="lblMensagem" runat="server" Visible="false"
                       style="display:block; margin-top:12px; color:#C95A3B; font-weight:bold; text-align:center;"></asp:Label>

            <div class="login-link">
                <p>Já possui cadastro? <a href="login.aspx">Faça login aqui</a></p>
            </div>
        </div>
    </div>
</asp:Content>
