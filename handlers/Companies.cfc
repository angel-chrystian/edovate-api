/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/29/2019
 *	Event handler for companies in the API.
 **/
component extends="BaseHandler"{
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
	  local.dev = getSetting( "environment" );

	  // In Dev default to 5 rows top and struct format
	  local.args = {
      top = listFindNoCase( 'development,staging', local.dev ) ? 5 : 0,
      asStruct = true
    };
    if( event.valueExists( 'top' ) ) local.args.top = rc.top;
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