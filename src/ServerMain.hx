package ;

import haxe.Firebug;
import haxe.Log;
import haxe.Template;
import neko.FileSystem;
import neko.io.File;
import neko.Lib;
import neko.Sys;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class ServerMain 
{
	
	// PLEASE NOTE!
	// This is a super simple neko server setup, just to serve the demo pages!
	// This has nothing to do with the HxJsMicroMvc concept!
	// Thanks!
	
	static function main() 
	{
		Log.trace = Firebug.trace;
		var uri = Web.getURI();
		var design = File.getContent(Web.getCwd() + '/pages/design.html');
		var page = Web.getURI().substr(1).split('/').shift();
		page = (page == '') ? 'home' : page ;		
		var content = File.getContent(Web.getCwd() + '/pages/' + page + '.html');
		var template = new Template(design);
		Lib.print(template.execute( { content:content } ));
	}
	
}