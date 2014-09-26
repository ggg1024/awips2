include("FilteredImage.js");
var dataRequest = new FilteredImage();
dataRequest.addParameter("satellite","GOES");
dataRequest.addParameter("area_subtype","East CONUS");
dataRequest.addParameter("parameter","Imager 11 micron IR");
dataRequest.setCount(1);
dataRequest.setColormap("IREnhanced");
dataRequest.remapImage(64,192);
dataRequest.setSortValue("valid_time");
dataRequest.execute();