var i = 2;

function prevPage(el)
{	
	var lPage = document.getElementById("lPage");
	var rPage = document.getElementById("rPage");
	
	if (i > 2){
	i--;
	rPage.innerHTML = lPage.innerHTML;
	lPage.innerHTML = document.getElementById("Ch" + (i - 2)).innerHTML;
	}
}

function nextPage(el)
{	
	var lPage = document.getElementById("lPage");
	var rPage = document.getElementById("rPage");
	
	if (i < 9){
	lPage.innerHTML = rPage.innerHTML;
	rPage.innerHTML = document.getElementById("Ch" + i).innerHTML;
	i++;
	}
}