/**
 * My RESTFul Event Handler which inherits from the module `api`
 */
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
	this.allowedMethods = {};

	/**
	* Index
	*/
	any function index( event, rc, prc ){
	  local.args = {
      top = getSetting( "environment" ) == 'development' ? 5 : 0,
      asStruct = true
    };
    local.result = companyService.get( argumentCollection = args );
		prc.response.setData( local.result );
	}

/**
 * Returns a Company
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