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
		local.result = companyService.getCompanies( top = 5 );
    prc.response.setData( local.result );
	}

/**
 * Returns a Company
 **/
  public any function getCompany( event, rc, prc ){
    if( event.valueExists( 'id' ) && isNumeric( rc.id ) ){
    	local.result = companyService.getCompany( rc.id, true );
    	prc.response.setData( local.result );
    }
  }

}