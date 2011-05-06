<!---
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

StringBuffer.cfc
This CFC greatly increases the speed of string concatenation. CF strings are immutable. When you append a string
to another string, a whole new string is created. This is fine for a small number of iterations but painfully
slow and memory intensive for a large number of concatenation operations.

greg.lively@gmail.com
Use this program however you want.

To use:
<cfscript>
	variables.joStringBuffer = createObject('component', 'StringBuffer');
	variables.joStringBuffer.append(variables.someDataVar);
	writeOutput(variables.joStringBuffer.getString());
</cfscript>

from Java 1.5 API:
StringBuffer
A thread-safe, mutable sequence of characters. A string buffer is like a String, but can be modified. At any point in
time it contains some particular sequence of characters, but the length and content of the sequence can be changed
through certain method calls.

String buffers are safe for use by multiple threads. The methods are synchronized where necessary so that all the
operations on any particular instance behave as if they occur in some serial order that is consistent with the
order of the method calls made by each of the individual threads involved.

When a StringBuffer object is created it has a capacity, which is the number of characters that the StringBuffer will contain if full. If the default constructor is called with no parameters this capacity is set to 16, otherwise an int may be passed as a parameter to specify the capacity. Another constructor allows an initial set of characters to be passed as a parameter, in this case the capacity of the StringBuffer will be the number of characters in the initial string plus a further 16. The following example shows the possible ways of building StringBuffer objects.

StringBuffer = strbuf new StringBuffer (); // capacity = 16
StringBuffer = strbuf2 new StringBuffer (25); // capacity = 25
StringBuffer = strbuf3 new StringBuffer ("Java"); // capacity = 4 + 16 = 20

************************************************************************************************

Author 	 :	Luis Majano
Date     :	September 23, 2005
Description :
	Converted this cfc into a ColdBox plugin. You can now also, append to a file, if needed.

Modification History:
08/01/2006 - Updated the cfc to work for ColdBox.

