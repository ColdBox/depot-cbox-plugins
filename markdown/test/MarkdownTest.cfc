<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Luis Majano
Date        :	01/10/2008
License		: 	Apache 2 License
Description :
	A test for markdown

----------------------------------------------------------------------->
<cfcomponent extends="coldbox.system.testing.BasePluginTest" plugin="codedepot.cbox-plugins.markdown.Markdown">

<cfscript>
	function setup(){
		this.loadcoldbox = false;
		super.setup();
		
		mockController.$("getAppHash", hash("markdown-unittest")).$("settingExists",false);
		javaLoader 	= getMockPlugin("coldbox.system.plugins.JavaLoader").init(mockController);
		markdown 	= plugin;
		markdown.$("getPlugin",javaLoader);
		
		//start it up
		markdown.init();
	}
	
	function testtoHTML(){
		text = "This is a *simple* test.";
		results = markdown.toHTML(text);
		
		debug(results);
		AssertEquals("<p>This is a <em>simple</em> test.</p>",results);
	}
</cfscript>


</cfcomponent>