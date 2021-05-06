function dodajDate()
{
    var date=new Date();
    document.getElementById('h').innerHTML='Dzisiaj jest '+
            date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
}

function dodajZadanie()
{
    // utworzenie obiektu o odpowiednich atrybutach:
    var item={};
    item.godzina=document.getElementById('godzina').value;
    item.data=document.getElementById('data').value;
    item.zadanie=document.getElementById('zadanie').value;
    
    //odczyt listy obiektów z localStorage
    
    var lista=JSON.parse(localStorage.getItem('lista'));
    if(lista===null) lista=[]; // pracujemy z tablicą obiektów
    lista.push(item); // dodaj nowy obiekt do listy
    localStorage.setItem('lista',JSON.stringify(lista)); // zapisz nową listę
}

function pokazListe()
{
    var lista=JSON.parse(localStorage.getItem('lista'));
    var el=document.getElementById('list');
    var str="<h2>Lista Zadań</h2>";
    if(lista===null) el.innerHTML=str+"<p> Pusta Lista Zadań </p>";
    else{
        for( var i=0;lista.length;i++) // pobierz informacje o zadaniach z listy
        {
            str+="<button class='usun' onclick='usunZadanie("+i+")'>X</button>";
            str+=" "+lista[i].data+"godzina: "+lista[i].godzina+" - ";
            str+=lista[i].zadanie+"<br/>";
        }          
        el.innerHTML=str;
    }
}

function usunListe()
{
    localStorage.removeItem('lista'); // usuń całą listę z localStorage
    pokazListe();// zaktualizuj widok na stronie
}

function usunZadanie(i)
{
var lista=JSON.parse(localStorage.getItem('lista'));
// usuń i-ty element z listy zadań
if(confirm("Usunąć zadanie?")) lista.splice(i,1);
// zapisz zaktualizowaną listę w localStorage
localStorage.setItem('lista',JSON.stringify(lista)); // zapisz listę
pokazListe();// zaktualizuj widok na stronie
}