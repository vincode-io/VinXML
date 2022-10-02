# VinXML
This is a Swift wrapper for libxml2 (http://xmlsoft.org).  It was created to support the
iOS application Bind It (no longer available).  Although VinXML isn't a complete wrapper for libxml2, 
the functionality it provides is production quality and is was previously used in an iOS app in the App Store. 

Currently most of the libxml2 functionality exposed is for parsing and traversing an HTML or XML
document.  There is functionality for modifying content, but creating a full XML document from
scratch isn't currently supported.

## Status
VinXML is a useful library as it is, but doesn't fully support all of libxml2's functionality.  I 
am open to adding more functionality for a popularly requested feature.  I also will consider adding
functionality that fits the existing framework if a pull request is submitted.

## Value Semantics
At this time VinXML won't try to simulate value semantics (structs) for libxml2.  I doubt that 
we will ever try to simulate them due to hwo libxml2's API works.  It frankly, just doesn't
seem to be worth the effort to do something like Apple does with the stdlib for such an
edge case library like VinXML.

