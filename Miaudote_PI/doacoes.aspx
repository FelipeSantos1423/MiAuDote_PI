<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="doacoes.aspx.cs" Inherits="doacoes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            background-color: #F8F1E8;
        }

        .doacoes-wrapper {
            width: 100%;
            max-width: 1050px;
            margin: 0 auto;
            padding: 48px 24px 72px;
            box-sizing: border-box;
        }

        .doacoes-header {
            text-align: center;
            margin-bottom: 40px;
        }

            .doacoes-header h1 {
                font-size: 36px;
                color: #2D1F17;
                margin-bottom: 10px;
            }

                .doacoes-header h1 span {
                    color: #C95A3B;
                }

            .doacoes-header p {
                font-size: 16px;
                color: #5C463C;
                max-width: 650px;
                margin: 0 auto;
                line-height: 1.6;
            }

        .doacoes-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 28px;
            align-items: stretch;
        }

        .doacao-card {
            background-color: #FFFFFF;
            border: 1px solid #EAE2DB;
            border-radius: 18px;
            padding: 34px 36px;
            box-shadow: 0 6px 20px rgba(45, 31, 23, 0.05);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

            .doacao-card h2 {
                font-size: 24px;
                color: #2D1F17;
                margin-bottom: 8px;
            }

                .doacao-card h2 span {
                    color: #C95A3B;
                }

            .doacao-card .sub {
                font-size: 14px;
                color: #7A6558;
                line-height: 1.5;
                margin-bottom: 22px;
            }

        /* CAIXA DA CHAVE PIX */
        .pix-box {
            background-color: #FAF7F2;
            border: 2px dashed #C95A3B;
            border-radius: 14px;
            padding: 22px;
            text-align: center;
            margin-bottom: 20px;
        }

        .pix-tipo {
            display: inline-block;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            background-color: #FDF3E7;
            color: #C95A3B;
            padding: 4px 12px;
            border-radius: 20px;
            margin-bottom: 10px;
        }

        .pix-chave {
            font-size: 20px;
            font-weight: 700;
            color: #2D1F17;
            word-break: break-all;
            margin-bottom: 6px;
        }

        .pix-favorecido {
            font-size: 13px;
            color: #7A6558;
        }

        .btn-copiar-pix {
            width: 100%;
            padding: 14px 20px;
            background-color: #C95A3B;
            color: #FFFFFF;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
        }

            .btn-copiar-pix:hover {
                background-color: #b04c30;
            }

        .pix-feedback {
            display: block;
            text-align: center;
            font-size: 13px;
            font-weight: 700;
            color: #4E7A5B;
            margin-top: 10px;
            min-height: 18px;
        }

        /* LISTA DE OUTRAS DOAÇÕES */
        .lista-itens {
            list-style: none;
            padding: 0;
            margin: 0 0 22px 0;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

            .lista-itens li {
                background-color: #FAF7F2;
                border: 1px solid #E5D9CE;
                border-radius: 10px;
                padding: 11px 16px;
                font-size: 15px;
                color: #2D1F17;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

        .item-num {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background-color: #C95A3B;
            color: #FFFFFF;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .local-entrega-box {
            background-color: #FDF3E7;
            border-left: 4px solid #C95A3B;
            border-radius: 8px;
            padding: 14px 16px;
            font-size: 14px;
            color: #5C463C;
            line-height: 1.5;
        }

            .local-entrega-box strong {
                color: #2D1F17;
                display: block;
                margin-bottom: 2px;
            }

        .voltar-container {
            text-align: center;
            margin: 40px 0;
        }

        .btn-voltar {
            display: inline-block;
            background-color: #C95A3B;
            color: #FFFFFF;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

            .btn-voltar:hover {
                background-color: #b04c30;
                transform: scale(1.05);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="doacoes-wrapper">
        <div class="doacoes-header">
            <h1>Ajude a manter o <span>MiAuDote</span></h1>
            <p>Toda contribuição ajuda a custear vacinas, castrações, alimentação e cuidados veterinários para os animais resgatados.</p>
        </div>

        <div class="doacoes-grid">
            <!-- CARD 1: DOE AQUI VIA PIX -->
            <div class="doacao-card">
                <div>
                    <h2>Doe <span>Aqui</span></h2>
                    <p class="sub">Faça uma transferência de qualquer valor via Pix. É rápido, seguro e vai direto para o cuidado dos pets.</p>

                    <div class="pix-box">
                        <span class="pix-tipo">Chave Pix (E-mail)</span>
                        <div class="pix-chave" id="textoChavePix">doacoes@miaudote.org</div>
                        <div class="pix-favorecido">Favorecido: Associação MiAuDote • CNPJ 12.345.678/0001-90</div>
                    </div>
                </div>

                <div>
                    <button type="button" class="btn-copiar-pix" onclick="copiarChavePix()">Copiar Chave Pix</button>
                    <span class="pix-feedback" id="msgPixCopiado"></span>
                </div>
            </div>

            <!-- CARD 2: OUTRAS DOAÇÕES -->
            <div class="doacao-card">
                <div>
                    <h2>Outras <span>Doações</span></h2>
                    <p class="sub">Também aceitamos doações físicas de suprimentos essenciais para o dia a dia do nosso abrigo:</p>

                    <ol class="lista-itens">
                        <li><span class="item-num">1</span> Cobertores, mantas e toalhas</li>
                        <li><span class="item-num">2</span> Remédios para pulgas, carrapatos e vermífugos</li>
                        <li><span class="item-num">3</span> Ração seca e úmida (cães e gatos)</li>
                        <li><span class="item-num">4</span> Areia higiênica e tapetes higiênicos</li>
                        <li><span class="item-num">5</span> Produtos de limpeza e desinfetantes pet</li>
                    </ol>
                </div>

                <div class="local-entrega-box">
                    <strong>Ponto de Entrega:</strong>
                    Entregar na sede do abrigo: Av. Rotary, 383 - Cruzeiro/SP<br />
                    De segunda a sábado, das 09h às 17h.
               
                </div>
            </div>
        </div>
    </div>

    <div class="voltar-container">
        <a href="home.aspx" class="btn-voltar">Voltar para a Página Inicial</a>
    </div>

    <script type="text/javascript">
        function copiarChavePix() {
            var chave = document.getElementById("textoChavePix").innerText;
            navigator.clipboard.writeText(chave).then(function () {
                document.getElementById("msgPixCopiado").innerText = "Chave Pix copiada com sucesso!";
            });
        }
    </script>
</asp:Content>

