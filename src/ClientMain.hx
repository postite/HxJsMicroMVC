package ;

import cx.micromvc.client.JSContext;
import cx.micromvc.client.IJSController;
import cx.micromvc.client.JQueryController;
import js.JQuery;
import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

/*
 * HxJsMicroMvc v 0.0.1
 * 
 * Please note:
 * VERY SIMPLE PROTOTYPE/PROOF OF CONCEPT!
 * Don't expect anything solid or secure here!
 * 
 * This is a simple attempt to solve the organization of client side js/jquery-stuff.
 * Most of the inspiration comes out of the use of AngularJS, with its concept of
 * controllers for handling stuff. (But don't expect any binding mechanism here!)
 * 
 * It's based around the concept with two basic parts, context and controllers:
 * 
 * Context:
 * The context is a 'director' that keeps track of the application controllers, and
 * invokes them based on the current uri and parameters
 * 
 * Controllers:
 * The controllers have two things worth notice:
 * 1. They are bound to uris via @uri metadata in regexp form. 
 * 2. If they extend the JQureyController, they are able to automatically invoke JQuery 
 * objects based on metadata @id and the variable name.
 *  
 * @id private var button1:JQuery; 
 * automatically sets up the following
 * this.button1 = JQuery('#button1');
 * 
 * No rocket science, but quite handy.
 * 
 * The js project is compiled into 'bin/micromvc-client.js', and this file is
 * linked into the html page:
 * <script src="/micromvc-client.js"></script>	
 * 
 */
 
 
class ClientMain 
{	
	static function main() 
	{		
		new ClientMain();
	}	
	
	public function new() {
		
		// Setup context
		// Controllers are added here.
		// Please note that the controllers should be added in "reverse complexity order"
		// with a simple HomeController last!
		
		var context = new JSContext([
			ParametersController, 
			EventsController, 
			ContactController, 
			HomeController,
			]);
			
		// If a controller is found, it's invoked here:				
		var controller = context.getController(context.getURI());
		trace(controller);
	}
}


//----------------------------------------------------------------------------
// HomeController
//
// No meta data needed for home/index controller = @url('/')

class HomeController implements IJSController {	
	public function new() {
		trace('new HomeController');
	}		
}

//----------------------------------------------------------------------------
// ContactController
//
// Shows how js methods can be invoked in the controller constructor

@uri('/(contact)/')
class ContactController implements IJSController {
	public function new() {
		Lib.alert('The ContactController says Hello world!');
	}
}

//----------------------------------------------------------------------------
// EventsController
//
// Please note that this controller EXTENDS JQueryController 
// Shows how metadata @id can be used to automatically create a JQuery object instance
// based on the variable name

@uri('/(events)/') 
class EventsController extends JQueryController {	

	@id private var btnTest:JQuery;				// shorthand for new JQuery('#btnTest')
	@id private var inputTest:JQuery;			// shorthand for new JQuery('#inputTest')
	@id private var labelUppercase:JQuery;		// shorthand for new JQuery('#labelUppercase')
	
	public function new() {		
		super();
		trace('new EventsController');
		
		btnTest.click(function(e) {
			Lib.alert('Aah! Feels sooo good!');
		});
		
		inputTest.keyup(function(e) {			
			this.labelUppercase.html(inputTest.val().toUpperCase());
		});
	}
}	

//----------------------------------------------------------------------------
// ParametersController
//
// Shows how uri parameters can be read and fed into the controller constructor

@uri('/(param)/([0-9]+)/([a-z]+)/')
class ParametersController extends JQueryController {
	
	@id public var labelPar1:JQuery;				// shorthand for new JQuery('#labelPar1')
	@id public var labelPar2:JQuery;				// shorthand for new JQuery('#labelPar2')
	@id public var labelHash:JQuery;				// shorthand for new JQuery('#labelHash')
	
	public function new(numbers:String, letters:String) {
		super();
		trace('new ParametersController ' + numbers + ' ' + letters);
		this.labelPar1.html(numbers);
		this.labelPar2.html(letters);
	}
	
	override private function onHashChange(e=null) {
		this.labelHash.html(Lib.window.location.hash);
	}
}

	