--->
<cfcomponent hint="This CFC greatly increases the speed of string concatenation. CF strings are immutable. When you append a string to another string, a whole new string is created. This is fine for a small number of iterations but painfully slow and memory intensive for a large number of concatenation operations. This plugin switches between StringBuilder and StringBuffer if running under cf8"
			 output="false"
			 cache="false">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<!--- Constructor --->
	<cffunction name="init" access="public" returntype="StringBuffer" output="false">
		<cfscript>
			
			setpluginName("StringBuffer");
			setpluginVersion("1.0");
			setpluginDescription("This is a facade to the java StringBuffer class.");
			setpluginAuthor("Luis Majano");
			setpluginAuthorURL("http://www.coldbox.org");
			
			// init the string buffer
			variables.buffer = createObject("java","java.lang.StringBuffer");
			
			return this;
		</cfscript>		
	</cffunction>
	
	<!--- Setup Constructor --->
	<cffunction name="setup" access="public" returntype="any" output="false" hint="initializes the StringBuffer CF/java object">
		<!--- ************************************************************* --->
		<cfargument name="strIn" 			type="string" 	required="No" default=""   hint="A string to initialize the buffer with. The bufferLength will be the number of characters + 16. This argument is mutually exclusive to BufferLength" />
		<cfargument name="bufferLength" 	type="numeric" 	required="no" default="16" hint="The length to start the buffer at. The default is 16 characters. This argument is mutually exclusive to strIn ">
		<!--- ************************************************************* --->
		<cfif arguments.strIn neq "">
			<cfset variables.buffer.init(javaCast("string", arguments.strIn)) />
		<cfelse>
			<cfset variables.buffer.init(javaCast("int", arguments.BufferLength)) />
		</cfif>
		<cfreturn this />
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->

	<!--- Append a message --->
	<cffunction name="append" returntype="void" access="public" output="false" hint="Append a string to the buffer.">
		<!--- ************************************************************* --->
		<cfargument name="strIn" type="string" required="No" default="" hint="a string to append to the buffer" />
		<!--- ************************************************************* --->
		<cfset variables.buffer.append(javaCast("string", arguments.strIn)) />
	</cffunction>

	<!--- Delete --->
	<cffunction name="delete" returntype="void" access="public" output="false" hint="Removes the characters in a substring of this StringBuffer.">
		<!--- ************************************************************* --->
		<cfargument name="startPos" type="numeric" required="Yes" hint="The beginning index, inclusive." />
		<cfargument name="endPos" 	type="numeric" required="Yes" hint="The ending index, exclusive." />
		<!--- ************************************************************* --->
		<cfset variables.buffer.delete(javaCast("int", arguments.startPos),javaCast("int", arguments.endPos)) />
	</cffunction>

	<!--- Insert a string --->
	<cffunction name="insertStr" returntype="void" access="public" output="false" hint="Inserts the string into this string buffer at an offset.">
		<!--- ************************************************************* --->
		<cfargument name="offSet" 	type="numeric" required="No" default="0" hint="the offset" />
		<cfargument name="inStr" 	type="string" required="Yes" hint="a string" />
		<!--- ************************************************************* --->
		<cfset variables.buffer.insert(javaCast("int", arguments.offSet), javaCast("string", arguments.inStr)) />
	</cffunction>

	<!--- Replace a string --->
	<cffunction name="replaceStr" returntype="void" access="public" output="false" hint="Replaces the chracters in a substring of this StringBuffer with characters in the specified inStr">
		<!--- ************************************************************* --->
		<cfargument name="startPos" type="numeric" 	required="Yes" hint="The beginning index, inclusive." />
		<cfargument name="endPos" 	type="numeric" 	required="Yes" hint="The ending index, exclusive." />
		<cfargument name="inStr" 	type="string" 	required="Yes" hint="a string" />
		<!--- ************************************************************* --->
		<cfset variables.buffer.replace(javaCast("int", arguments.startPos), javaCast("int", arguments.endPos), javaCast("string", arguments.inStr)) />
	</cffunction>

	<!--- Index Of --->
	<cffunction name="indexOf" returntype="numeric" access="public" output="false" hint="Returns the index within this string of the first occurrence of the specified substring.">
		<!--- ************************************************************* --->
		<cfargument name="inStr" 	type="string" required="Yes" hint="the substring for which to search" />
		<cfargument name="fromPos" 	type="numeric" required="No" default="0" hint="the index from which to start the search" />
		<!--- ************************************************************* --->
		<cfreturn variables.buffer.indexOf(javaCast("string", arguments.inStr),javaCast("int", arguments.fromPos)) />
	</cffunction>

	<!--- Last index of --->
	<cffunction name="lastIndexOf" returntype="numeric" access="public" output="false" hint="Returns the index within this string of the last occurrence of the specified substring.">
		<!--- ************************************************************* --->
		<cfargument name="inStr" 	type="string" required="Yes" hint="the substring for which to search" />
		<cfargument name="fromPos" 	type="numeric" required="No" default="0" hint="the index from which to start the search" />
		<!--- ************************************************************* --->
		<cfreturn variables.buffer.lastIndexOf(javaCast("string", arguments.inStr),javaCast("int", arguments.fromPos)) />
	</cffunction>

	<!--- Sub String --->
	<cffunction name="substring" returntype="string" access="public" output="false" hint="Returns a new String that contains a subsequence of characters currently contained in this StringBuffer.The substring begins at the specified index and extends to the end of the StringBuffer.">
		<!--- ************************************************************* --->
		<cfargument name="startPos" type="numeric" required="Yes" hint="The beginning index, inclusive." />
		<cfargument name="endPos" 	type="numeric" required="No" default="#(variables.buffer.length() - 1)#" hint="The ending index, exclusive." />
		<!--- ************************************************************* --->
		<cfreturn variables.buffer.substring(javaCast("int", arguments.startPos),javaCast("int", arguments.endPos)) />
	</cffunction>

	<!--- Reverse String --->
	<cffunction name="reverseStr" returntype="void" access="public" output="false" hint="The character sequence contained in this string buffer is replaced by the reverse of the sequence.">
		<cfset variables.buffer.reverse() />
	</cffunction>

	<!--- Set the length --->
	<cffunction name="setLength" returntype="void" access="public" output="false" hint="Sets the length of this String buffer.">
		<!--- ************************************************************* --->
		<cfargument name="newLength" type="numeric" required="true" hint="Length in characters to set.">
		<!--- ************************************************************* --->
		<cfset variables.buffer.setLength(JavaCast("int", arguments.newLength)) />
	</cffunction>

	<!--- Get the length --->
	<cffunction name="length" returntype="numeric" access="public" output="false" hint="Returns the length (character count) of this string buffer.">
		<cfreturn variables.buffer.length() />
	</cffunction>

	<!--- Get the capacity --->
	<cffunction name="capacity" returntype="numeric" access="public" output="false" hint="Returns the current capacity of the String buffer.">
		<cfreturn variables.buffer.capacity() />
	</cffunction>

	<!--- Get the string --->
	<cffunction name="getString" returntype="string" access="public" output="false" hint="Converts to a string representing the data in this string buffer.">
		<cfreturn variables.buffer.toString() />
	</cffunction>

	<!--- Get the String Buffer --->
	<cffunction name="getStringBuffer" returntype="any" access="public" output="false" hint="Return the StringBuffer Java Object">
		<cfreturn variables.buffer />
	</cffunction>

</cfcomponent>