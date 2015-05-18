var folderURI = fl.browseForFolderURL("Select a folder.");
var fileList = FLfile.listFolder(folderURI + "/" + "*.fla", "files");

var targetPath = "file:///D:/vstsworkspace/mmo/source/assets/newspritesystem/furniture/";

for( var i = 0; i < fileList.length; i++ )
{
	var fullPath = folderURI + "/" + fileList[i];
	fl.trace("==" + fullPath);
	doSingle( fullPath );
}
<<<<<<< HEAD
<<<<<<< HEAD
//mod sdf
=======
//mod mod2
>>>>>>> origin/master
=======
//mod
>>>>>>> parent of 74e19f2... mod in client and ignore server
function doSingle( fullPath )
{
	var srcName = fullPath.split("/").pop();
	fl.trace(srcName);
	var arr = srcName.split("--");
	var saveName = arr[0] + arr[1] + ".fla";
	fl.trace(saveName);
	var doc = fl.openDocument(fullPath);
	
	doc.library.selectAll();
	doc.library.addItemToDocument({x:0,y:0});
	doc.selectAll();
	doc.clipCopy();
	
	var newDoc;
	var tempFile = targetPath + saveName;
	fl.trace(tempFile);
	if(fl.fileExists(tempFile))
	{
		fl.trace("file exist");
		newDoc = fl.openDocument(tempFile);
	}
	else
	{
		fl.trace("no file:" + tempFile);
		newDoc = fl.createDocument();
	}
	
	var lib = newDoc.library;
    lib.selectAll(true);
    lib.deleteItem();
	newDoc.clipPaste();

	var libItems = newDoc.library.items;
	for( var i = 0; i < libItems.length; i++ )
	{
		var singleItem = libItems[i];
		if( singleItem.name.indexOf("NSSFurRoomView") != -1 )
		{
			singleItem.name = "NSSFurRoomView" + arr[1];
			singleItem.linkageClassName = "mmo.newspritesystem.res.NSSFurRoomView" + arr[1];
		}
		
		if( singleItem.name.indexOf("NSSFurStoreView") != -1 )
		{
			singleItem.name = "NSSFurStoreView" + arr[1];
			singleItem.linkageClassName = "mmo.newspritesystem.res.NSSFurStoreView" + arr[1];
		}
	}

	newDoc.selectAll();
    newDoc.deleteSelection();
	newDoc.publish();
	fl.saveDocument( newDoc, tempFile );
	
	fl.closeDocument( newDoc );
	fl.closeDocument( doc, false );
}
