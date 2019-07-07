/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/29/2019
 *	Event handler for companies in the API.
 **/
component extends="BaseHandler"{
	property name="contactService" inject="services.contactService";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	* Index
	*/
	any function index( event, rc, prc ){
	  local.dev = getSetting( "environment" );

	  local.args = {
      top = listFindNoCase( 'development,staging', local.dev ) ? 5 : 0,
      asStruct = true
    };
    if( event.valueExists( 'top' ) ) local.args.top = rc.top;
    local.result = contactService.get( argumentCollection = args );
		prc.response.setData( local.result );
	}

/**
 * Returns a Contact
 **/
  public any function getContact( event, rc, prc ){
    if( event.valueExists( 'contactID' ) && isNumeric( rc.contactID ) ){
    	try{
      	local.args = {
          contactID = rc.contactID,
          top = getSetting( "environment" ) == 'development' ? 2 : 0,
          asStruct = true
        };

      	// Get the data
      	local.result = contactService.get( argumentCollection = args );

      	// Put the data in the response
      	prc.response.setData( local.result );

      	// Add status of NOT FOUND
      	if( structIsEmpty( local.result ) ) prc.response.setStatusCode( STATUS.NOT_FOUND );
    	}catch( any e ){
    		prc.response.setError( true );
    		prc.response.addMessage( '#e.message# #e.detail#' );
    		prc.response.setStatusCode( STATUS.NOT_FOUND );
    		prc.response.setStatusText( 'Contact not found' );
    	}
    }else{
    	prc.response.setError( true );
    	prc.response.setStatusCode( STATUS.BAD_REQUEST );
    }
  }

}