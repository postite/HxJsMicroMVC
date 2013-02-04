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
		//trace(metaFields);
		var fields = ReflectTools.getObjectFields(metaFields);
		// for( p in Reflect.fields(metaFields) ){
		//  trace("loaderInfo.parameters." + p + " = " + Reflect.field(metaFields, p));
		//  if (Reflect.hasField(Reflect.field(metaFields, p),"classe"))trace("ouaip");
		// }
		var jq:JQuery= null;
		for (field in fields) {
			if (Reflect.hasField(Reflect.field(metaFields, field),"classe")){
				 jq = new JQuery('.' + field);
				}else{
			 jq = new JQuery('#' + field);
			}
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