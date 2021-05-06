
function Zapisz()
{
    var item={};
    item.rgb=document.getElementById('rgb').value;
    item.Kolor=document.getElementById('Kolor').value;
    
    var lista=JSON.parse(sessionStorage.getItem('lista'));
    
    if(lista===null) lista=[];
    lista.push(item);
    sessionStorage.setItem('lista',JSON.stringify(lista));
    
}

function Pokaz()
{
    var lista=JSON.parse(sessionStorage.getItem('lista'));
    var el=document.getElementById('list');
    var str="<h2>Lista zadań</h2>";
    
    if(lista===null) el.innerHTML=str+"<p>Pusta lista zadań</p>";
    else{
        for(i=0;i<lista.length;i++){
    
              str+="<p style='background-color:#"+lista[i].rgb + "'>" + lista[i].rgb + ": " + lista[i].Kolor + "</p>";
        }
        el.innerHTML=str;
    }
}
function Wyczysc()
{
    sessionStorage.removeItem('lista');
    Pokaz();
}


