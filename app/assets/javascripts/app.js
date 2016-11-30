$(document).foundation()

audioChamada = document.getElementById("chamada");
timeTo = 0;
counter = 6;

function tudoNone(){
  if(!$("#senhaAtual").hasClass("displayNone")){
    $("#senhaAtual").addClass("displayNone");
  }
  $("#senhaAtual h1").html('');
  $("#senhaAtual h4").html('');

  if($("#relogio").hasClass("displayNone")){
    $("#relogio").removeClass("displayNone");
  }

  if($("#senhaAtual").hasClass("isPrioritario")){
    $("#senhaAtual").removeClass("isPrioritario");
  }
}

function callSenha(){
  $.getJSON("/api/call", function(data){
    if(!data.nothing){
      $("#senhaAtual h1").html(data.senha);
      $.getJSON("/setors/"+data.setor_id+".json", function(dataSetor){
        $("#senhaAtual h4").html(dataSetor.nomeSetor);
      });
      $("#senhaAtual").removeClass("displayNone");
      $("#relogio").addClass("displayNone");
      timeTo = Date.now() + (10*1000);
      counter = 0;
      $.getJSON("/api/last3", function(data3){
        for(var i = 0; i < 3; i++){
          if(data3[i].isPrioritario == true){
            var html = "<div class='senha isPrioritario'>";
          }else{
            var html = "<div class='senha'>";
          }
          html = html + "<h3>"+data3[i].senha+"</h3>";
          html = html+"</div><hr/>";
          if(i == 0){
            $("#senhas div").html(html);
          }else{
            $("#senhas div").html($("#senhas div").html() + html);
          }
        }
      });
      audioChamada.play();
    }else{
      counter = counter + 1;
    }
    if(counter == 5){
      tudoNone();
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

    setTimeout(function(){moveRelogio();},1000);
}

$(document).ready(function(){
  moveRelogio();
  callSenha();
});
