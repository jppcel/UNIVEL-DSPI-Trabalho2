$(document).foundation()

audioChamada = document.getElementById("chamada");

function callSenha(){
  $.getJSON("/api/call", function(data){
    if(!data.nothing){
      alert(1);
    }
  });
  setTimeout(function(){ callSenha(); },5000);
}

function moveRelogio(){
    momentoAtual = new Date();
    hora = momentoAtual.getHours();
    if(hora < 10){
      hora = "0"+hora;
    }
    minuto = momentoAtual.getMinutes();
    if(minuto < 10){
      minuto = "0"+minuto;
    }
    segundo = momentoAtual.getSeconds();
    if(segundo < 10){
      segundo = "0"+segundo;
    }

    var horas = hora+":"+minuto+":"+segundo;

    $("#relogio h1").html(horas);

    setTimeout(function(){moveRelogio(); /*verTudoNone();*/},1000);
}

$(document).ready(function(){
  moveRelogio();
  callSenha();
});
