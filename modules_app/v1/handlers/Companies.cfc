/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/29/2019
 *	Event handler for companies in the API.
 **/
component extends="handlers.BaseHandler"{
	property name="companyService" inject="services.companyService";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {
		index = "GET"
	};

	/**
	* Index
	*/
	any function index( event, rc, prc ){
	  // Get the environment
	  local.dev = getSetting( "environment" );

	  // By default limit to 20 results starting from row 1
	  event.paramValue( 'limit', 20 );
	  event.paramValue( 'offSet', 1 );

	  local.args = { asStruct = true };
	  structAppend( local.args, rc );
    local.result = companyService.get( argumentCollection = args );

    // Put the result in the response object
		prc.response.setData( local.result );
	}

/**
 * Returns a Company if the companyID is provided
 **/
  public any function getCompany( event, rc, prc ){

    if( event.valueExists( 'companyID' ) && isNumeric( rc.companyID ) ){
    	local.args = {
        companyID = rc.companyID,
        top = getSetting( "environment" ) == 'development' ? 2 : 0,
        asStruct = true
      };
    	local.result = companyService.get( argumentCollection = args );

    	prc.response.setData( local.result );
    }
  }

}