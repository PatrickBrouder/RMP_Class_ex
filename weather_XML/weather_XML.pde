// Despite the title of this sketch, we are not processing RSS in this script

// If you have difficulty with any of the code/concepts below please 
// have a look at https://processing.org/tutorials/data/

/*
 * Below is a link to an openweathermap.org API. The text APIKEY in the link below is going
 * to be replaced by the actual APIKEY. I do it this way for security reasons.
 */
String url="http://api.openweathermap.org/data/2.5/weather?q=Clonmel&APPID=APIKEY&mode=xml";

// The following will hold the name of the location whose weather we are reading
String locationName;

// The following will hold the temperature of the location
int temperature;

void setup() {
  size(600, 600);
  
  // Use anto aliasing
  smooth();
  
  // Set the background colour
  background(200);
  
  // Set the font to use for text
  PFont generalFont = createFont("Ariel", 20, true); // Arial, 20 point, anti-aliasing on
  textFont(generalFont);
  
  
  // Get the api key (using the function I wrote) and replace the text APIKEY in the 
  // link with the key
  
  String apiKey = getAPIKey();
  
  if (apiKey == null)
  {
    println("Failed to find API KEY for openweathermap.org");
    exit();
  }
  
  url = url.replace("APIKEY", apiKey);
  
  // loadXML loads the xml at the given url (or file)
  XML xmlResponse = loadXML(url);
  
  // formt the xmlResponse we have received into a string and indent using 5
  // spaces, then print out the string. I'm doing this for information 
  // purposes only
  print(xmlResponse.format(5));
  
  /* Get the child of the root node ('current' in this case) called 'city'. The
     getChild() method returns an XML object that models the XML in question.
  */
  XML locationNode = xmlResponse.getChild("city");

  /* Get the String value of the attribute called 'name'
  */
  locationName = locationNode.getString("name");
  
  
  XML temperatureNode = xmlResponse.getChild("temperature");
  
  // Get the value of the 'temp' attribute as a float, substract -273.15 as the temperature
  // is given in kelvin and we want to convert it to celius. The cast to an int. We cast it
  // to an int because we use it later on and we need it in int format.
  temperature = (int)(temperatureNode.getFloat("value")-273.15);
  
  // Set the color mode to Hue Saturation Brightness (HSB) as apposed to RGB
  // and set the max value of the H, the S and the B values to be 100.
  colorMode(HSB, 100);
}

void draw() {
  // Draw the title 
  fill(0);
  textAlign(CENTER);
  text(locationName, width/2, 20);
  
  // Draw a circle. Remember we are specifying color as HSB. I am modifying the
  // saturation value based the temperature. A hue value of 0 is red
  // see http://infohost.nmt.edu/tcc/help/pubs/colortheory/web/hsv.html
  fill(0, temperature, 100);
  noStroke();
  
  // Note that I am using the map function to map temperature from a
  // range of 20 - 100 to a range of 10 - width
  float diameter = map(temperature, -10, 30, 10, width);
  ellipse(width/2, height/2, diameter, diameter);
  noLoop();
  
}

String getAPIKey()
{
  String theKey = null;
  /* Read the apikeys.xml file that I have in the data folder. This file takes the following
     format
     
     <?xml version="1.0" encoding="UTF-8"?>
     <apikeys>
        <key provider=“openweathermap.org” key=“jkqnvf7v9qefv7qhenrjnfjvsif7v9f656548rg”></key>
     </apikeys>

 */
   
  XML xml = loadXML("apikeys.xml");
  
  if (xml == null)
  {
    // The file isn't there lets "abort"
    println("Failed to locate the file apikeys.xml");
    exit();
  }
  else
  {
    // Note in the sample xml above I have only one key so the array will only have one element.
    // In the future I may have many keys.
    XML[] allKeys = xml.getChildren("key");
    
    for (int i=0; i<allKeys.length; i++)
    {
      if (allKeys[i].getString("provider").equals("openweathermap.org"))
      {        
        // Bingo, found the one I'm looking for. Set the APIKEY 
        theKey = allKeys[i].getString("key");
        
        // break out of the for loop, we have found what we are looking for
        break;
      }
    }
  }
  
  return theKey;
}