
function kwota()
{
var K=document.getElementById('K');
K=K.value;
K=parseInt(K);

var pr=document.getElementById('pr');
pr=pr.value;
pr=parseFloat(pr);
pr=pr/100;

var n=document.getElementById('n');
n=n.value;
n=parseFloat(n);

var pr_mc=document.getElementById('pr_mc');
pr_mc=(pr/12);

var rata=document.getElementById('rata');

rata.value=(K*pr_mc)/(1-(1/(Math.pow(1+pr_mc,n))));

}

