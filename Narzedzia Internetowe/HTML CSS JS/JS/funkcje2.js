function pokaz(id){
    var tresc="";
    switch(id)
    {
        case 2: tresc+=pokazGalerie();break;
        case 3: tresc+=pokazPost();break;
        case 4: tresc+=pokazKontakt();break;
        default: tresc+=pokazOmnie();
    }
    
    document.getElementById('blok').innerHTML=tresc;
}

function pokazOmnie(){
    var tresc='<h2><br/>O mnie</h2>';
    // operator += uzupełnia łańcuch kolejną porcją znakó
    tresc+='<p>Lorem ipsum dolor paritur, ...<p>'+'<p class="srodek"><img src="https://uwalls.pl/gallery/73/8760_thumb_b1000.jpg" alt="Zdjecie"/></p>'+'<article><h2>Moje hobby</h2><p>'+'Lorem ipsum dolor sit amet,..'+'mollit anim id est laborum.</p></article>';
    
    // przekaż wynik - gotową zawartość do miejsca wywołania funkcji:
    return tresc;
}


function pokazGalerie()
{
    var tresc='<h2><br/>Moja galeria</h2>';
    tresc+='<div class="galeria">';
    
    // wygeneruj kod HTML z obrazami za pomocą pętli for:
    for(var i=1;i<=10;i++){
        tresc+='<div class="zdjecie"><img src="obraz'+i+'.JPG" alt="zdjecie"/></div>';
    }
    console.log(tresc);
    return tresc +'<div>';
}

function pokazKontakt()
{
    var tresc='<h2><br/>Kontakt</h2>';
    
    tresc+='<p> Numer telefonu: 07754545454</p><p>E-mail: matesz@twojastar.pl</p>'
    return tresc;
}

function pokazPost(){

//funkcja generuje kod formularza- dane wpisane w odpowiednie pola przez
// użytkownika zostaną przekazane mailem na wskazany adres, ale najpierw po
//zajściu zdarenia submit(wyśłij) - zostanie wywołana 

    tresc='<h2><br/>Dodaj post</h2>';
    tresc+='<article class="srodek"><form action="mailto:mateuszmarkowski101@wp.pl"\n\
    method="post" onsubmit="return pokazDane();">'+'Twoj email:<br/><input type="email" name="email" id="email" required/><br/>'+
            'Imie : <br/><input type="imie" name="imie" id="imie" required"/><br/>'+
            'Komentarz: <br/><textarea rows="3" cols="20" id="wiadomosc" name="wiadomosc" required></textarea>'+
            '<br/><input type="submit" name="wyslij" value="wyslij"/>'+
            '</form></article>';
    console.log(tresc);
    return tresc;
}

function pokazDane(){
    var dane="Następujące dane zostaną wysłane:\n";
    dane+="Email: "+document.getElementById('email').value+"\n"+"Imie:"+
            document.getElementById('imie').value+"\n"+
            "Komentarz: "
            +document.getElementById('wiadomosc').value+"\n";
            
  
    if(window.confirm(dane)){
          console.log(dane);
        return true;
    }
    else return false;
}