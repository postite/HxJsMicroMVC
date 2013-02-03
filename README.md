HxJsMicroMVC
============

Very simple experiment for a concept of structuring the clientside Haxe JS/JQuery stuff. 

HxJsMicroMvc v 0.0.1

Please note:
VERY SIMPLE PROTOTYPE/PROOF OF CONCEPT!
Don't expect anything solid or secure here!
(Actully, don't expect MVC! It's more of a MVP concept, I guess.)

This is a simple attempt to solve the organization of client side js/jquery-stuff.
Most of the inspiration comes out of the use of AngularJS, with its concept of
controllers for handling stuff. (But don't expect any binding mechanism here!)

It's based around the concept with two basic parts, context and controllers:

Context:
-------
The context is a 'director' that keeps track of the application controllers, and
invokes them based on the current uri and parameters.

This is an example of a Main class an an HxJsMicroMVC application.
The context is set up with an array of the application controllers.

class ClientMain 
{	
	public function new() {
		var context = new JSContext([
			ContactController,
			HomeController, // Home/Index controller (uri '/') should be added last
		]);		
		context.getController(context.getURI());
	}
	
	static function main() 	{		
		new ClientMain();
	}	
}

Controllers:
------------

The controllers have two things worth notice:
1. They are bound to uris via @uri metadata in regexp form. 

The following controller is invoked when the current page is the index page ('/'):

@uri('/')   // <-- This metadata for index controller can be left out
class HomeController implements IJSController {	
	public function new() {
		trace('new HomeController');
	}		
}

The following controller is invoked when the current page uri is '/contacts:
@uri('/contacts')   // or @uri('/(contacts)')
class ContactsController implements IJSController {	
	public function new() {
		trace('new ContactsController');
	}		
}

2. If they extend the JQureyController, they are able to automatically invoke JQuery 
objects based on metadata @id and the variable name.

@uri('/(test)');
class TestController extends JQureyController {	
	@id private var button1:JQuery; 
	public function new() {
		trace('new TestController');
	}	
}

In the above example, the metadata @id triggers an attempt to setup the following behind the scenes:

	this.button1 = JQuery('#button1');

No rocket science, but quite handy.


Setup:
------

The js project is compiled into 'bin/micromvc-client.js', and this file is
linked into the html page:
<script src="/micromvc-client.js"></script>	