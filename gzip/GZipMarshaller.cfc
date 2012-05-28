<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/2/2007
Description :
	Ability to serialize/deserialize gzip data.
----------------------------------------------------------------------->
<cfcomponent output="false" hint="Ability to serialize/deserialize gzip objects.">

	<cffunction name="init" output="false" access="public" returntype="GZipMarshaller" hint="Constructor">
    	<cfscript>
			return this;
    	</cfscript>
    </cffunction>
	
	<!--- compress --->
	<cffunction name="compress" output="false" access="public" returntype="any" hint="Serialize and do gzip compression an incoming object">
		<cfargument name="target"   type="any" 		required="true" 	hint="The complex object, such as a query or CFC, that will be serialized."/>
	   	<cfargument name="filePath" type="string" 	required="false" 	hint="The path of the file in which to save the serialized data."/>
		<cfscript>
			var binaryData = "";
			var byteArrayOutput = CreateObject("java", "java.io.ByteArrayOutputStream").init();
            var gzipFilter 		= CreateObject("java", "java.util.zip.GZIPOutputStream").init(byteArrayOutput);
			var objectOutput    = CreateObject("java", "java.io.ObjectOutputStream").init(gzipFilter);
           
            // Serialize the incoming object.
        	objectOutput.writeObject(arguments.target);
        	objectOutput.flush();
			objectOutput.close();
			gzipFilter.close();
			
			// Get binary
			binaryData = toBase64(byteArrayOutput.toByteArray());
			
			// Save to File?
			if( structKeyExists(arguments,"filePath") ){
				saveToFile(arguments.filePath,binaryData);
			}
			
			return binaryData;
		</cfscript>
	</cffunction>
	
	<!--- decompress --->
	<cffunction name="decompress" output="false" access="public" returntype="any" hint="Decompress and deserialize an incoming object">
		<cfargument name="binaryObject" type="any" 		required="false" hint="The binary object to inflate"/>
		<cfargument name="filepath" 	type="string" 	required="false" hint="The location of the file that has the binary object to inflate"/>
		<cfscript>
			var obj = "";
			var byteArrayInput = "";
			var gzipInput = "";
			var objectInput = "";
			
			// Read From File?
			if( structKeyExists(arguments,"filePath") ){
				arguments.binaryObject = readFile(arguments.filePath);
			}
			
			// Which algorithm to use?
			byteArrayInput = CreateObject("java", "java.io.ByteArrayInputStream").init( toBinary(arguments.binaryObject) );
			gzipInput 	   = CreateObject("java", "java.util.zip.GZIPInputStream").init(byteArrayInput);
			objectInput    = CreateObject("java", "java.io.ObjectInputStream").init(gzipInput);
			
			// inflate and decompress object
			obj = ObjectInput.readObject();
			objectInput.close();

			return obj;
		</cfscript>
	</cffunction>

<!------------------------------------------- PRIVATE ------------------------------------------>
    
	<!--- Save To File --->
	<cffunction name="saveToFile" access="private" hint="Facade to save a file's content" returntype="void" output="false">
		<!--- ************************************************************* --->
		<cfargument name="fileToSave"	 	type="any"  	required="yes" 	 hint="The absolute path to the file.">
		<cfargument name="fileContents" 	type="any"  	required="yes"   hint="The file contents">
		<cfargument name="charSet"			type="string"   required="false" default="utf-8" hint="CF File CharSet Encoding to use.">
		<!--- ************************************************************* --->
		<cffile action="write" file="#arguments.fileToSave#" output="#arguments.fileContents#" charset="#arguments.charset#">
	</cffunction>
	
	<!--- Read File --->
	<cffunction name="readFile" access="private" hint="Facade to Read a file's content" returntype="Any" output="false">
		<!--- ************************************************************* --->
		<cfargument name="fileToRead"	 		type="String"  required="yes" 	 hint="The absolute path to the file.">
		<!--- ************************************************************* --->
		<cfset var fileContents = "">
		<cffile action="read" file="#arguments.fileToRead#" variable="fileContents">
		<cfreturn fileContents>
	</cffunction>

</cfcomponent>