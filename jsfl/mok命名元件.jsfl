var sel = fl.getDocumentDOM().selection;

if( sel.length == 0)
{
	alert("select none");
}
else
{
	var prefix = prompt("please input prefix:", ["item"]);
	var startId = Number(prompt("please input startID:", [0]));
	
	sortItemList(sel);
	
	for(var i = 0; i < sel.length; i++)
	{
		sel[i].name = prefix + (startId + i);
	}
}

function sortItemList(arr)
{
	for(var i = 0; i < arr.length-1; i++ )
	{
		if(arr[i].x > arr[i+1].x)
		{
			var t = arr[i];
			arr[i] = arr[i+1];
			arr[i+1] = t;
		}
	}
}