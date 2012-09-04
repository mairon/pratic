// DATA DE HOJE IMPUT----------------------------------------------------------------
var montharray=new Array("01","02","03","04","05","06","07","08","09","10","11","12");


var mydate=new Date();
var year=mydate.getYear();
if ( year < 1900 );
year+=1900;
var day=mydate.getDay();
var month=mydate.getMonth();
var daym=mydate.getDate();

//change font size here
var cdate=""+daym+"/"+montharray[month]+"/"+year+""

//FIM DATA DE HOJE IMPUT----------------------------------------------------------------


function EnterTab(event,id)
{
    if( event.keyCode == 13 )
    {
        var wow = document.getElementById(id);
        wow.focus();
    }
}



function VendaFinancaTipoEnterTab(event)
{
    if( event.keyCode == 13 )
    {
        //contado
        if( document.getElementById('tipo_venda').value == 0)
        {
            var wow = document.getElementById('recebido');
            wow.focus();

        }
        //credito
        if( document.getElementById('tipo_venda').value == 1)
        {            
            var wow1 = document.getElementById('vendas_financa_valor_guarani_credito') ;
            wow1.focus();
            document.getElementById('vendas_financa_valor_guarani_credito').value = '';


        }
        //ordem
        if( document.getElementById('tipo_venda').value == 2)
        {
            var wow2 = document.getElementById('vendas_financa_cheque');
            wow2.focus();

        }

    }
}


function bloqEnter(objEvent) {
    var iKeyCode;
    iKeyCode = objEvent.keyCode;
    if(iKeyCode == 13) return false;
    return true;
}



function Formatadata(Campo, teclapres)  //
{
    var tecla = teclapres.keyCode;
    var vr = new String(Campo.value);
    vr = vr.replace("/", "");
    vr = vr.replace("/", "");
    vr = vr.replace("/", "");
    tam = vr.length + 1;
    if (tecla != 8 && tecla != 8)
    {
        if (tam > 0 && tam < 2)
            Campo.value = vr.substr(0, 2) ;
        if (tam > 2 && tam < 4)
            Campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2);
        if (tam > 4 && tam < 7)
            Campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/' + vr.substr(4, 7);
    }
}

function FormataCodContabil(){
v = document.getElementById("plano_de_conta_codigo").value;
v=v.replace(/\D/g,"") //Remove tudo o que não é dígito
v=v.replace(/^(\d{2})(\d)/,"$1.$2") //Coloca ponto entre o segundo e o terceiro dígitos
v=v.replace(/^(\d{2})\.(\d{2})(\d)/,"$1.$2.$3") //Coloca ponto entre o quinto e o sexto dígitos
v=v.replace(/\.(\d{2})(\d)/,".$1.$2") //Coloca uma barra entre o oitavo e o nono dígitos
v=v.replace(/(\d{3})(\d)/,"$1.$2") //Coloca um hífen depois do bloco de quatro dígitos
document.getElementById("plano_de_conta_codigo").value = v;
} 

function DataInicio()                   //
{
    document.getElementById('inicio').value = cdate;

}

function DataFinal()                    //
{
    document.getElementById('final').value = cdate;

}

//PULAR IMPUT------------------------------------------
function proximoCampo(atual,proximo)    //
{
    if(atual.value.length >= atual.maxLength){
        document.getElementById(proximo).focus();
    }
}
//FIM PULAR IMPUT


//UPCASE------------------------------------------------------------------------
function f(o)                           //
{
    o.value=o.value.toUpperCase().replace(/([^0-9A-Z.$,-/])/g," ");
}
// FIM UPCASE-------------------------------------------------------------------

// EDIT GRID--------------------------------------------------------------------
function cidades(id)                    //
{
    location.href="/cidades/edit/"+ id;
}

function clases(id)                     //
{
    location.href="/clases/edit/"+ id;
}

function produtos(id)                   //
{
    location.href="/produtos/"+ id;
}

function contas(id)                     //
{

    location.href="/contas/edit/"+ id;
}

function personas(id)                   //
{

    location.href="/personas/edit/"+ id;
}

function grupos(id)                     //
{

    location.href="/grupos/edit/"+ id;
}

function sub_grupos(id)                 //
{

    location.href="/sub_grupos/edit/"+ id;
}

function estados(id)                    //
{

    location.href="/estados/edit/"+ id;
}

function paises(id)                     //
{

    location.href="/paises/edit/"+ id;
}

function TabelaPrecoProdutoEdit(id)     //
{
    location.href="/produtos/edit_tabela_preco_produto/"+ id;
}

function PoliticaStockEdit(id)          //
{
    location.href="/produtos/edit_politica_stock/"+ id;
}

