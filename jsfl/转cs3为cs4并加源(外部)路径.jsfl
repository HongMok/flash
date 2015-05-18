var doc = fl.getDocumentDOM();
doc.setPlayerVersion("FlashPlayer10");
doc.asVersion = 3; 
doc.externalLibraryPath = doc.externalLibraryPath.replace(/\.$/,"");
doc.externalLibraryPath = "../../as";
doc.sourcePath = doc.sourcePath.replace(/\.$/,"");
doc.sourcePath = "../../as";
fl.trace("转换成功！………………………………………………\nflash版本为：CS4\n脚本为：AS3\n源路径为：../../as \n外部库路径设置为：../../as");