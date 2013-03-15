

String API_KEY = "AIzaSyAQo0xBR3rzaDx4roU9YjZFIevRs0B3pJU";
String location = "8477 Sweetwood Dr, Dallas, TX";


String locationEncoded = URLEncoder.encode(location);
String url = "http://maps.googleapis.com/maps/api/geocode/xml?address=" + locationEncoded + "&sensor=false";
println("url : " + url);
XML xml = loadXML(url);

println("Name of root element is " + xml.getName());

XML statusCodeElement = xml.getChild("status");
XML[] addressComponents = xml.getChildren("result/address_component");
for (int i = 0; i < addressComponents.length; i++) {
  XML component = addressComponents[i];
  println(component.getChild("long_name").getContent());
}
String statusCodeStr = statusCodeElement.getContent();
println("Statius code: " + statusCodeStr);
