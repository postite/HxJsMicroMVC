package cx.micromvc.client;
import js.JQuery;
import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class JQueryController implements IJSController
{
	public function new() 
	{		
		var metaFields = haxe.rtti.Meta.getFields(ReflectTools.getClass(this));
		var fields = ReflectTools.getObjectFields(metaFields);
		
		for (field in fields) {
			var jq = new JQuery('#' + field);
			if (jq.length > 0) {
				Reflect.setField(this, field, jq);
			} else {
				trace('Cant find dom element #' + field);
			}
		}	
		
		new JQuery(Lib.window).bind('hashchange', this.onHashChange);	
		this.onHashChange(null);
	}
	
	private function onHashChange(e=null) {
		trace('JQueryController.onHashChange() : ' + Lib.window.location.hash);
	}
	
}