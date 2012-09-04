
// DATA DE HOJE IMPUT----------------------------------------------------------------
var montharray=new Array("01","02","03","04","05","06","07","08","09","10","11","12");


var mydate=new Date();
var year=mydate.getYear();
if (year < 1900);
year+=1900;
var day=mydate.getDay();
var month=mydate.getMonth();
var daym=mydate.getDate();

//change font size here
var cdate=""+daym+"/"+montharray[month]+"/"+year+""


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
function f(o){
    o.value=o.value.toUpperCase().replace(/([^0-9A-Z.,&-/])/g," ");
}

function MascaraMoeda(f)                 //
{
    v = f.value;
    v=v.replace(/\D/g,"")  //permite digitar apenas números
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")        //coloca virgula antes dos últimos 2 digitos
    f.value = v;

}

function CampoBusca()                   //
{
    document.getElementById("busca").focus();
}

//FIM DATA DE HOJE IMPUT----------------------------------------------------------------

function ExtractoFinanzaChofer()
{
    window.open('/chofers/extracto_chofer' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function ExtractoFinanzaRemitente()
{
    window.open('/remitentes/extracto_remitente' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function ExtractoFinanzaProprietario()
{
    window.open('/proprietarios/extracto_proprietario' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function ExtractoFinanzaEmpleado()
{
    window.open('/empleados/extracto_empleado' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function ExtractoFinanzaProveedo()
{
    window.open('/proveedores/extracto_proveedor' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}




function abrir_AdelantoPro(value)
{
    window.open('/adelantofleteps/edit/'+value , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function abrir_SuministroPro(value)
{
    window.open('/ordemsuministropros/edit/'+value , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//DETALHE EXTRACTO PROPRIETARIO-------------------------------------------------------

function abrir_AdelantoFinalizadoEXtracto(value)
{
    window.open('/adelantofleteps/' + value + '/edit' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}



function abrir_SuminitroFinalizadoEXtracto(value)
{
    window.open('/ordemsuministropros/' + value + '/edit' , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function abrir_DetalheExtractoProprietario(value)
{
    window.open('/proprietarios/saldo_detalhado/14?recepticket_id=' + value , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//FIM DETALHE EXTRACTO PROPRIETARIO-------------------------------------------------------
function abrir_FinanzaPro(value)
{
    window.open('/finanzas/edit/'+value , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function abrir_FinanzaProveedorPago(value)
{
    window.open('/finanzas/proveedor_pagos/'+value , 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function fechaPopupAutorizacao()
{
    self.close();
}

function DataRelatorioCajaInicio()
{
    document.getElementById('inicio').value = cdate;

}

function DataRelatorioCajaFinal()
{
    document.getElementById('final').value = cdate;

}



// POPUP-------------------------------------------------------------------------

//REMITENTE PRESUPUESTO-------
//---------------------------


//REMITENTE PRESUPUESTO-------
//---------------------------



//PEDIDO TRASLADO-------
function abrir_presupuesto()
{
 
    window.open('/presupuestos/presupuesto_pedido_busca', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}
//---------------------------


//PEDIDO TRASLADO-------
function abrir_remitente()
{
 
    window.open('/remitentes/remitente_pedido_busca', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}
//---------------------------


//PEDIDO TRASLADO-------
function abrir_pedido()
{
 
    window.open('/pedidotralados/search', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//ORDEM CARGA----------
function abrir_ordem()
{

    var chapa = document.getElementById("recepticket_chapa") .value;

    window.open('/ordemcargas/recepcion_ordem_busca?chapa=' + chapa, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//SUMINISTRO CHOFER-------------ORDEM CARGA
function abrir_suministrochofer()
{

    var chapa = document.getElementById("ordemsuministroc_chapa") .value;

    window.open('/ordemcargas/suministrochofer_ordem_busca?chapa=' + chapa, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//ADELANTO FLETE------------ORDEM CARGA
function abrir_adelantochofer()
{

    var chapa = document.getElementById("adelantofletec_chapa") .value;

    window.open('/ordemcargas/adelantochofer_ordem_busca?chapa=' + chapa, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function ExtractoChecagemChofer(id)
{

    window.open('/chofers/en_curso_detalhe_extracto/' + id, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function ExtractoChofer(id)
{

    location.href= '/chofers/en_curso_detalhe_extracto/' + id;
}


function ExtractoChoferShow(id)
{


    window.open('/proprietarios/' + id, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function PopUpSuministro(id)
{


    window.open('/ordemsuministrocs/'+ id +'/edit', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function PopUpAdelanto(id)
{


    window.open('/adelantofletecs/'+ id +'/edit', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


function PopUpTickets(id)
{


    window.open('/receptickets/'+ id +'/edit', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

//---------------------------------------------------------


//POPUP TRACTOR CARRETA RODADOS---------------------------------------------------------
function AbrirTractor()                   //
{
    window.open('/tractors/rodados_tractor', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function AbrirCarreta()                   //
{
    window.open('/carretas/rodados_carreta', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function AbrirEmpleadoChofer()            //
{
    window.open('/empleados/busca_empleado_chofer', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}

function CalculoCapacidadeFrotaInterna()  //
{
    tara =   parseInt( document.getElementById('rodado_tractor_tara').value) + parseInt(document.getElementById('rodado_carreta_tara').value );
    peso =   parseInt( document.getElementById('rodado_peso_bruto').value) - tara
    
    document.getElementById('rodado_capacidade').value = peso.toFixed(0);
}

//---------------------------------------------------------



// CALCULO ORDEM CARGA FLETE * CAPACIDAD

function CalcularFleteCapacidad()
{
    var1 =   parseFloat( document.getElementById('ordemcarga_fletechof').value) * parseFloat(document.getElementById('ordemcarga_capacidad').value );
    document.getElementById('ordemcarga_valor_flete_estimado').value = var1.toFixed(0);

}
//---------------------------------------------------------

// CALCULO ORDEM CARGA

function CalcularFleteDisponible()
{
    var1 =   parseFloat( document.getElementById('ordemcarga_valor_flete_estimado').value ) * 0.7;
    document.getElementById('ordemcarga_autorizado').value = var1.toFixed(0);

}

//---------------------------------------------------------

// CALCULO RECEPCION TICKET--------------------------------
function CalcularRecepcionTicket()
{
    varDifNeto    = ( parseFloat( document.getElementById('recepticket_kgorigem').value ) - parseFloat( document.getElementById('recepticket_kgdestino').value ) );
    document.getElementById('recepticket_kgdif').value = varDifNeto;
}
//---------------------------------------------------------

// CALCULO RECEPCION TICKET 2-------------------------------
function CalcularRecepcionTicket2()
{
    varPermitido = ( parseFloat( document.getElementById('recepticket_kgdestino').value ) * parseFloat( document.getElementById('recepticket_tolerancia').value ) / 100 );
    document.getElementById('recepticket_kgpermitido').value = varPermitido.toFixed(0);
}


// CALCULO RECEPCION TICKET 3-------------------------------
function CalcularRecepcionTicket3()
{
       if ( parseFloat( document.getElementById('recepticket_kgdif').value ) > parseFloat( document.getElementById('recepticket_kgpermitido').value ) )
          {
           varDifLiquido = ( parseFloat( document.getElementById('recepticket_kgdif').value ) - parseFloat( document.getElementById('recepticket_kgpermitido').value ) );
           document.getElementById('recepticket_kgexetente').value = varDifLiquido.toFixed(0);          
          
          }
       else   
          {
           document.getElementById('recepticket_kgexetente').value = 0;
           document.getElementById('recepticket_descuento').value = 0;        
          }
}

// CALCULO RECEPCION TICKET 4-------------------------------
function CalcularRecepcionTicket4()
{
    if ( parseFloat( document.getElementById('recepticket_kgdif').value ) > parseFloat( document.getElementById('recepticket_kgpermitido').value ) )
    {

    varDesconto = ( parseFloat( document.getElementById('recepticket_kgexetente').value ) * 2200 ) - parseFloat( document.getElementById('recepticket_seguro').value ) ;
    document.getElementById('recepticket_descuento').value = varDesconto.toFixed(0);
    }
    else
    {
        document.getElementById('recepticket_descuento').value = 0;        
    }
    
}

// CALCULO RECEPCION TICKET 5-------------------------------
function CalcularRecepcionTicket5()
{
    varFinal = ( parseFloat( document.getElementById('recepticket_kgdestino').value ) * parseFloat( document.getElementById('recepticket_fletechof').value ) ) - parseFloat( document.getElementById('recepticket_descuento').value ) ;
    document.getElementById('recepticket_flete_final_chofer').value = varFinal.toFixed(0);
}

function CalcularRecepcionTicket6()
{
    varFinal = ( parseFloat( document.getElementById('recepticket_kgdestino').value ) * parseFloat( document.getElementById('recepticket_fleterem').value ) ) + parseFloat( document.getElementById('recepticket_descuento').value ) ;
    document.getElementById('recepticket_flete_final_remitente').value = varFinal.toFixed(0);
}

function CalcularRecepcionTicket7()
{
    varFinal = ( parseFloat( document.getElementById('recepticket_flete_final_chofer').value ) * parseFloat( document.getElementById('recepticket_comision_empleado').value )/ 100 ) ;
    varcomision = varFinal + parseFloat( document.getElementById('recepticket_gastos_translado').value )
    document.getElementById('recepticket_comision_pagar_empleado').value = varcomision.toFixed(0);
}


// CALCULO RECEPCION TICKET 6--------------------------------


// MASCARA MOEDA TONELADA
function mascara(o,f)
{
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}


function execmascara()
{
    v_obj.value=v_fun(v_obj.value)
}

function moeda(v){
               
    v=v.replace(/\D/g,"")
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v=v.replace(/(\d{1})(\d{1,2})$/,"$1,$2")        //coloca virgula antes dos últimos 2 digitos
    v.value = v;
}




function tonelada1(z)
{
    v = z.value;
    v=v.replace(/(\,\d{1,2})/,"")
    v=v.replace(/\D/g,"")
    v=v.replace(/(\d)(\d{2})$/,"$1,$2") // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d)(\d{3}\.)/,"$1,$2") // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    z.value = v;
}

function tonelada2(z)
{
    v = z.value;
    v=v.replace(/(\,\d{1,2})/,"")
    v=v.replace(/\D/g,"")
    v=v.replace(/(\d)(\d{3})$/,"$1.$2") // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d)(\d{3}\.)/,"$1.$2") // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    z.value = v;
}

function moedaordem(z){  
    v = z.value;
    v=v.replace(/\D/g,"")
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v+="000" // Acrescenta ,00 ao final dos inteiros
    z.value = v;
}

function moedaordem1(z){
    v = z.value;
    v=v.replace(/\D/g,"")
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v+="000" // Acrescenta ,00 ao final dos inteiros
    z.value = v;
}


function moedarecep(z){
    v = z.value;
    v=v.replace(/\D/g,"")
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v+="000" // Acrescenta ,00 ao final dos inteiros
    z.value = v;
}


function moedarecep2(z){
    v = z.value;
    v=v.replace(/\D/g,"")
    v=v.replace(/[0-9]{12}/,"inválido")   //limita pra máximo 999.999.999,99
    v=v.replace(/(\d{1})(\d{8})$/,"$1.$2")  //coloca ponto antes dos últimos 8 digitos
    v=v.replace(/(\d{1})(\d{5})$/,"$1.$2")  //coloca ponto antes dos últimos 5 digitos
    v+="000" // Acrescenta ,00 ao final dos inteiros
    z.value = v;
}


function moeda2()
{
    var fletef       = document.getElementById( "recepticket_flete_final_chofer" );
    fletef      = moedarecep( fletef );
     

     
}
function moeda3()
{
    var precio_produto       = document.getElementById( "recepticket_flete_final_remitente" );
    precio_produto      = moedarecep2( precio_produto );
     
}

function moeda4()
{
    var precio_produto       = document.getElementById( "ordemcarga_valor_flete_estimado" );
    precio_produto      = moedaordem( precio_produto );
     
}


function moeda5()
{
    var precio_produto       = document.getElementById( "ordemcarga_autorizado" );
    precio_produto      = moedaordem1( precio_produto );

}

function moeda6()
{
    var precio_produto       = document.getElementById( "recepticket_comision_pagar_empleado" );
    precio_produto      = moedarecep2( precio_produto );

}

function tonelada(v)
{
    v=v.replace(/(\,\d{1,2})/,"");
    v=v.replace(/\D/g,"");
    v=v.replace(/(\d{3})(\d{3})$/,"$1.$2"); // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d{3})(\d{3}\.)/,"$1.$2"); // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    v=v.replace(/(\d{.})$/,"000.000"); // Coloca “,00″ no final

    return v;
}

function tonelada1(v)
{
    v=v.replace(/(\,\d{1,2})/,"");
    v=v.replace(/\D/g,"");
    v=v.replace(/(\d)(\d{3})$/,"$1.$2"); // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d)(\d{3}\.)/,"$1.$2"); // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    v=v.replace(/(\d{.})$/,"000.000"); // Coloca “,00″ no final

    return v;
}


function porcentagem(v)
{
    v=v.replace(/(\,\d{1,2})/,"");
    v=v.replace(/\D/g,"");
    v=v.replace(/(\d)(\d{2})$/,"$1.$2"); // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d)(\d{2}\.)/,"$1.$2"); // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    v=v.replace(/(\d{.})$/,"0.00"); // Coloca “,00″ no final
    return v;
}


function cedula(v)
{
    v=v.replace(/(\,\d{1,2})/,"");
    v=v.replace(/\D/g,"");
    v=v.replace(/(\d)(\d{3})$/,"$1.$2"); // Coloca um ponto entre o último e o penultimo bloco de 3 digitos
    v=v.replace(/(\d)(\d{3}\.)/,"$1.$2"); // Após último bloco de 3 digitos substitui “????.” por “?.???.”

    v=v.replace(/(\d{.})$/,"0.00"); // Coloca “,00″ no final
    return v;
}



function data(v){
    v=v.replace(/\D/g,"")
    v=v.replace(/(\d{2})(\d)/,"$1/$2")
    v=v.replace(/(\d{2})(\d)/,"$1/$2")
    return v

}

//-----------------------------------------------------

//PULAR IMPUT------------------------------------------
function proximoCampo(atual,proximo){
    if(atual.value.length >= atual.maxLength){
        document.getElementById(proximo).focus();
    }
}
//FIM PULAR IMPUT
function Campo()
{
    document.getElementById("login_usuario_senha").focus();
}

function CampoPedido()
{
    document.getElementById("pedidotralado_cantidad").focus();
}


function CampoExtracto()
{
    document.getElementById("busca").focus();
}


function CampoKey()
{
    document.getElementById("key").focus();
}


function CampoChapaAntecipo()
{
    document.getElementById("adelantofletec_rodado_chapa_").focus();
}

function CampoChapaSuministro()
{
    document.getElementById("ordemsuministroc_rodado_chapa_").focus();
}


//VALIDACAO SIMPLES RADIO BUTTON TIPO NACIONAL----------------

function validar()
{
    if (TIPO  == "internacional")
    {
        alert("Por favor preencha um dos campos inportacion/exportacion");
    }
}


//COMBO BOX PEDIDOTRALADO   REMITENTE----------------------------------
function atualizadadosremitente() 
{
    document.getElementById('key').value = document.getElementById('dadosremitente').value;
}
//--------------------------------------------------------

//COMBO BOX PRESUPUESTO   REMITENTE-----------------------------------

function atualizadadosremitentepresupuesto() 
{
    document.getElementById('key').value = document.getElementById('dadosremitente').value;
}
//-------------------------------------------------------

//COMBO BOX ORDEMCARGA   PRODUTO-----------------------------------
function buscaprodutoordem() 
{
    document.getElementById('prod').value = document.getElementById('dadosproducto').value;
}

//COMBO BOX ORDEMCARGA   PRODUTO-----------------------------------
function buscaprodutosuministro() 
{
    document.getElementById('prod').value = document.getElementById('dadosproducto').value;
}

//COMBO BOX ORDEMCARGA   PRODUTO-----------------------------------
function buscaprodutosuministroremi() 
{
    document.getElementById('prod').value = document.getElementById('dadosproducto').value;
}

//COMBO BOX FINANZAS   PROVEEDOR-----------------------------------
function ProveedorBox()
{
    document.getElementById('proveedor').value = document.getElementById('finanza_proveedore_id').value;
}

//COMBO BOX FINANZAS   REMITENTE-----------------------------------
function RemitenteBox()
{
    document.getElementById('remitente').value = document.getElementById('finanza_remitente_id').value;
}

//COMBO BOX FINANZAS   PROPRIETARIO-----------------------------------
function ProprietarioBox()
{
    document.getElementById('proprietario').value = document.getElementById('finanza_proprietario_id').value;
}


//COMBO BOX FINANZAS   CHOFER-----------------------------------
function ChoferBox()
{
    document.getElementById('chofer').value = document.getElementById('finanza_chofer_id').value;
}

function EmpleadoBox()
{
    document.getElementById('empleado').value = document.getElementById('finanza_empleado_id').value;
}

function ContabilidadBox()
{
    document.getElementById('contabilidad').value = document.getElementById('finanza_contabilidad_id').value;
}

// CALCULO SUMINISTRO ORDEM--------------------------------
function SuministroOrdem()
{
    
    varDifNeto    = ( parseFloat( document.getElementById('ordemcarga_precio').value ) * parseFloat( document.getElementById('ordemcarga_cantidad_suministro').value ) );
    document.getElementById('ordemcarga_importe_suministro').value = varDifNeto.toFixed(0);
}
//---------------------------------------------------------

// CALCULO SUMINISTRO CHOFER--------------------------------
function Suministro()
{
    varDifNeto    = ( parseFloat( document.getElementById('ordemsuministroc_precio').value ) * parseFloat( document.getElementById('ordemsuministroc_cantidad_suministro').value ) );
    document.getElementById('ordemsuministroc_importe_suministro').value = varDifNeto.toFixed(0);
}
//---------------------------------------------------------

// CALCULO SUMINISTRO PROPRIETARIO--------------------------------
function Suministroremi()
{
    varDifNeto    = ( parseFloat( document.getElementById('ordemsuministropro_precio').value ) * parseFloat( document.getElementById('ordemsuministropro_cantidad_suministro').value ) );
    document.getElementById('ordemsuministropro_importe_suministro').value = varDifNeto.toFixed(0);
}
//---------------------------------------------------------

function DiferencaPedido() {

    var remitente  = parseFloat(document.getElementById('pedidotralado_fleterem').value);
    var chofer     = parseFloat(document.getElementById('pedidotralado_fletechof').value);
    if (remitente < chofer)
    {
        alert('El valor Flete remitente no puede ser menor que el Flete Chofer');
 
    }
 
}
 
function DiferencaPresupuesto() {

    var remitente  = parseFloat(document.getElementById('presupuesto_fleterem').value);
    var chofer     = parseFloat(document.getElementById('presupuesto_fletechof').value);
    if (remitente < chofer)
    {
        alert('El valor Flete remitente no puede ser menor que el Flete Chofer');
 
    }
 
}

function SomaAdelantos()
{
    varDifNeto    = ( parseFloat( document.getElementById('ordemcarga_importe_suministro').value ) + parseFloat( document.getElementById('ordemcarga_importe_adelanto').value ) );
    document.getElementById('resultado_soma').value = varDifNeto;
}



function DiferencaAdelanto() {

    var autorizado = parseFloat(document.getElementById('ordemcarga_autorizado').value);
    var soma       = parseFloat(document.getElementById('resultado_soma').value);
    if (soma > autorizado)
    {
        alert('Lo Adelanto no puede ser major que lo Disponible!');

    }

}



function setaValor(valor){
    if (valor == "debito")
    {
        var debito = document.getElementById("finanza_valor") .value;
        document.getElementById("finanza_debito") .value  = debito;
        document.getElementById("finanza_credito") .value = "0.00";

    }

    if (valor == "credito")
    {
        var credito = document.getElementById("finanza_valor") .value;
        document.getElementById("finanza_credito") .value = credito;
        document.getElementById("finanza_debito" ) .value = "0.00";

    }

    else
    {
}
}


function Beneficiario()

{
    var nome = document.getElementById("finanza_chofer_nome").value;
    document.getElementById("finanza_beneficiario").value      = nome;
    document.getElementById("finanza_proprietario_nome").value = "";
    document.getElementById("finanza_proveedor_nome").value    = "";
    document.getElementById("finanza_remitente_nome").value    = "";
}
function Beneficiario2()
{
    var nome1 = document.getElementById("finanza_proprietario_nome").value
    document.getElementById("finanza_beneficiario").value   = nome1
    document.getElementById("finanza_chofer_nome").value    = "";
    document.getElementById("finanza_proveedor_nome").value = "";
    document.getElementById("finanza_remitente_nome").value = "";

}
function Beneficiario3()
{
    var nome2 = document.getElementById("finanza_remitente_nome").value
    document.getElementById("finanza_beneficiario").value      = nome2;
    document.getElementById("finanza_proprietario_nome").value = "";
    document.getElementById("finanza_chofer_nome").value       = "";
    document.getElementById("finanza_proveedor_nome").value    = "";

}
function Beneficiario4()
{
    var nome2 = document.getElementById("finanza_proveedor_nome").value
    document.getElementById("finanza_beneficiario").value      = nome2
    document.getElementById("finanza_proprietario_nome").value = "";
    document.getElementById("finanza_chofer_nome").value       = "";
    document.getElementById("finanza_remitente_nome").value    = "";

}

function Beneficiario5()
{
    var nome2 = document.getElementById("finanza_empleado_nome").value
    document.getElementById("finanza_beneficiario").value      = nome2
    document.getElementById("finanza_proprietario_nome").value = "";
    document.getElementById("finanza_chofer_nome").value       = "";
    document.getElementById("finanza_remitente_nome").value    = "";
    document.getElementById("finanza_proveedor_nome").value    = "";

}

function Beneficiario6()
{
    var nome2 = document.getElementById("finanza_contabilidad_nome").value
    document.getElementById("finanza_beneficiario").value      = nome2
    document.getElementById("finanza_empleado_nome").value      = "";
    document.getElementById("finanza_proprietario_nome").value = "";
    document.getElementById("finanza_chofer_nome").value       = "";
    document.getElementById("finanza_remitente_nome").value    = "";
    document.getElementById("finanza_proveedor_nome").value    = "";

}




function IdChofer(id)
{
    document.getElementById('id').value = id;

}

function FiltroRadio(filtro)
{
    if ( filtro == "true" )
    {        
        document.getElementById("busca_inicio") .value = "";
        document.getElementById("busca_final") .value  = "";
    }
    else
    {
        document.getElementById("busca_inicio") .value = cdate;
        document.getElementById("busca_final") .value  = cdate;
    }

}

function BlockOrdenRecep()
{
    if ( document.getElementById("cont_chofer") .value == 0 )
    {
        alert('Este Chofer No tiene Nen una Orden')
        back('/receptickets');

    }

}

function BlockOrdenAdelanto()
{
    if ( document.getElementById("cont_chofer") .value == 0 )
    {
        alert('Este Chofer No tiene Nen una Orden')
        back('/adelantofletecs');

    }

}

function AdelantoImporteDisponivel()
{    
    autorizado =  parseFloat( document.getElementById("adelantofletec_autorizado").value ) - parseFloat( document.getElementById("importado").value )
    disponivel =  document.getElementById("disponivel").value  = autorizado
    

}

function BlockOrdenAdelantoImporte()
{
    importado  =  parseFloat( document.getElementById("importado").value )
    autorizado =  parseFloat( document.getElementById("adelantofletec_autorizado").value )
    valor      =  parseFloat( document.getElementById("adelantofletec_importe_adelanto").value )
    if (  importado > autorizado   )
    {
        alert('Este Chofer Ja chegou em su maximo de adelanto consulte a su superiores')
        back('/adelantofletecs');

    }

    if (  importado + valor  > autorizado   )
    {
        alert('Este Chofer Ja chegou em su maximo mire lo importe')
        document.getElementById("adelantofletec_importe_adelanto").focus();
    }

}

function BlockOrdenSuministro()
{
    if ( document.getElementById("cont_chofer") .value == 0 )
    {
        alert('Este Chofer No tiene Nen una Orden')
        back('/ordemsuministrocs');

    }

}

function KilometragemCalc()
{
    varDifkm    = ( parseFloat( document.getElementById('recepticket_kilometragem_final').value ) - parseFloat( document.getElementById('recepticket_kilometragem_inicio').value ) );
    document.getElementById('recepticket_kilometragem_diferenca').value = varDifkm;

}

function SuministroImporteDisponivel()
{
    autorizado =  parseFloat( document.getElementById("ordemsuministroc_autorizado").value ) - parseFloat( document.getElementById("importado").value )
    disponivel =  document.getElementById("disponivel").value  = autorizado


}

function BlockOrdenSuministroImporte()
{
    importado  =  parseFloat( document.getElementById("importado").value )
    autorizado =  parseFloat( document.getElementById("ordemsuministroc_autorizado").value )
    valor      =  parseFloat( document.getElementById("ordemsuministroc_importe_suministro").value )
    if (  importado > autorizado   )
    {
        alert('Este Chofer Ja chegou em su maximo de adelanto consulte a su superiores')
        back('/adelantofletecs');

    }

    if (  importado + valor  > autorizado   )
    {
        alert('Este Chofer Ja chegou em su maximo mire lo importe')
        document.getElementById("adelantofletec_importe_adelanto").focus();
    }

}

function PopUpConprovanteRecepcion()
{


    window.open('/chofers/en_curso_detalhe_extracto/<%= @recepticket.id %>.pdf', 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=10, WIDTH=1000, HEIGHT=400');
}


//ABRE  E FECHA DIV-------------------------------------------------------------
function toggleDiv(documento)     //
{
    if(document.getElementById(documento).style.display == 'none'){
        document.getElementById(documento).style.display = 'block';
    }else{
        document.getElementById(documento).style.display = 'none';
    }
}

function toggleDiv(aciete)        //
{
    if(document.getElementById(aciete).style.display == 'none'){
        document.getElementById(aciete).style.display = 'block';
    }else{
        document.getElementById(aciete).style.display = 'none';
    }
}

function toggleDiv(cubierta)      //
{
    if(document.getElementById(cubierta).style.display == 'none'){
        document.getElementById(cubierta).style.display = 'block';
    }else{
        document.getElementById(cubierta).style.display = 'none';
    }
}

function toggleDiv(acessorio)     //
{
    if(document.getElementById(acessorio).style.display == 'none'){
        document.getElementById(acessorio).style.display = 'block';
    }else{
        document.getElementById(acessorio).style.display = 'none';
    }
}

//ABRE  E FECHA DIV CARRETE-------------------------------------------------------------

function toggleDiv(documento_carrete)     //
{
    if(document.getElementById(documento_carrete).style.display == 'none'){
        document.getElementById(documento_carrete).style.display = 'block';
    }else{
        document.getElementById(documento_carrete).style.display = 'none';
    }
}

function toggleDiv(cubierta_carrete)      //
{
    if(document.getElementById(cubierta_carrete).style.display == 'none'){
        document.getElementById(cubierta_carrete).style.display = 'block';
    }else{
        document.getElementById(cubierta_carrete).style.display = 'none';
    }
}

function toggleDiv(acessorio_carrete)     //
{
    if(document.getElementById(acessorio_carrete).style.display == 'none'){
        document.getElementById(acessorio_carrete).style.display = 'block';
    }else{
        document.getElementById(acessorio_carrete).style.display = 'none';
    }
}

//FIM ABRE  E FECHA DIV---------------------------------------------------------


//LINKS RELATORIOS--------------------------------------------------------------

function AbrePdfOrdemCarga(id)             //
{
    window.open("/ordemcargas/print_ordem/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400')
}

function AbrePdfOrdemCargaSuministro(id)   //
{
    window.open("/ordemcargas/suministro_comprovante/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400')
}

function AbrePdfOrdemCargaAdelanto(id)     //
{
        window.open("/ordemcargas/adelanto_comprovante/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400')

}

function AbrePdfOrdemCargaTodos(id)        //
{
    window.open("/ordemcargas/todos_comprovantes/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=250, LEFT=500, WIDTH=600, HEIGHT=400')
}

function AbrePdfAdelanto(id)               //
{
    window.open("/adelantofletecs/print_adelanto/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=400, WIDTH=1000, HEIGHT=400');

}

function AbrePdfSuministro(id)             //
{
    window.open("/ordemsuministrocs/print_suministro/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=400, WIDTH=1000, HEIGHT=400');

}

function AbrePdfRecepcion(id)              //
  {
  window.open("/receptickets/print_recep/"+ id, 'Pagina', ' SCROLLBARS=YES, TOP=10, LEFT=400, WIDTH=1000, HEIGHT=400');
  }

//LINKS RELATORIOS--------------------------------------------------------------


//COMPRA------------------------------------------------------------------------

function DataCompra()                  //
{
    document.getElementById("key").value = document.getElementById("compra_data_3i").value+'/'+ document.getElementById("compra_data_2i").value+'/'+document.getElementById("compra_data_1i").value;

}

function CampoCompra()                 //
{
    document.getElementById("compra_cotacao").focus();
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

function MoedaCompra(d)                  //

{
    document.getElementById('moeda').value = d
}

function TipoCompra(d)                   //

{
    document.getElementById('tipo').value = d
}

function ExibeDivCompraDetalheFatura()   //
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

function AcrecentaNumeroCompraFactura1() //
{
    document.getElementById( 'compra_documento_numero_01' ).value = '00' + document.getElementById( 'compra_documento_numero_01' ).value
}

function AcrecentaNumeroCompraFactura2() //
{
    document.getElementById( 'compra_documento_numero_02' ).value = '00' + document.getElementById( 'compra_documento_numero_02' ).value
}


function CompraGravada05Dolar()     //
{
    if( document.getElementById( 'compra_imposto_05_dolar' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_05_dolar' ).value ) / 1.05 );
        document.getElementById( 'compra_imposto_05_dolar' ).value = ( vartotal * 0.05 ).toFixed(2);
    }
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

function CompraGravada05Gs()        //
{
    if( document.getElementById( 'compra_imposto_05_guarani' ).value == 0 )
    {
        vartotal = ( parseFloat( document.getElementById( 'compra_gravadas_05_guarani' ).value ) / 1.05 );
        document.getElementById( 'compra_imposto_05_guarani' ).value = ( vartotal * 0.05 ).toFixed(0);
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

//FIM COMPRA--------------------------------------------------------------------

function DiarioDebeCampoKey()    //
{
document.getElementById('key').value = document.getElementById('diario_debe_rubro_id').value
}


function DiarioHaberCampoKey()    //
{
document.getElementById('key').value = document.getElementById('diario_haber_rubro_id').value
}


function FocusField(c)    //
{
    document.getElementById(c).focus();
}