function AbrirHistoricoPreco(id)        //
{
    window.open('/produtos/historico_preco_produto/'+ id , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1200, HEIGHT=400');
}

function PopUpEditCompra(id)            //
{
    window.open('/compras_produtos/'+ id +'/edit', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function PopUpPrintRelatorioStock(url)  //
{
    window.open(url, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400');
    window.print(url, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400');
}

function FiltroProduto()                //
{
    window.open('/grupos/filtro_produto?busca='+ document.getElementById('prod').value, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400');
}


function DetalheProduto(id)                //
{
    window.open('/vendas/detalhes_produto?id='+ id, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400');
}


//FIM  EDIT GRID----------------------------------------------------------------

//ABRE  E FECHA DIV-------------------------------------------------------------
function toggleDiv(divid)               //
{
    if(document.getElementById(divid).style.display == 'none'){
        document.getElementById(divid).style.display = 'block';
    }else{
        document.getElementById(divid).style.display = 'none';
    }
}
//FIM ABRE  E FECHA DIV---------------------------------------------------------

//FOCO CAMPO--------------------------------------------------------------------

function FocoField(d)                   //
{
    document.getElementById(d).focus();
}


function Login()                        //
{
    document.getElementById("campo_unidade").focus();
}

function Button()                   //
{
    document.getElementById("venda_submit").focus();
}


function CampoBusca()                   //
{
    document.getElementById("busca").focus();
}

function CampoCompraDoc(id)             //
{
    document.getElementById("nomeproveedor").value = id;
    document.getElementById("nomeproveedor").focus();
}

function CampoProduto()                 //
{
    document.getElementById("codigo").focus();
}

function CampoProdutoE01()              //
{
    document.getElementById("vendas_produto_bomba_id").focus();
}

function CampoProdutoE03()              //
{
    document.getElementById("codigo").focus();
}


//FOCO CAMPO COMPRA-------------------------------------------------------------

function FechamentoTurnoData()          //
{
    document.getElementById("fechamento_turno_data_3i").focus();
}


function CampoInicio()             //
{
    document.getElementById("inicio").focus();
}

function CampoInicioFatura()             //
{
    document.getElementById("inicio_faturacao").focus();
}


function CampoTipo()               //
{
    document.getElementById("tipo").focus();
}

function CampoCompra()             //
{
    document.getElementById("compra_data_3i").focus();
}

function CampoCompraProduto()      //
{
    document.getElementById("key").focus();
}

function CampoCotacao(valor)       //
{
    document.getElementById("compras_produto_cotacao").value = valor;
}

function DataCompra()              //
{
    document.getElementById("key").value = document.getElementById("compra_data_3i").value+'/'+ document.getElementById("compra_data_2i").value+'/'+document.getElementById("compra_data_1i").value;

}

// FIM FOCO CAMPO COMPRA--------------------------------------------------------


// CALCULO COMPRA---------------------------------------------------------------
function CompraUnitGs()             //
{
    varcotacao = ( parseFloat( document.getElementById('compras_produto_unitario_dolar').value ) * parseFloat( document.getElementById('compras_produto_cotacao').value ) )  ;
    document.getElementById('compras_produto_unitario_guarani').value = varcotacao.toFixed(0);
}

function CompraUnitDolar()          //
{
    varcotacao = ( parseFloat( document.getElementById('compras_produto_unitario_guarani').value ) / parseFloat( document.getElementById('compras_produto_cotacao').value ) )  ;
    document.getElementById('compras_produto_unitario_dolar').value = varcotacao.toFixed(2);
}

function CompraUnitarioTotalDolar()         //
{
    v = document.getElementById('compras_produto_total_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compras_produto_total_dolar').value = v;

    vartotal = ( parseFloat( document.getElementById('compras_produto_total_dolar').value ) / parseFloat( document.getElementById('compras_produto_quantidade').value ) )  ;
    document.getElementById('compras_produto_unitario_dolar').value = vartotal.toFixed(2);
}

function CompraTotalDolar()         //
{
    v = document.getElementById('compras_produto_unitario_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compras_produto_unitario_dolar').value = v;

    vartotal = ( parseFloat( document.getElementById('compras_produto_unitario_dolar').value ) * parseFloat( document.getElementById('compras_produto_quantidade').value ) )  ;
    document.getElementById('compras_produto_total_dolar').value = vartotal.toFixed(2);
}


function CompraTotalGs()            //
{
    vartotal = ( parseFloat( document.getElementById('compras_produto_unitario_guarani').value ) * parseFloat( document.getElementById('compras_produto_quantidade').value ) )  ;
    document.getElementById('compras_produto_total_guarani').value = vartotal.toFixed(2);
}

function CompraUnitarioTotalGs()    //
{
    vartotal = ( parseFloat( document.getElementById('compras_produto_total_guarani').value ) / parseFloat( document.getElementById('compras_produto_quantidade').value ) )  ;
    document.getElementById('compras_produto_unitario_guarani').value = vartotal.toFixed(2);
}


function CompraIvaDolar()           //
{
    taxa = ( ( parseFloat( document.getElementById('compras_produto_iva_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( parseFloat( document.getElementById('compras_produto_total_dolar').value ) / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('compras_produto_iva_taxa').value ) ) / 100 );
    document.getElementById('compras_produto_iva_dolar').value = vartotal.toFixed(6);
}

function CompraIvaGs()              //
{
    taxa = ( ( parseFloat( document.getElementById('compras_produto_iva_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( parseFloat( document.getElementById('compras_produto_total_guarani').value ) / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('compras_produto_iva_taxa').value ) ) / 100 );
    document.getElementById('compras_produto_iva_guarani').value = vartotal.toFixed(6);
}

function CompraCustoContabilDolar() //
{
    vartotal = ( parseFloat( document.getElementById('compras_produto_total_dolar').value ) - parseFloat( document.getElementById('compras_produto_iva_dolar').value ) );
    vartotal = ( vartotal / parseFloat( document.getElementById('compras_produto_quantidade').value ) )
    document.getElementById('compras_produto_custo_contabil_dolar').value = vartotal.toFixed(2);

}

function CompraCustoContabilGs()    //
{
    vartotal = ( parseFloat( document.getElementById('compras_produto_total_guarani').value ) - parseFloat( document.getElementById('compras_produto_iva_guarani').value ) );
    vartotal = ( vartotal / parseFloat( document.getElementById('compras_produto_quantidade').value ) )
    document.getElementById('compras_produto_custo_contabil_guarani').value = vartotal.toFixed(2);

}

function CompraDescontoGs()         //
{
    v = document.getElementById('compra_desconto_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_desconto_dolar').value = v;

    if( document.getElementById('compra_desconto_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_desconto_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_desconto_guarani').value = varcotacao.toFixed(0);
    }
}

function CompraDescontoDolar()      //
{
    if( document.getElementById('compra_desconto_dolar').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_desconto_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_desconto_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraFreteGs()            //
{
    v = document.getElementById('compra_frete_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_frete_dolar').value = v;

    if( document.getElementById('compra_frete_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_frete_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_frete_guarani').value = varcotacao.toFixed(0);
    }
}


function CompraFreteDolar()         //
{
    if( document.getElementById('compra_frete_dolar').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_frete_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_frete_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraSeguroGs()           //
{
    v = document.getElementById('compra_seguro_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_seguro_dolar').value = v;

    if( document.getElementById('compra_seguro_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_seguro_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_seguro_guarani').value = varcotacao.toFixed(0);
    }
}

function CompraSeguroDolar()        //
{
    if( document.getElementById('compra_seguro_dolar').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_seguro_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_seguro_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraTotalDespachoGs()    //
{
    varcotacao = ( parseFloat( document.getElementById('total_documento_guarani').value ) - parseFloat( document.getElementById('total_invoice_guarani').value ) + parseFloat( document.getElementById('compra_iva_despacho_guarani').value ) )  ;
    document.getElementById('compra_despacho_guarani').value = varcotacao.toFixed(0);
    varcotacaodolard = ( document.getElementById('compra_despacho_guarani').value / document.getElementById('compra_cotacao').value );
    varcotacaodolari = ( document.getElementById('compra_iva_despacho_guarani').value / document.getElementById('compra_cotacao').value );
    document.getElementById('compra_despacho_dolar').value = varcotacaodolard.toFixed(6)
    document.getElementById('compra_iva_despacho_dolar').value = varcotacaodolari.toFixed(6)
}

function CompraTotalDespachoDolar() //
{
    v = document.getElementById('compra_iva_despacho_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_iva_despacho_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('total_documento_dolar').value ) - parseFloat( document.getElementById('total_invoice_dolar').value ) + parseFloat( document.getElementById('compra_iva_despacho_dolar').value ) )  ;
    document.getElementById('compra_despacho_dolar').value = varcotacao.toFixed(6);
    varcotacaodolard = ( document.getElementById('compra_despacho_dolar').value * document.getElementById('compra_cotacao').value );
    varcotacaodolari = ( document.getElementById('compra_iva_despacho_dolar').value * document.getElementById('compra_cotacao').value );
    document.getElementById('compra_despacho_guarani').value = varcotacaodolard.toFixed(6)
    document.getElementById('compra_iva_despacho_guarani').value = varcotacaodolari.toFixed(6)
}

function CompraDespachoGs()         //
{
    v = document.getElementById('compra_despacho_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_despacho_dolar').value = v;

    if( document.getElementById('compra_despacho_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_despacho_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_despacho_guarani').value = varcotacao.toFixed(6);
    }
}

function CompraDespachoDolar()      //
{
    if( document.getElementById('compra_despacho_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_despacho_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_despacho_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraIvaTotalGs()         //
{
    v = document.getElementById('compra_iva_total_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_iva_total_dolar').value = v;

    if( document.getElementById('compra_iva_total_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_iva_total_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_iva_total_guarani').value = varcotacao.toFixed(0);
    }
}

function CompraIvaTotalDolar()      //
{
    if( document.getElementById('compra_iva_total_dolar').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_iva_total_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_iva_total_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraOtrosGs()            //
{
    v = document.getElementById('compra_outros_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compra_outros_dolar').value = v;

    if( document.getElementById('compra_outros_guarani').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_outros_dolar').value ) * parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_outros_guarani').value = varcotacao.toFixed(0);
    }
}

function CompraOutrosDolar()        //
{
    if( document.getElementById('compra_outros_dolar').value == 0 )
    {
        varcotacao = ( parseFloat( document.getElementById('compra_outros_guarani').value ) / parseFloat( document.getElementById('compra_cotacao').value ) )  ;
        document.getElementById('compra_outros_dolar').value = varcotacao.toFixed(2);
    }
}

function CompraDocGravada05Gs()     //
{
    if( document.getElementById( 'compras_documento_imposto_05_guarani' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compras_documento_gravadas_05_guarani' ).value ) / 1.05 );
        document.getElementById( 'compras_documento_imposto_05_guarani' ).value = ( vartotal * 0.05 ).toFixed(0);
    }
}

function CompraDocGravada05Dolar()   //
{
    if( document.getElementById( 'compras_documento_imposto_05_dolar' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compras_documento_gravadas_05_dolar' ).value ) / 1.05 );
        document.getElementById( 'compras_documento_imposto_05_dolar' ).value = ( vartotal * 0.05 ).toFixed(2);
    }
}

function CompraDocGravada10Gs()     //
{
    if( document.getElementById( 'compras_documento_imposto_10_guarani' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compras_documento_gravadas_10_guarani' ).value ) / 1.1 );
        document.getElementById( 'compras_documento_imposto_10_guarani' ).value = ( vartotal * 0.10 ).toFixed(0);
    }
    imposto10Gs = parseFloat( document.getElementById('compras_documento_gravadas_10_guarani').value )
    imposto05Gs = parseFloat( document.getElementById('compras_documento_gravadas_05_guarani').value )
    exentas     = parseFloat( document.getElementById('compras_documento_exentas_guarani').value )
    document.getElementById( 'compras_documento_total_guarani' ).value = ( imposto10Gs + imposto05Gs + exentas )
}

function CompraDocGravada10Dolar()  //
{
    if( document.getElementById( 'compras_documento_imposto_10_dolar' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compras_documento_gravadas_10_dolar' ).value ) / 1.1 );
        document.getElementById( 'compras_documento_imposto_10_dolar' ).value = ( vartotal * 0.10 ).toFixed(2);
    }
    imposto10Dolar = parseFloat( document.getElementById('compras_documento_gravadas_10_dolar').value )
    imposto05Dolar = parseFloat( document.getElementById('compras_documento_gravadas_05_dolar').value )
    exentas        = parseFloat( document.getElementById('compras_documento_exentas_dolar').value )
    document.getElementById( 'compras_documento_total_dolar' ).value = ( imposto10Dolar + imposto05Dolar + exentas ).toFixed(2)

}

function LimpaCampoCompraImportacao()//
{
    if ( document.getElementById('tipo_compra').value == '2' )
    {
        document.getElementById("compras_produto_iva_taxa").value = '0';
    }
}


//CALCULO COMPRAS FINANCAS------------------------------------------------------
function CompraUnitFinancaGs()      //
{
    v = document.getElementById('compras_financa_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compras_financa_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('compras_financa_valor_dolar').value ) * parseFloat( document.getElementById('compras_financa_cotacao').value ) )  ;
    document.getElementById('compras_financa_valor_guarani').value = varcotacao.toFixed(0);
}

function CompraUnitFinancaDolar()   //
{
    varcotacao = ( parseFloat( document.getElementById('compras_financa_valor_guarani').value ) / parseFloat( document.getElementById('compras_financa_cotacao').value ) )  ;
    document.getElementById('compras_financa_valor_dolar').value = varcotacao.toFixed(2);
}

//FIM CALCULO COMPRAS FINANCAS------------------------------------------------------


//FIM CALCULO COMPRA------------------------------------------------------------



// FOCO CAMPO VENDA-------------------------------------------------------------

function DataVenda()                //
{
    document.getElementById("key").value = document.getElementById("venda_data_3i").value+'/'+ document.getElementById("venda_data_2i").value+'/'+document.getElementById("venda_data_1i").value;

}

function CampoVenda()               //
{
    document.getElementById("venda_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------


// CALCULO VENDA PRODUTOS-------------------------------------------------------

function VendaUnitGs()             //

{
    v = document.getElementById('vendas_produto_unitario_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('vendas_produto_unitario_dolar').value = v;

    vartotal = ( parseFloat( document.getElementById('vendas_produto_unitario_dolar').value ) * parseFloat( document.getElementById('vendas_produto_cotacao').value ) )  ;
    document.getElementById('vendas_produto_unitario_guarani').value = vartotal.toFixed(2);
}

function VendaUnitDolar()          //
{
    vartotal = ( parseFloat( document.getElementById('vendas_produto_unitario_guarani').value ) / parseFloat( document.getElementById('vendas_produto_cotacao').value ) )  ;
    document.getElementById('vendas_produto_unitario_dolar').value = vartotal.toFixed(2);
}

function VendaTotalDolar()         //
{
    vartotal = ( parseFloat( document.getElementById('vendas_produto_unitario_dolar').value ) * parseFloat( document.getElementById('vendas_produto_quantidade').value ) )  ;
    document.getElementById('vendas_produto_total_dolar').value = vartotal.toFixed(2);
}

function VendaTotalGs()            //
{
    vartotal = ( parseFloat( document.getElementById('vendas_produto_unitario_guarani').value ) * parseFloat( document.getElementById('vendas_produto_quantidade').value ) )  ;
    document.getElementById('vendas_produto_total_guarani').value = vartotal.toFixed(0);
}

function VendaIvaDolar()           //
{
    taxa = ( ( parseFloat( document.getElementById('vendas_produto_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( parseFloat( document.getElementById('vendas_produto_total_dolar').value ) / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('vendas_produto_taxa').value ) ) / 100 );
    document.getElementById('vendas_produto_iva_dolar').value = vartotal.toFixed(6);
}

function VendaIvaGs()              //
{
    taxa = ( ( parseFloat( document.getElementById('vendas_produto_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( parseFloat( document.getElementById('vendas_produto_total_guarani').value ) / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('vendas_produto_taxa').value ) ) / 100 );
    document.getElementById('vendas_produto_iva_guarani').value = vartotal.toFixed(6);
}


function VendaPersona()            //
{
    document.getElementById('vendas_financa_persona_nome').value = document.getElementById('vendas_financa_persona_busca_').value ;
}

function VendaTotalDolarQuantidade()         //
{
    vartotal = ( parseFloat( document.getElementById('vendas_produto_total_guarani').value ) / parseFloat( document.getElementById('vendas_produto_cotacao').value ) )  ;
    document.getElementById('vendas_produto_total_dolar').value = vartotal.toFixed(2);
}

function VendaTotalGsQuantidade()            //
{
    vartotal = ( parseFloat( document.getElementById('vendas_produto_total_guarani').value ) / parseFloat( document.getElementById('vendas_produto_unitario_guarani').value ) )  ;
    document.getElementById('vendas_produto_quantidade').value = vartotal;
}

//FIM CALCULO VENDA------------------------------------------------------------




//VALIDACAO BOTAO SEGUIR COMPRA----------------------------------------------------
function SeguirCompraProduto(count)   //
{
    if ( count == 0  )
    {
        alert ('Adicione un Producto!');
        return false;
    }
    else
    {
        location.href="/compras/compras_financa/"+ document.getElementById('id').value;
    }
}

function SeguirCompraFinanca(count)   //
{
    if ( count == 0  )
    {
        alert ('Adicione una Cota!');
        return false;
    }
    else
    {
        location.href="/compras/compras_documento/"+ document.getElementById('id').value;
    }
}

//FIM VALIDACAO BOTAO SEGUIR COMPRA----------------------------------------------------




// FOCO CAMPO VENDA-------------------------------------------------------------

function DataProdutoCotacao()               //
{
    document.getElementById("key").value = document.getElementById("produto_data_3i").value+'/'+ document.getElementById("produto_data_2i").value+'/'+document.getElementById("produto_data_1i").value;

}

function CampoProdutoCotacao()              //
{
    document.getElementById("produto_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------


//CALCULO COMPRAS FINANCAS------------------------------------------------------
function ProdutoGs()      //
{
    varcotacao = ( parseFloat( document.getElementById('produto_preco_venda_dolar').value ) * parseFloat( document.getElementById('produto_cotacao').value ) )  ;
    document.getElementById('produto_preco_venda_guarani').value = varcotacao.toFixed(0);
}

function ProdutoDolar()   //
{
    varcotacao = ( parseFloat( document.getElementById('produto_preco_venda_guarani').value ) / parseFloat( document.getElementById('produto_cotacao').value ) )  ;
    document.getElementById('produto_preco_venda_dolar').value = varcotacao.toFixed(2);
}

//FIM CALCULO COMPRAS FINANCAS------------------------------------------------------
//
//
/////////////////////////////////////////////////////


//CALCULO VENDA FINANCAS------------------------------------------------------

function CompraDocumentoTipo(valor)      //

{
    document.getElementById('tipo').value = valor
}



function MascaraMoeda(f)                 //
{
    v = f.value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    f.value = v;

}


//EXIBE DIV VENDA FINANZA-------------------------------------------------------


function ExibeDivCompra()   //
{

    if ( document.getElementById('tipomoeda').value == 'DOLAR' )
    {
        document.getElementById('DOLAR').style.display = "inline";
        document.getElementById('GUARANI').style.display = "none";
        document.getElementById("compras_documento_exentas_dolar").focus();
    }

    if ( document.getElementById('tipomoeda').value == 'GUARANI' )
    {
        document.getElementById('GUARANI').style.display = "inline";
        document.getElementById('DOLAR').style.display = "none";
        document.getElementById("compras_documento_exentas_guarani").focus();
    }

}
//EXIBE DIV VENDA FINANZA-------------------------------------------------------


// COBRO COTACAO-------------------------------------------------------------

function DataCobro()                      //
{
    document.getElementById("key").value = document.getElementById("cobro_data_3i").value+'/'+ document.getElementById("cobro_data_2i").value+'/'+document.getElementById("cobro_data_1i").value;

}

function CampoCobro()                     //
{
    document.getElementById("cobro_cotacao").focus();
}

function CotacaoCobroGs()                 //
{
    v = document.getElementById('cobros_detalhe_cobro_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('cobros_detalhe_cobro_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('cobros_detalhe_cobro_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobros_detalhe_cobro_guarani').value = varcotacao.toFixed(0);
}

function CotacaoCobroDolar()              //
{
    varcotacao = ( parseFloat( document.getElementById('cobros_detalhe_cobro_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobros_detalhe_cobro_dolar').value = varcotacao.toFixed(2);
}

function CotacaoCobroFinalGs()            //
{
    v = document.getElementById('cobro_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('cobro_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('cobro_valor_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobro_valor_guarani').value = varcotacao.toFixed(0);
}

function CotacaoCobroFinalDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('cobro_valor_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobro_valor_dolar').value = varcotacao.toFixed(2);
}


//FIM CAMBIO COTACAO-------------------------------------------------------------



//  PAGO COTACAO-------------------------------------------------------------

function DataPago()                      //
{
    document.getElementById("key").value = document.getElementById("pago_data_3i").value+'/'+ document.getElementById("pago_data_2i").value+'/'+document.getElementById("pago_data_1i").value;

}

function CampoPago()                     //
{
    document.getElementById("pago_cotacao").focus();
}

function CotacaoPagoGs()                 //
{
    v = document.getElementById('pagos_detalhe_pago_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('pagos_detalhe_pago_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('pagos_detalhe_pago_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pagos_detalhe_pago_guarani').value = varcotacao.toFixed(0);
}

function CotacaoPagoDolar()              //
{
    varcotacao = ( parseFloat( document.getElementById('pagos_detalhe_pago_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pagos_detalhe_pago_dolar').value = varcotacao.toFixed(2);
}

function CotacaoPagoFinalGs()            //
{
    v = document.getElementById('pago_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('pago_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('pago_valor_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pago_valor_guarani').value = varcotacao.toFixed(0);
}

function CotacaoPagoFinalDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('pago_valor_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pago_valor_dolar').value = varcotacao.toFixed(2);
}


//FIM FOCO CAMPO VENDA----------------------------------------------------------


//  CUSTO PRODUTO  -------------------------------------------------------------

function PrecoMinoristaProduto()         //
{
    varmargem   = ( parseFloat( document.getElementById('produto_margem_minorista').value ) / 100 )  ;
    varminoristad = ( ( varmargem  *  parseFloat( document.getElementById('produto_custo_produto_dolar_iva').value ) )  + parseFloat( document.getElementById('produto_custo_produto_dolar_iva').value ) )
    document.getElementById('produto_preco_minorista_dolar').value   = varminoristad.toFixed(2);
    varminoristag =  ( varminoristad * document.getElementById('produto_cotacao').value )
    document.getElementById('produto_preco_minorista_guarani').value   = varminoristag.toFixed(0);
}

function PrecoMaioristaProduto()         //
{
    varmargem   = ( parseFloat( document.getElementById('produto_margem_maiorista').value ) / 100 )  ;
    varminoristad = ( ( varmargem  *  parseFloat( document.getElementById('produto_custo_produto_dolar_iva').value ) )  + parseFloat( document.getElementById('produto_custo_produto_dolar_iva').value ) )
    document.getElementById('produto_preco_maiorista_dolar').value   = varminoristad.toFixed(2);
    varminoristag =  ( varminoristad * document.getElementById('produto_cotacao').value )
    document.getElementById('produto_preco_maiorista_guarani').value   = varminoristag.toFixed(0);
}

//  FIM CUSTO PRODUTO  ---------------------------------------------------------



// FOCO CAMPO ORDEM SERVICO-------------------------------------------------------------

function DataOrdem()                //
{
    document.getElementById("key").value = document.getElementById("ordem_servico_data_3i").value+'/'+ document.getElementById("ordem_servico_data_2i").value+'/'+document.getElementById("ordem_servico_data_1i").value;

}

function CampoOrdem()               //
{
    document.getElementById("ordem_servico_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------



//CALCULO VENDA FINANCAS------------------------------------------------------
function UnitFinancaGsOrdem()            //
{
    v = document.getElementById('ordem_servicos_financa_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('ordem_servicos_financa_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('ordem_servicos_financa_valor_dolar').value ) * parseFloat( document.getElementById('ordem_servicos_financa_cotacao').value ) )  ;
    document.getElementById('ordem_servicos_financa_valor_guarani').value = varcotacao.toFixed(0);
}

function UnitFinancaDolarOrdem()         //
{
    varcotacao = ( parseFloat( document.getElementById('ordem_servicos_financa_valor_guarani').value ) / parseFloat( document.getElementById('ordem_servicos_financa_cotacao').value ) )  ;
    document.getElementById('ordem_servicos_financa_valor_dolar').value = varcotacao.toFixed(2);
}

//CALCULO VENDA FINANCAS------------------------------------------------------


//PRINT VENDAS------------------------------------------------------------------
function PrintPreNotaVenda(url)                     //
{
    window.open(url, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400');
}


//ABRE  E FECHA DIV-------------------------------------------------------------
function toggleDiv(divid)          //
{
    if(document.getElementById(divid).style.display == 'none'){
        document.getElementById(divid).style.display = 'block';
    }else{
        document.getElementById(divid).style.display = 'none';
    }
}
//FIM ABRE  E FECHA DIV---------------------------------------------------------

//FOCO CAMPO--------------------------------------------------------------------


function CampoTipoVendaFinanca()   //
{
    if ( document.getElementById('cota').value == 1 )
    {
        document.getElementById("tipo").focus();
    }
    
}

//FOCO CAMPO COMPRA-------------------------------------------------------------


function CampoBusca()              //
{
    document.getElementById("busca").focus();
}


function CampoCompraProduto()      //
{
    document.getElementById("key").focus();
}

function CampoCotacao(valor)       //
{
    document.getElementById("compras_produto_cotacao").value = valor;
}

function DataCompra()              //
{
    document.getElementById("key").value = document.getElementById("compra_data_3i").value+'/'+ document.getElementById("compra_data_2i").value+'/'+document.getElementById("compra_data_1i").value;

}

// FIM FOCO CAMPO COMPRA--------------------------------------------------------


// FOCO CAMPO VENDA-------------------------------------------------------------

function DataVenda()               //
{
    document.getElementById("key").value = document.getElementById("venda_data_3i").value+'/'+ document.getElementById("venda_data_2i").value+'/'+document.getElementById("venda_data_1i").value;

}

function CampoVenda()              //
{
    document.getElementById("venda_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------


//CALCULO COMPRAS FINANCAS------------------------------------------------------
function CompraUnitFinancaGs()      //
{
    v = document.getElementById('compras_financa_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('compras_financa_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('compras_financa_valor_dolar').value ) * parseFloat( document.getElementById('compras_financa_cotacao').value ) )  ;
    document.getElementById('compras_financa_valor_guarani').value = varcotacao.toFixed(0);
}

function CompraUnitFinancaDolar()   //
{
    varcotacao = ( parseFloat( document.getElementById('compras_financa_valor_guarani').value ) / parseFloat( document.getElementById('compras_financa_cotacao').value ) )  ;
    document.getElementById('compras_financa_valor_dolar').value = varcotacao.toFixed(2);
}

//FIM CALCULO COMPRAS FINANCAS------------------------------------------------------

//VALIDACAO BOTAO SEGUIR COMPRA----------------------------------------------------
function SeguirCompraProduto(count)   //
{
    if ( count == 0  )
    {
        alert ('Adicione un Producto!');
        return false;
    }
    else
    {
        location.href="http://localhost:3000/compras/compras_financa/"+ document.getElementById('id').value;
    }
}

function SeguirCompraFinanca(count)   //
{
    if ( count == 0  )
    {
        alert ('Adicione una Cota!');
        return false;
    }
    else
    {
        location.href="http://localhost:3000/compras/compras_documento/"+ document.getElementById('id').value;
    }
}

function SeguirCompraDocumento(count) //
{
    if ( count == 0  )
    {
        alert ('Adicione un Documento!');
        return false;
    }
    else
    {
        location.href="http://localhost:3000/compras";
    }
}
//FIM VALIDACAO BOTAO SEGUIR COMPRA----------------------------------------------------




// FOCO CAMPO VENDA-------------------------------------------------------------

function DataProdutoCotacao()               //
{
    document.getElementById("key").value = document.getElementById("produto_data_3i").value+'/'+ document.getElementById("produto_data_2i").value+'/'+document.getElementById("produto_data_1i").value;

}

function CampoProdutoCotacao()              //
{
    document.getElementById("produto_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------


//CALCULO COMPRAS FINANCAS------------------------------------------------------
function ProdutoGs()      //
{
    varcotacao = ( parseFloat( document.getElementById('produto_preco_venda_dolar').value ) * parseFloat( document.getElementById('produto_cotacao').value ) )  ;
    document.getElementById('produto_preco_venda_guarani').value = varcotacao.toFixed(0);
}

function ProdutoDolar()   //
{
    varcotacao = ( parseFloat( document.getElementById('produto_preco_venda_guarani').value ) / parseFloat( document.getElementById('produto_cotacao').value ) )  ;
    document.getElementById('produto_preco_venda_dolar').value = varcotacao.toFixed(2);
}

//FIM CALCULO COMPRAS FINANCAS------------------------------------------------------


    function MoedaVendaFinanca(d)                 //

    {
        document.getElementById('tipo_troco').value = d
    }



function TrocoProdutoFinanca()      //
{
    if ( document.getElementById('vendas_financa_moeda').value == 0 )
    {
        v = document.getElementById('recebido').value;
        v=v.replace(/\D/g,"")  //permite digitar apenas números
        v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
        v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
        v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
        v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
        document.getElementById('recebido').value = v;

        vartrocod = ( parseFloat( document.getElementById('recebido').value ) - parseFloat( document.getElementById('valor_dolar_contado').value ) )  ;
        document.getElementById('troco_dolar').value = vartrocod.toFixed(2);
        document.getElementById('mostra_dolar').innerHTML  = '<span>'+vartrocod.toFixed(2)+'</span>';

        varcotacaod = ( parseFloat( document.getElementById('troco_dolar').value ) * parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
        document.getElementById('troco_guarani').value = varcotacaod.toFixed(0);
        document.getElementById('mostra_guarani').innerHTML  = '<span>'+varcotacaod.toFixed(0)+'</span>';

        document.getElementById('cotacao_dolar').value = parseFloat( document.getElementById('recebido').value )

        varcotacaogd = ( parseFloat( document.getElementById('recebido').value ) * parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
        document.getElementById('cotacao_guarani').value = varcotacaogd.toFixed(0);

    }
    else
    {
        vartrocog = ( parseFloat( document.getElementById('recebido').value ) - parseFloat( document.getElementById('valor_guarani_contado').value ) )  ;
        document.getElementById('troco_guarani').value = vartrocog.toFixed(2);
        document.getElementById('mostra_guarani').innerHTML  = '<span>'+vartrocog.toFixed(0)+'</span>';

        varcotacaog = ( parseFloat( document.getElementById('troco_guarani').value ) / parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
        document.getElementById('troco_dolar').value = varcotacaog.toFixed(2);
        document.getElementById('mostra_dolar').innerHTML  = '<span>'+varcotacaog.toFixed(2)+'</span>';

        document.getElementById('cotacao_guarani').value = parseFloat( document.getElementById('recebido').value )

        varcotacaodg = ( parseFloat( document.getElementById('recebido').value ) / parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
        document.getElementById('cotacao_dolar').value = varcotacaodg.toFixed(2);


    }
}
//FIM CALCULO VENDA FINANCAS------------------------------------------------------


//CALCULO VENDA FINANCAS------------------------------------------------------
function UnitFinancaGsVenda()            //
{

    varcotacao = ( parseFloat( document.getElementById('vendas_financa_valor_dolar_credito').value ) * parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
    document.getElementById('vendas_financa_valor_guarani_credito').value = varcotacao.toFixed(0);
}

function UnitFinancaDolarVenda()         //
{
    varcotacao = ( parseFloat( document.getElementById('vendas_financa_valor_guarani_credito').value ) / parseFloat( document.getElementById('vendas_financa_cotacao').value ) )  ;
    document.getElementById('vendas_financa_valor_dolar_credito').value = varcotacao.toFixed(4);
}

function MascaraMoeda(f)                 //
{
    v = f.value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    f.value = v;

}


//EXIBE DIV VENDA FINANZA-------------------------------------------------------

function TipoVenda(d)      //

{
    if (d.options[d.selectedIndex].innerHTML == 'CONTADO')
    {
        document.getElementById('tipo_venda').value = 0
    }

    if (d.options[d.selectedIndex].innerHTML == 'CREDITO')
    {
        document.getElementById('tipo_venda').value = 1
    }
    if (d.options[d.selectedIndex].innerHTML == 'ORDEN')
    {
        document.getElementById('tipo_venda').value = 2
    }
    
}

function ExibeDivVenda()   //
{

    if ( document.getElementById('tipo_venda').value == 0 )
    {
        document.getElementById('CONTADO').style.display                        = "inline";
        document.getElementById('ORDEN').style.display                          = "none";
        document.getElementById('ORDEN_VUELTO').style.display                   = "inline";
        document.getElementById('CREDITO').style.display                        = "none";
        document.getElementById('vendas_financa_tipo').value                    = 0
        document.getElementById('vendas_financa_tipo_ordem').value              = 0
        document.getElementById('vendas_financa_valor_dolar_contado').value     = 0
        document.getElementById('vendas_financa_valor_guarani_contado').value   = 0

    }

    if ( document.getElementById('tipo_venda').value == 1 )
    {
        document.getElementById('CREDITO').style.display           = "inline";
        document.getElementById('CONTADO').style.display           = "none";
        document.getElementById('ORDEN').style.display             = "inline";
        document.getElementById('vendas_financa_tipo').value       = 1
        document.getElementById('vendas_financa_tipo_ordem').value = 0
        document.getElementById('vendas_financa_valor_dolar_credito').value     = 0
        document.getElementById('vendas_financa_valor_guarani_credito').value   = 0

    }

    if ( document.getElementById('tipo_venda').value == 2 )
    {
        document.getElementById('ORDEN').style.display                          = "inline";
        document.getElementById('CREDITO').style.display                        = "none";
        document.getElementById('ORDEN_VUELTO').style.display                   = "none";
        document.getElementById('CONTADO').style.display                        = "none";
        document.getElementById('vendas_financa_tipo').value                    = 1
        document.getElementById('vendas_financa_tipo_ordem').value              = 1
        document.getElementById('vendas_financa_valor_dolar_credito').value     = document.getElementById('valor_dolar_contado').value
        document.getElementById('vendas_financa_valor_guarani_credito').value   = document.getElementById('valor_guarani_contado').value
    }


}

function ExibeDivVendaE03()//
{

    if ( document.getElementById('vendas_financa_tipo').value == 0 )
    {
        document.getElementById('CONTADO').style.display                        = "inline";
        document.getElementById('CREDITO').style.display                        = "none";
        document.getElementById('vendas_financa_tipo').value                    = 0

    }

    if ( document.getElementById('vendas_financa_tipo').value == 1 )
    {
        document.getElementById('CREDITO').style.display           = "inline";
        document.getElementById('CONTADO').style.display           = "none";        
        document.getElementById('vendas_financa_tipo').value       = 1

    }

}



function CotaMaiorExibeDivVendaCota()   //
{
    if ( document.getElementById('cota').value != 1 )
    {
        if ( document.getElementById('tipo_venda').value == 0 )
        {
            document.getElementById('CONTADO').style.display = "inline";
            document.getElementById('CREDITO').style.display = "none";
            document.getElementById('vendas_financa_tipo').value = '0'
        }

        if ( document.getElementById('tipo_venda').value == 1 )
        {
            document.getElementById('CREDITO').style.display = "inline";
            document.getElementById('CONTADO').style.display = "none";
            document.getElementById('vendas_financa_tipo').value = '1'
        }
    }
}

//EXIBE DIV VENDA FINANZA-------------------------------------------------------

// FOCO CAMPO COBRO COTACAO-------------------------------------------------------------

function DataCobro()               //
{
    document.getElementById("key").value = document.getElementById("cobro_data_3i").value+'/'+ document.getElementById("cobro_data_2i").value+'/'+document.getElementById("cobro_data_1i").value;

}

function CampoCobro()              //
{
    document.getElementById("cobro_cotacao").focus();
}
//FIM FOCO CAMPO VENDA----------------------------------------------------------------


// CAMBIO COTACAO-------------------------------------------------------------

function CotacaoCobroGs()            //
{
    v = document.getElementById('cobros_detalhe_cobro_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('cobros_detalhe_cobro_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('cobros_detalhe_cobro_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobros_detalhe_cobro_guarani').value = varcotacao.toFixed(0);
}

function CotacaoCobroDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('cobros_detalhe_cobro_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobros_detalhe_cobro_dolar').value = varcotacao.toFixed(2);
}

function CotacaoCobroFinalGs()            //
{
    v = document.getElementById('cobro_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('cobro_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('cobro_valor_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobro_valor_guarani').value = varcotacao.toFixed(0);
}

function CotacaoCobroFinalDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('cobro_valor_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('cobro_valor_dolar').value = varcotacao.toFixed(2);
}


//FIM CAMBIO COTACAO-------------------------------------------------------------





// FOCO CAMPO PAGO COTACAO-------------------------------------------------------------

function DataPago()               //
{
    document.getElementById("key").value = document.getElementById("pago_data_3i").value+'/'+ document.getElementById("pago_data_2i").value+'/'+document.getElementById("pago_data_1i").value;

}

function CampoPago()              //
{
    document.getElementById("pago_cotacao").focus();
}

function CotacaoPagoGs()            //
{
    v = document.getElementById('pagos_detalhe_pago_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('pagos_detalhe_pago_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('pagos_detalhe_pago_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pagos_detalhe_pago_guarani').value = varcotacao.toFixed(0);
}

function CotacaoPagoDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('pagos_detalhe_pago_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pagos_detalhe_pago_dolar').value = varcotacao.toFixed(2);
}

function CotacaoPagoFinalGs()            //
{
    v = document.getElementById('pago_valor_dolar').value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    document.getElementById('pago_valor_dolar').value = v;

    varcotacao = ( parseFloat( document.getElementById('pago_valor_dolar').value ) * parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pago_valor_guarani').value = varcotacao.toFixed(0);
}

function CotacaoPagoFinalDolar()         //
{
    varcotacao = ( parseFloat( document.getElementById('pago_valor_guarani').value ) / parseFloat( document.getElementById('cotacao').value ) )  ;
    document.getElementById('pago_valor_dolar').value = varcotacao.toFixed(2);
}


//FIM FOCO CAMPO VENDA----------------------------------------------------------------


function MoedaCompra(d)                //

{
    document.getElementById('moeda').value = d
}

function TipoCompra(d)                 //

{
    document.getElementById('tipo').value = d
}


function ExibeDivCompraFinanca()       //
{

    if ( document.getElementById('moeda').value == '0' && document.getElementById('tipo').value == '0')
    {
        document.getElementById('TIPO_CONTADO').style.display  = "inline";
        document.getElementById('TIPO_CREDITO').style.display  = "none";
        document.getElementById('compra_documento_id').value   = 2
    }
    else if ( document.getElementById('moeda').value == '1' && document.getElementById('tipo').value == '0')
    {
        document.getElementById('TIPO_CONTADO').style.display  = "inline";
        document.getElementById('TIPO_CREDITO').style.display  = "none";
        document.getElementById('compra_documento_id').value   = 2
    }

    else if ( document.getElementById('moeda').value == '0' && document.getElementById('tipo').value == '1')
    {
        document.getElementById('TIPO_CONTADO').style.display  = "none";
        document.getElementById('TIPO_CREDITO').style.display  = "inline";
        document.getElementById('CREDITO_PARCELA_DOLAR').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_01').style.display   = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_02').style.display   = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_03').style.display   = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_04').style.display   = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_05').style.display   = "inline";
        document.getElementById('CREDITO_MOEDA_DOLAR_06').style.display   = "inline";
        document.getElementById('CREDITO_PARCELA_GUARANI').style.display  = "none";
        document.getElementById('CREDITO_MOEDA_GUARANI_02').style.display = "none";
        document.getElementById('CREDITO_MOEDA_GUARANI_03').style.display = "none";
        document.getElementById('CREDITO_MOEDA_GUARANI_04').style.display = "none";
        document.getElementById('CREDITO_MOEDA_GUARANI_05').style.display = "none";
        document.getElementById('CREDITO_MOEDA_GUARANI_06').style.display = "none";
        document.getElementById('compra_documento_id').value   = 3
    }
    else if ( document.getElementById('moeda').value == '1' && document.getElementById('tipo').value == '1')
    {
        document.getElementById('TIPO_CONTADO').style.display  = "none";
        document.getElementById('TIPO_CREDITO').style.display  = "inline";
        document.getElementById('CREDITO_PARCELA_DOLAR').style.display       = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_01').style.display      = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_02').style.display      = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_03').style.display      = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_04').style.display      = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_05').style.display      = "none";
        document.getElementById('CREDITO_MOEDA_DOLAR_06').style.display      = "none";
        document.getElementById('CREDITO_PARCELA_GUARANI').style.display     = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_01').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_02').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_03').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_04').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_05').style.display    = "inline";
        document.getElementById('CREDITO_MOEDA_GUARANI_06').style.display    = "inline";
        document.getElementById('compra_documento_id').value   = 3
    }

}


function ExibeDivCompraDetalheFatura() //
{

    if ( document.getElementById('moeda').value == '0' )
    {
        document.getElementById('MOEDA_FATURA_DOLAR').style.display    = "inline";
        document.getElementById('MOEDA_FATURA_GUARANI').style.display  = "none";
    }
    else if ( document.getElementById('moeda').value == '1' )
    {
        document.getElementById('MOEDA_FATURA_GUARANI').style.display  = "inline";
        document.getElementById('MOEDA_FATURA_DOLAR').style.display    = "none";

    }

}



function CompraGravada05Gs()        //
{
    if( document.getElementById( 'compra_imposto_05_guarani' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_05_guarani' ).value ) / 1.05 );
        document.getElementById( 'compra_imposto_05_guarani' ).value = ( vartotal * 0.05 ).toFixed(0);
    }
}

function CompraGravada05Dolar()     //
{
    if( document.getElementById( 'compra_imposto_05_dolar' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_05_dolar' ).value ) / 1.05 );
        document.getElementById( 'compra_imposto_05_dolar' ).value = ( vartotal * 0.05 ).toFixed(2);
    }
}

function CompraGravada10Gs()        //
{

    vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_10_guarani' ).value ) / 1.1 );
    document.getElementById( 'compra_imposto_10_guarani' ).value = ( vartotal * 0.10 ).toFixed(0);

    imposto10Gs = parseFloat( document.getElementById('compra_gravadas_10_guarani').value )
    imposto05Gs = parseFloat( document.getElementById('compra_gravadas_05_guarani').value )
    exentas     = parseFloat( document.getElementById('compra_exentas_guarani').value )
    document.getElementById( 'compra_total_guarani' ).value = ( imposto10Gs + imposto05Gs + exentas )
}

function CompraGravada10Dolar()     //
{

    vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_10_dolar' ).value ) / 1.1 );
    document.getElementById( 'compra_imposto_10_dolar' ).value = ( vartotal * 0.10 ).toFixed(2);

    imposto10Dolar = parseFloat( document.getElementById('compra_gravadas_10_dolar').value )
    imposto05Dolar = parseFloat( document.getElementById('compra_gravadas_05_dolar').value )
    exentas        = parseFloat( document.getElementById('compra_exentas_dolar').value )
    document.getElementById( 'compra_total_dolar' ).value = ( imposto10Dolar + imposto05Dolar + exentas ).toFixed(2)

}

function SeguirCompraFinanca()      //
{
    if ( document.getElementById('tipo').value == 0  )
    {
        if ( document.getElementById('fatura_total_dolar').value != document.getElementById('produto_total_dolar').value  )
        {
            alert ('El total de la factura no corresponde a los productos totales');
            return false;
        }
        else
        {
            location.href="/compras/index_compra" ;
        }

    }
    else
    {
        if ( document.getElementById('fatura_total_guarani').value != document.getElementById('produto_total_guarani').value  )
        {
            alert ('El total de la factura no corresponde a los productos totales');
            return false;
        }
        else
        {
            location.href="/compras/index_compra" ;
        }
    }
}

function SeguirCompraGastoFinanca() //
{
    if ( document.getElementById('tipo').value == 0  )
    {
        if ( document.getElementById('fatura_total_dolar').value != document.getElementById('produto_total_dolar').value  )
        {
            alert ('El total de la factura no corresponde a los productos totales');
            return false;
        }
        else
        {
            location.href="/compras/index_gasto" ;
        }

    }
    else
    {
        if ( document.getElementById('fatura_total_guarani').value != document.getElementById('produto_total_guarani').value  )
        {
            alert ('El total de la factura no corresponde a los productos totales');
            return false;
        }
        else
        {
            location.href="/compras/index_gasto" ;
        }
    }
}

function AcrecentaNumeroCompraFactura1() //
{
    document.getElementById( 'compra_documento_numero_01' ).value = '00' + document.getElementById( 'compra_documento_numero_01' ).value
}

function AcrecentaNumeroCompraFactura2() //
{
    if (document.getElementById( 'compra_documento_numero_02' ).value == ""){
    document.getElementById( 'compra_documento_numero_02' ).value = '00' + document.getElementById( 'compra_documento_numero_02' ).value
    }
    
}



function EntregaCompraCreditoDolar(e)      //
{
    document.getElementById( 'entrega_dolar' ).value = e
}

function CalculoCotasCompraCreditoDolar()  //
{
    if ( document.getElementById( 'entrega_dolar' ).value == 0 )
    {
        total_dolar = document.getElementById( 'compra_total_dolar' ).value
        parcela     = document.getElementById( 'parcela_dolar' ).value

        cota_01      = document.getElementById( 'compra_cota_dolar_01' ).value = ( total_dolar / parcela ).toFixed(2);
        cota_02      = document.getElementById( 'compra_cota_dolar_02' ).value = ( ( total_dolar - cota_01 ) / ( parcela - 1 ) ).toFixed(2);
        cota_03      = document.getElementById( 'compra_cota_dolar_03' ).value = ( ( total_dolar - cota_01 - cota_02 ) / ( parcela - 2 ) ).toFixed(2);
        cota_04      = document.getElementById( 'compra_cota_dolar_04' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 ) / ( parcela -3 ) ).toFixed(2);
        cota_05      = document.getElementById( 'compra_cota_dolar_05' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 ) / ( parcela - 4 ) ).toFixed(2);
        cota_06      = document.getElementById( 'compra_cota_dolar_06' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 - cota_05 ) / ( parcela -5 ) ).toFixed(2);
    }
    else
    {
        total_dolar = document.getElementById( 'compra_total_dolar' ).value
        parcela     = document.getElementById( 'parcela_dolar' ).value

        cota_01      = document.getElementById( 'compra_cota_dolar_01' ).value
        cota_02      = document.getElementById( 'compra_cota_dolar_02' ).value = ( ( total_dolar - cota_01 ) / ( parcela - 1 ) ).toFixed(2);
        cota_03      = document.getElementById( 'compra_cota_dolar_03' ).value = ( ( total_dolar - cota_01 - cota_02 ) / ( parcela - 2 ) ).toFixed(2);
        cota_04      = document.getElementById( 'compra_cota_dolar_04' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 ) / ( parcela -3 ) ).toFixed(2);
        cota_05      = document.getElementById( 'compra_cota_dolar_05' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 ) / ( parcela - 4 ) ).toFixed(2);
        cota_06      = document.getElementById( 'compra_cota_dolar_06' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 - cota_05 ) / ( parcela -5 ) ).toFixed(2);

    }
    if ( cota_01 == "NaN" || cota_01 == "-Infinity" || cota_01 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_01' ).value = 0
    }
    if ( cota_02 == "NaN" || cota_02 == "-Infinity" || cota_02 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_02' ).value = 0
    }
    if ( cota_03 == "NaN" || cota_03 == "-Infinity" || cota_03 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_03' ).value = 0
    }
    if ( cota_04 == "NaN" || cota_04 == "-Infinity" || cota_04 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_04' ).value = 0
    }
    if ( cota_05 == "NaN" || cota_05 == "-Infinity" || cota_05 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_05' ).value = 0
    }
    if ( cota_06 == "NaN" || cota_06 == "-Infinity" || cota_06 == "Infinity" )
    {
        document.getElementById( 'compra_cota_dolar_06' ).value = 0
    }

}

function EntregaCompraCreditoGuarani(e)    //
{
    document.getElementById( 'entrega_guarani' ).value = e
}

function CalculoCotasCompraCreditoGuarani()//
{
    if ( document.getElementById( 'entrega_guarani' ).value == 0 )
    {
        total_dolar = document.getElementById( 'compra_total_guarani' ).value
        parcela     = document.getElementById( 'parcela_guarani' ).value

        cota_01      = document.getElementById( 'compra_cota_guarani_01' ).value = ( total_dolar / parcela ).toFixed(0);
        cota_02      = document.getElementById( 'compra_cota_guarani_02' ).value = ( ( total_dolar - cota_01 ) / ( parcela - 1 ) ).toFixed(0);
        cota_03      = document.getElementById( 'compra_cota_guarani_03' ).value = ( ( total_dolar - cota_01 - cota_02 ) / ( parcela - 2 ) ).toFixed(0);
        cota_04      = document.getElementById( 'compra_cota_guarani_04' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 ) / ( parcela -3 ) ).toFixed(0);
        cota_05      = document.getElementById( 'compra_cota_guarani_05' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 ) / ( parcela - 4 ) ).toFixed(0);
        cota_06      = document.getElementById( 'compra_cota_guarani_06' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 - cota_05 ) / ( parcela -5 ) ).toFixed(0);
    }
    else
    {
        total_dolar = document.getElementById( 'compra_total_guarani' ).value
        parcela     = document.getElementById( 'parcela_guarani' ).value
        cota_01      = document.getElementById( 'compra_cota_guarani_01' ).value
        cota_02      = document.getElementById( 'compra_cota_guarani_02' ).value = ( ( total_dolar - cota_01 ) / ( parcela - 1 ) ).toFixed(0);
        cota_03      = document.getElementById( 'compra_cota_guarani_03' ).value = ( ( total_dolar - cota_01 - cota_02 ) / ( parcela - 2 ) ).toFixed(0);
        cota_04      = document.getElementById( 'compra_cota_guarani_04' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 ) / ( parcela -3 ) ).toFixed(0);
        cota_05      = document.getElementById( 'compra_cota_guarani_05' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 ) / ( parcela - 4 ) ).toFixed(0);
        cota_06      = document.getElementById( 'compra_cota_guarani_06' ).value = ( ( total_dolar - cota_01 - cota_02 - cota_03 - cota_04 - cota_05 ) / ( parcela -5 ) ).toFixed(0);

    }
    if ( cota_01 == "NaN" || cota_01 == "-Infinity" || cota_01 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_01' ).value = 0
    }
    if ( cota_02 == "NaN" || cota_02 == "-Infinity" || cota_02 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_02' ).value = 0
    }
    if ( cota_03 == "NaN" || cota_03 == "-Infinity" || cota_03 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_03' ).value = 0
    }
    if ( cota_04 == "NaN" || cota_04 == "-Infinity" || cota_04 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_04' ).value = 0
    }
    if ( cota_05 == "NaN" || cota_05 == "-Infinity" || cota_05 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_05' ).value = 0
    }
    if ( cota_06 == "NaN" || cota_06 == "-Infinity" || cota_06 == "Infinity" )
    {
        document.getElementById( 'compra_cota_guarani_06' ).value = 0
    }

}


function ExibeDivDadosContaEntregaDolar()   //
{

    if ( document.getElementById('entrega_dolar').value == '0' )
    {
        document.getElementById('TIPO_CONTADO').style.display    = "none";
    }
    else if ( document.getElementById('entrega_dolar').value == '1' )
    {
        document.getElementById('TIPO_CONTADO').style.display    = "inline";

    }

}

function ExibeDivDadosContaEntregaGuarani() //
{

    if ( document.getElementById('entrega_guarani').value == '0' )
    {
        document.getElementById('TIPO_CONTADO').style.display    = "none";
    }
    else if ( document.getElementById('entrega_guarani').value == '1' )
    {
        document.getElementById('TIPO_CONTADO').style.display    = "inline";

    }

}


function VendaPorcentagemGs()               //

{
    varmargem   = ( parseFloat( document.getElementById('compras_produto_porcentagem').value ) / 100 )  ;
    varcalc     = ( ( varmargem  *  parseFloat( document.getElementById('compras_produto_unitario_guarani').value ) )  + parseFloat( document.getElementById('compras_produto_unitario_guarani').value ) )
    document.getElementById('compras_produto_preco_venda_guarani').value   =  varcalc
}

function VendaPorcentagemInversa()          //
{
    varmargem   = ( ( ( parseFloat( document.getElementById('compras_produto_preco_venda_guarani').value - document.getElementById('compras_produto_unitario_guarani').value ) ) * 100 )  / document.getElementById('compras_produto_unitario_guarani').value ) ;
    document.getElementById('compras_produto_porcentagem').value   = varmargem.toFixed(6);

}


function DataNota()                //
{
    document.getElementById("key").value = document.getElementById("nota_credito_data_3i").value+'/'+ document.getElementById("nota_credito_data_2i").value+'/'+document.getElementById("nota_credito_data_1i").value;

}

function CampoNota()               //
{
    document.getElementById("nota_credito_cotacao").focus();
}

function Tipo(d)                 //

{
    document.getElementById('tipo').value = d
}

//COTACAO INGRESSO
function IngressoFocoData()        //
{
    document.getElementById("ingresso_data_3i").focus();
}

function IngressoDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("ingresso_data_3i").value+'/'+ document.getElementById("ingresso_data_2i").value+'/'+document.getElementById("ingresso_data_1i").value;
}

function IngressoGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('ingresso_valor_guarani').value ) / parseFloat( document.getElementById('ingresso_cotacao').value ) )  ;
    document.getElementById('ingresso_valor_dolar').value = varcotacao.toFixed(2);
}

function IngressoDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('ingresso_valor_dolar').value ) * parseFloat( document.getElementById('ingresso_cotacao').value ) )  ;
    document.getElementById('ingresso_valor_guarani').value = varcotacao.toFixed(0);
}

//DIARIO
function DiarioFocoData()        //
{
    document.getElementById("diario_data_3i").focus();
}

function DiarioDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("diario_data_3i").value+'/'+ document.getElementById("diario_data_2i").value+'/'+document.getElementById("diario_data_1i").value;
}

function DiarioGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('diario_debe_valor_guarani').value ) / parseFloat( document.getElementById('diario_debe_cotacao').value ) )  ;
    document.getElementById('diario_debe_valor_dolar').value = varcotacao.toFixed(2);
}

function DiarioDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('diario_debe_valor_dolar').value ) * parseFloat( document.getElementById('diario_debe_cotacao').value ) )  ;
    document.getElementById('diario_debe_valor_guarani').value = varcotacao.toFixed(0);
}


function DiarioHaberGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('diario_haber_valor_guarani').value ) / parseFloat( document.getElementById('diario_haber_cotacao').value ) )  ;
    document.getElementById('diario_haber_valor_dolar').value = varcotacao.toFixed(2);
}

function DiarioHaberDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('diario_haber_valor_dolar').value ) * parseFloat( document.getElementById('diario_haber_cotacao').value ) )  ;
    document.getElementById('diario_haber_valor_guarani').value = varcotacao.toFixed(0);
}





function DiarioSeguirComprovante(id) //
{
        if ( document.getElementById('debe').value != document.getElementById('haber').value  )
        {
            alert ('Verifique los totales totales');
            return false;
        }
        else
        {
            location.href="/diarios/comprovante_diario/"+ id ;
        }
}

function DiarioDebeCampoKey()    //
{
document.getElementById('key').value = document.getElementById('diario_debe_rubro_id').value
}


function DiarioHaberCampoKey()    //
{
document.getElementById('key').value = document.getElementById('diario_haber_rubro_id').value
}


//COTACAO TRANSFERENCIA
function TransferenciaFocoData()        //
{
    document.getElementById("transferencia_conta_data_3i").focus();
}

function TransferenciaDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("transferencia_conta_data_3i").value+'/'+ document.getElementById("transferencia_conta_data_2i").value+'/'+document.getElementById("transferencia_conta_data_1i").value;
}

function TransferenciaGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('transferencia_conta_valor_guarani').value ) / parseFloat( document.getElementById('transferencia_conta_cotacao').value ) )  ;
    document.getElementById('transferencia_conta_valor_dolar').value = varcotacao.toFixed(2);
}

function TransferenciaDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('transferencia_conta_valor_dolar').value ) * parseFloat( document.getElementById('transferencia_conta_cotacao').value ) )  ;
    document.getElementById('transferencia_conta_valor_guarani').value = varcotacao.toFixed(0);
}

//SOBRANTES FALTANTES
function SobranteFaltanteFocoData()        //
{
    document.getElementById("sobrantes_faltante_data_3i").focus();
}

function SobranteFaltanteDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("sobrantes_faltante_data_3i").value+'/'+ document.getElementById("sobrantes_faltante_data_2i").value+'/'+document.getElementById("sobrantes_faltante_data_1i").value;
}

function SobranteFaltanteGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('sobrantes_faltante_unitario_guarani').value ) / parseFloat( document.getElementById('sobrantes_faltante_cotacao').value ) )  ;
    document.getElementById('sobrantes_faltante_unitario_dolar').value = varcotacao.toFixed(2);
}

function SobranteFaltanteDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('sobrantes_faltante_unitario_dolar').value ) * parseFloat( document.getElementById('sobrantes_faltante_cotacao').value ) )  ;
    document.getElementById('sobrantes_faltante_unitario_guarani').value = varcotacao.toFixed(0);
}

function SobranteFaltanteQuantidadeUnitarioGs()    //
{
    varcotacao = ( parseFloat( document.getElementById('sobrantes_faltante_quantidade').value ) * parseFloat( document.getElementById('sobrantes_faltante_unitario_dolar').value ) )  ;
    document.getElementById('sobrantes_faltante_total_dolar').value = varcotacao.toFixed(2);
}


function SobranteFaltanteQuantidadeUnitarioUs()    //
{
    varcotacao = ( parseFloat( document.getElementById('sobrantes_faltante_quantidade').value ) * parseFloat( document.getElementById('sobrantes_faltante_unitario_guarani').value ) )  ;
    document.getElementById('sobrantes_faltante_total_guarani').value = varcotacao.toFixed(2);
}

function ProventosCampoDescripcion()       //
{
    document.getElementById("provento_descripcion").focus();
}


//DIARIO
function SueldoDetalheFocoData()        //
{
    document.getElementById("sueldos_detalhe_data_3i").focus();
}

function SueldoDetalheCotacao()     //
{
    document.getElementById("key").value = document.getElementById("sueldos_detalhe_data_3i").value+'/'+ document.getElementById("sueldos_detalhe_data_2i").value+'/'+document.getElementById("sueldos_detalhe_data_1i").value;
}

function SueldoDetalheGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('sueldos_detalhe_valor_guarani').value ) / parseFloat( document.getElementById('sueldos_detalhe_cotacao').value ) )  ;
    document.getElementById('sueldos_detalhe_valor_dolar').value = varcotacao.toFixed(2);
}

function SueldoDetalheDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('sueldos_detalhe_valor_dolar').value ) * parseFloat( document.getElementById('sueldos_detalhe_cotacao').value ) )  ;
    document.getElementById('sueldos_detalhe_valor_guarani').value = varcotacao.toFixed(0);
}

function DiasTrabalhados()    //
{
    var valor = ( parseFloat( document.getElementById('salario').value ) / 30 )  ;
    var total = (valor *  document.getElementById('sueldos_detalhe_dias_tr').value)

    document.getElementById('sueldos_detalhe_valor_guarani').value = total.toFixed(0);
    document.getElementById('sueldos_detalhe_valor_dolar').value = (total / document.getElementById('sueldos_detalhe_cotacao').value).toFixed(2);
}

function PersonaExibeDiv(id) {
	if(document.getElementById(id).style.display=="none") {
		document.getElementById(id).style.display = "inline";
	}
	else {
		document.getElementById(id).style.display = "none";
	}
}

function GastoCotacao()          //
{
    document.getElementById("key").value = document.getElementById("compra_data_3i").value+'/'+ document.getElementById("compra_data_2i").value+'/'+document.getElementById("compra_data_1i").value;
}

function CobroDifeirdoData()     //
{
    document.getElementById("cobro_diferido_3i").value = document.getElementById("data").value
    document.getElementById("cobro_diferido_2i").value = document.getElementById("mes").value
    document.getElementById("cobro_diferido_1i").value = document.getElementById("ano").value
}

function VendaFinancasDifeirdoData()     //
{
    document.getElementById("vendas_financa_diferido_3i").value = document.getElementById("data").value
    document.getElementById("vendas_financa_diferido_2i").value = document.getElementById("mes").value
    document.getElementById("vendas_financa_diferido_1i").value = document.getElementById("ano").value
}


function VendaFinancasAlertCreditoCosumidorFinal()     //
{
       credito = document.getElementById("vendas_financa_tipo").value
       persona = document.getElementById("codigo").value
    if( credito == 1 && persona == 11  )
    {
        alert('No es Permitido Venta a CREDITO para este cliente!')
        document.getElementById("codigo").value = ''
    }
}

function VendaFinancasAlertContadoValor()     //
{
       credito = document.getElementById("vendas_financa_tipo").value
       total   = document.getElementById("vendas_financa_valor_guarani_contado").value
    if( credito == 0 &&  (total <= 0 || total == 'NaN' )   )
    {
        alert('Por Favor, lo Valor tiene que ser Maior que 0 ou No es ao Contado !')
    }
}


function CalculoDeIps()    //
{
    varips = ( parseFloat( document.getElementById('persona_salario_minimo').value ) * 0.09)
    document.getElementById('persona_ips').value = varips.toFixed(0);
}

function SueldoSetaValor()    //
{
    document.getElementById('compra_rubro_id').value = "99";
}


function VendaSetaVendedor()    //
{
    document.getElementById('venda_vendedor_id').value = document.getElementById('vendedor').value;
    document.getElementById('venda_conta_nome').value  = document.getElementById('conta').value;
    document.getElementById('venda_turno_nome').value  = document.getElementById('turno').value;
}


function ProdutoDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("produto_data_3i").value+'/'+ document.getElementById("produto_data_2i").value+'/'+document.getElementById("produto_data_1i").value;
}



function MayorBuscaCodContabilInicio(){
 document.getElementById('codigo_inicio').value = document.getElementById('busca_descricao_inicio').value
}


function MayorBuscaCodContabilFinal(){
 document.getElementById('codigo_final').value = document.getElementById('busca_descricao_final').value
}



function VendaE03()     //
{
    document.getElementById("venda_data_3i").value = document.getElementById("data").value
    document.getElementById("venda_data_2i").value = document.getElementById("mes").value
    document.getElementById("venda_data_1i").value = document.getElementById("ano").value
}


function ContaBuscaCodContabil()     //
{
    document.getElementById("conta_cod_contabil").value = document.getElementById("conta_rubro_nome").value
}



//EXIBE DIV COMPRA DOCUMENTO-------------------------------------------------------

function DocTipoCompra  (d)      //

{
    document.getElementById('tipomoeda').value = d
}

function ExibeDivCompra()   //
{

    if ( document.getElementById('tipomoeda').value == '0' )
    {
        document.getElementById('DOLAR').style.display = "inline";
        document.getElementById('GUARANI').style.display = "none";
        document.getElementById("compras_documento_exentas_dolar").focus();
    }

    if ( document.getElementById('tipomoeda').value == '1' )
    {
        document.getElementById('GUARANI').style.display = "inline";
        document.getElementById('DOLAR').style.display = "none";
        document.getElementById("compras_documento_exentas_guarani").focus();
    }

}
//EXIBE DIV COMPRA DOCUMENTO-------------------------------------------------------

//ANDELANTO PROVEEDOR-------------------------------------------------------

function AdelantoProveedorDataCotacao()     //
{
    document.getElementById("key").value = document.getElementById("adelantos_proveedor_data_3i").value+'/'+ document.getElementById("adelantos_proveedor_data_2i").value+'/'+document.getElementById("adelantos_proveedor_data_1i").value;
    document.getElementById("adelantos_proveedor_diferido_3i").value = document.getElementById("adelantos_proveedor_data_3i").value
    document.getElementById("adelantos_proveedor_diferido_2i").value = document.getElementById("adelantos_proveedor_data_2i").value
    document.getElementById("adelantos_proveedor_diferido_1i").value = document.getElementById("adelantos_proveedor_data_1i").value
}

function AdelantoProveedorGuaraniDolar()    //
{
    varcotacao = ( parseFloat( document.getElementById('adelantos_proveedor_valor_guarani').value ) / parseFloat( document.getElementById('adelantos_proveedor_cotacao').value ) )  ;
    document.getElementById('adelantos_proveedor_valor_dolar').value = varcotacao.toFixed(2);
}

function AdelantoProveedorDolarGuarani()    //
{
    varcotacao = ( parseFloat( document.getElementById('adelantos_proveedor_valor_dolar').value ) * parseFloat( document.getElementById('adelantos_proveedor_cotacao').value ) )  ;
    document.getElementById('adelantos_proveedor_valor_guarani').value = varcotacao.toFixed(0);
}


function StockCotacao()               //
{
    document.getElementById("key").value = document.getElementById("stock_data_3i").value+'/'+ document.getElementById("stock_data_2i").value+'/'+document.getElementById("stock_data_1i").value;
}

function StockCotacaoFoco()           //
{
        document.getElementById("stock_cotacao").focus();
}

function StockGuaraniDolar()          //
{
    varcotacao = ( parseFloat( document.getElementById('stock_unitario_guarani').value ) / parseFloat( document.getElementById('stock_cotacao').value ) )  ;
    document.getElementById('stock_unitario_dolar').value = varcotacao.toFixed(2);
}

function StockDolarGuarani()          //
{
    varcotacao = ( parseFloat( document.getElementById('stock_unitario_dolar').value ) * parseFloat( document.getElementById('stock_cotacao').value ) )  ;
    document.getElementById('stock_unitario_guarani').value = varcotacao.toFixed(0);
}

function StockIvaDolar()              //
{
    vardolartotal = ( parseFloat( document.getElementById('stock_unitario_dolar').value ) *  parseFloat( document.getElementById('stock_entrada').value ));
    taxa = ( ( parseFloat( document.getElementById('stock_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( vardolartotal / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('stock_taxa').value ) ) / 100 );
    document.getElementById('stock_iva_dolar').value = vartotal.toFixed(6);
}

function StockIvaGs()                 //
{
    vardolartotal = ( parseFloat( document.getElementById('stock_unitario_guarani').value ) *  parseFloat( document.getElementById('stock_entrada').value ));
    taxa = ( ( parseFloat( document.getElementById('stock_taxa').value ) / 100 ) + 1.00 );
    vartotal = ( vardolartotal / taxa );
    vartotal = ( ( vartotal * parseFloat( document.getElementById('stock_taxa').value ) ) / 100 );
    document.getElementById('stock_iva_guarani').value = vartotal.toFixed(6);
}
