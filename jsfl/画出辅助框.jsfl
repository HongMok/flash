fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().addNewLayer();
fl.getDocumentDOM().addNewRectangle({left:0, top:0, right:755, bottom:475}, 0, true);
fl.getDocumentDOM().getTimeline().setLayerProperty('layerType', 'guide');
fl.getDocumentDOM().getTimeline().setLayerProperty('locked', true);
fl.getDocumentDOM().getTimeline().setLayerProperty('name', '屏幕边界');
fl.getDocumentDOM().save();