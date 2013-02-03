package cx.micromvc.client;
import js.JQuery;

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
	}
	
}