<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2008 by
Luis Majano (Ortus Solutions, Corp) and Mark Mandel (Compound Theory)
www.transfer-orm.org |  www.coldboxframework.com
********************************************************************************
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************
$Build Date: @@build_date@@
$Build ID:	@@build_id@@
********************************************************************************
----------------------------------------------------------------------->
<cfcomponent name="Avatar" 
			 hint="An avatar display plugin" 
			 extends="coldbox.system.plugin" 
			 output="false"
			 cache="true">
  
<!------------------------------------------- CONSTRUCTOR ------------------------------------------->	
   
    <cffunction name="init" access="public" returntype="Avatar" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfscript>
  		super.Init(arguments.controller);
  		
  		setpluginName("Avatar");
  		setpluginVersion("1.1");
  		setpluginDescription("An avatar display plugin");
  		
  		//Return instance
  		return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->	

	<!--- renderAvatar --->
	<cffunction name="renderAvatar" output="false" access="public" returntype="any" hint="Render an avatar image according to email sent">
		<cfargument name="email" 		type="string"  	required="true" hint="The email to use for the Avatar">
		<cfargument name="size"  		type="numeric" 	required="false" default="80" hint="A size for the avatar"/>
		<cfargument name="rating"   	type="string" 	required="false" default="PG" hint="The default rating for this Avatar"/>
		<cfargument name="defaultIMG"   type="string" 	required="false" default=""   hint="A default image to add to the string, optional.">
		<cfset var rc = getController().getRequestService().getContext().getCollection()>
		<cfset var avatar = "">
		<cfset var emailTarget = arguments.email>
		<cfoutput><cfset var defaultIMGString = "">
		
		<!--- Check Default IMG --->
		<cfif len(trim(arguments.defaultIMG))>
			<cfset defaultIMGString = "&default=#urlEncodedFormat(arguments.defaultIMG)#">
		</cfif></cfoutput>
		
		<!--- render the avatar --->
		<cfsavecontent variable="avatar">
			<cfoutput>
			<img align="middle" src="http://www.gravatar.com/avatar.php?gravatar_id=#lcase(Hash(emailTarget))#&r=#arguments.rating#&s=#arguments.size##defaultIMGString#" alt="#emailTarget#'s Gravatar" />
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn avatar>
	</cffunction>
    
<!------------------------------------------- PRIVATE ------------------------------------------->	

	
</cfcomponent>