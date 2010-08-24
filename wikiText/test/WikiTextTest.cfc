<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Luis Majano
Date        :	01/10/2008
License		: 	Apache 2 License
Description :
	A plugin to do wiki text interactions.

----------------------------------------------------------------------->
<cfcomponent name="WikiTextTest" 
			 extends="coldbox.system.testing.BaseTestCase" 
			 output="false">

<cfscript>
	function setup(){
		this.loadcoldbox = false;
		super.setup();
		
		mockController = getMockFactory().createMock(classNameToMock="coldbox.system.Controller",clearMethods=true);
		mockController.mockMethod("getAppHash",'unittest');
		javaLoader = createObject("component","coldbox.system.plugins.JavaLoader").init(mockController);
		
		wikiText = createObject("component","coldbox-codedepot.plugins.coldbox.wiki.WikiText");
		getMockFactory().createMock(objectToMock=wikiText);
		wikiText.mockMethod("getPlugin",javaLoader);
		/* init it */
		wikiText.init(mockController);
	}
	function tearDown(){
	
	}
	
	function testIgnoreList(){
		wikiText.setIgnoreTagList('feed');
		AssertEquals( wikiText.getIgnoreTagList(), "feed");
	}
	function testAllowedAttributes(){
		wikiText.setAllowedAttributes('style');
		AssertEquals( wikiText.getAllowedAttributes(), "style");
	}
	function testLinkBaseURL(){
		wikiText.setLinkBaseURL('http://mysite.com/{title}');
		AssertEquals( wikiText.getLinkBaseURL(), 'http://mysite.com/{title}');
	}
	function testImageBaseURL(){
		wikiText.setImageBaseURL('http://mysite.com/{image}');
		AssertEquals( wikiText.getImageBaseURL(), "http://mysite.com/{image}");
	}
	
	function testtoHTML(){
		/* convert */
		text = "'''bold'''";
		results = wikiText.toHTML(text);
		AssertEquals("<p><b>bold</b></p>",results.html);
	}
</cfscript>


</cfcomponent>