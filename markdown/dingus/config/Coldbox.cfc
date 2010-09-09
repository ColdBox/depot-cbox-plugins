<cfcomponent output="false" hint="My App Configuration">
<cfscript>
// Configure ColdBox Application
function configure(){

	// coldbox directives
	coldbox = {
		//Application Setup
		appName 				= "Dingus",
		
		//Development Settings
		debugMode				= false,
		handlersIndexAutoReload = true,
		configAutoReload		= false,
		
		//Implicit Events
		defaultEvent			= "Dingus.index",
		
		//Application Aspects
		pluginsExternalLocation 	= "/markdown",
		handlerCaching 			= false
	};
	
	//Register interceptors as an array, we need order
	interceptors = [
		 //Autowire
		 {class="coldbox.system.interceptors.Autowire"}
	];	
}
	
</cfscript>
</cfcomponent>