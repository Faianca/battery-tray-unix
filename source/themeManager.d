module themeManager;
import std.json;
import std.file;
import std.stdio;
import std.conv;
import std.algorithm: find;
import std.array: empty;
import std.uni: toLower;

struct Style
{
    string name;
    string[4] batteryStates = [ "battery-0.png", "battery-1.png", "battery-2.png", "battery-3.png" ];
    string connectedImage = "battery-connect.png"; 
}

class ThemeManager
{
	string defaultTheme = "blue";
	string path = "/home/jmeireles/dlang/battery-tray-unix/styles/";
	string config = "/home/jmeireles/dlang/battery-tray-unix/config/config.json";
	Style[string] styles;
	string currentTheme;

	this()
	{
		if (!exists(config)) {
			throw new Exception(config ~" not found.");
		}

		auto content = to!string(read(config));
    	JSONValue[string] document = parseJSON(content).object;
 		JSONValue[] stylesConfig = document["styles"].array;
 		currentTheme = document["currentStyle"].str;

 		foreach(styleJson; stylesConfig) {
 			JSONValue[string] style = styleJson.object;
 			Style styleTmp = Style(style["name"].str);
			
			if (currentTheme == styleTmp.name) {
				currentTheme = styleTmp.name;	
			}

 			styles[style["name"].str] = styleTmp;
 		}

	}

	string getImage(int imageLevel)
	{
		return this.path ~ this.styles[this.currentTheme].name ~ "/" ~ this.styles[this.currentTheme].batteryStates[imageLevel] ;
	}

	string getConnectedImage()
	{
		return this.path ~ this.styles[this.currentTheme].name ~ "/" ~ this.styles[this.currentTheme].connectedImage;
	}

}
