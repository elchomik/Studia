
function Zapisz(){
    var zmienna={};
    zmienna.email=document.getElementById('email').value;
    zmienna.imie=document.getElementById('imie').value;
    zmienna.nazwisko=document.getElementById('nazwisko').value;
    zmienna.uczelnia=document.getElementById('uczelnia').value;
    
    var list=JSON.parse(localStorage.getItem('form'));
    
    if(list===null) list=[];
    list.push(zmienna);
    sessionStorage.setItem('form',JSON.stringify(list));
    localStorage.setItem('form',JSON.stringify(list));
}

function Pokaz(){
    
    var list=JSON.parse(sessionStorage.getItem('form'));
    
    var element=document.getElementById('form');
    var str="<h2>Dane użytkownika</h2>";
    if(list===null) element.innerHTML=str+"<p>Brak Chętnych</p>";
    else{
        for(i=0;i<list.length;i++){
            str+="<p>Imie: "+list[i].imie+"</br> Nazwisko:" +
                    list[i].nazwisko+"</br> Email: "
                    +list[i].email+"</br> Uczelnia: "+
                    list[i].uczelnia;
                    +"</p>";
        }
    }element.innerHTML=str;
}
function Wyczysc(){
    localStorage.removeItem('form');
    sessionStorage.removeItem('form');
    Pokaz();
}