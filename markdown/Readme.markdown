********************************************************************************
**Copyright since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp**

[www.coldbox.org](http://www.coldbox.org) | [www.luismajano.com](http://www.luismajano.com) | [www.ortussolutions.com](http://www.ortussolutions.com)
********************************************************************************

Markdown Plugin For ColdBox
===========================

**ColdBox Version: 3.0.0**

This plugin uses the markdownJ library found here: 

* [MarkdownJ](http://code.google.com/p/markdownj/) is the pure Java port of Markdown (a text-to-html conversion tool written by John Gruber.)

## What is Markdown? ##

Markdown is a text-to-HTML conversion tool for web writers. Markdown allows you to write using an easy-to-read, easy-to-write plain text format, then  convert it to structurally valid XHTML (or HTML).

### Resources ###

* [Markdown Basics](http://daringfireball.net/projects/markdown/basics)

## CheatSheet ##

	# Header 1 #
	## Header 2 ##
	### Header 3 ###             (Hashes on right are optional)
	#### Header 4 ####
	##### Header 5 #####
	
	## Markdown plus h2 with a custom ID ##         {#id-goes-here}
	[Link back to H2](#id-goes-here)
	
	This is a paragraph, which is text surrounded by whitespace. Paragraphs can be on one 
	line (or many), and can drone on for hours.  
	
	Here is a Markdown link to [Warped](http://warpedvisions.org), and a literal . 
	Now some SimpleLinks, like one to [google] (automagically links to are-you-
	feeling-lucky), a [wiki: test] link to a Wikipedia page, and a link to 
	[foldoc: CPU]s at foldoc.  
	
	Now some inline markup like _italics_,  **bold**, and `code()`. Note that underscores in 
	words are ignored in Markdown Extra.
	
	![picture alt](/images/photo.jpeg "Title is optional")     
	
	> Blockquotes are like quoted text in email replies
	>> And, they can be nested
	
	* Bullet lists are easy too
	- Another one
	+ Another one
	
	1. A numbered list
	2. Which is numbered
	3. With periods and a space
	
	And now some code:
	
	    // Code is just text indented a bit
	    which(is_easy) to_remember();
	
	~~~
	
	// Markdown extra adds un-indented code blocks too
	
	if (this_is_more_code == true && !indented) {
	    // tild wrapped code blocks, also not indented
	}
	
	~~~
	
	Text with  
	two trailing spaces  
	(on the right)  
	can be used  
	for things like poems  
	
	### Horizontal rules
	
	* * * *
	****
	--------------------------
	
	
	<div class="custom-class" markdown="1">
	This is a div wrapping some Markdown plus.  Without the DIV attribute, it ignores the 
	block. 
	</div>
	
	## Markdown plus tables ##
	
	| Header | Header | Right  |
	| ------ | ------ | -----: |
	|  Cell  |  Cell  |   $10  |
	|  Cell  |  Cell  |   $20  |
	
	* Outer pipes on tables are optional
	* Colon used for alignment (right versus left)
	
	## Markdown plus definition lists ##
	
	Bottled water
	: $ 1.25
	: $ 1.55 (Large)
	
	Milk
	Pop
	: $ 1.75
	
	* Multiple definitions and terms are possible
	* Definitions can include multiple paragraphs too
	
	*[ABBR]: Markdown plus abbreviations (produces an <abbr> tag)