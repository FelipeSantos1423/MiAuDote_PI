<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            width: 100%;
            min-height: calc(100vh - 160px);
        }

        .form-card {
            background-color: #EAE2DB;
            border: 1px solid #D6C7BC;
            border-radius: 20px;
            padding: 45px 55px;
            max-width: 500px;
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
            margin-bottom: 16px;
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
            margin-top: 15px;
            transition: background-color 0.2s;
        }

        .btn-enviar:hover {
            background-color: #b04c30;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link p {
            color: #5C463C;
            font-size: 15px;
        }

        .register-link a {
            color: #C95A3B;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.2s;
        }

        .register-link a:hover {
            color: #b04c30;
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-wrapper">
        <div class="form-card">
            <h2>Faça seu <span>Login</span></h2>
            <p class="subtitle">Entre com suas credenciais para continuar.</p>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email:"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-campo" TextMode="Email" placeholder="Ex. claudiaraia123@email.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblSenha" runat="server" AssociatedControlID="txtSenha" Text="Senha:"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" CssClass="form-campo" TextMode="Password" placeholder="Ex. 123$456#"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="btn-enviar" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMensagem" runat="server" Visible="false" 
                       style="display:block; margin-top:12px; color:#C95A3B; font-weight:bold; text-align:center;"></asp:Label>

            <div class="register-link">
                <p>Ainda não possui cadastro? <a href="cadastroUsuario.aspx">Cadastre-se aqui</a></p>
            </div>
        </div>
    </div>
</asp:Content>