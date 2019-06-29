/**
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{
	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.setClientCookies = true;
	this.datasource = "webbquickprod";

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";

	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// application end
	public boolean function onApplicationEnd( struct appScope ){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart( string targetPage ){
		if( isDefined( 'applicationStop' ) ) applicationStop();

		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}

  function onError( any e, eventName ){
    try{
    	savecontent variable="local.message"{
        writeoutput(
          'Error in: #getPageContext().getRequest().getScheme()#://#cgi.server_name#/#cgi.script_name#?#cgi.query_string# </br>' &
          'Message: #e.message#  </br> Detail: #e.detail# </br>' &
          '#structKeyExists( e, "cause" ) ? e.cause.message : ""#  </br>'
        );
        for( var i = 1; i lte e.TagContext.len(); i++ ){
          writeoutput(
            'Raw Trace: #e.TagContext[ i ].RAW_TRACE# </br>'&
            'Tag Context: #e.TagContext[ i ].TEMPLATE# </br></hr>'
          );
        }
        writedump(var = local.message, output="#getDirectoryFromPath( getCurrentTemplatePath())#logs/OnError_#dateFormat( now(), 'ddmmyy')##timeFormat( now(), 'hhmmss')#.htm" );
      }
      var mailService = new mail(
          to = 'issues@angel-chrystian.com',
          from = 'mailer@situricia.mx',
          subject = 'Situricia.mx Site error [#CGI.SERVER_NAME#]',
          type = 'html',
          body = local.message
      );
      mailService.send();
      writeoutput('Ha ocurrido un error, por favor reportelo al webmaster' );abort;
    }catch( any err ){
    	var mailService = new mail(
          to = 'issues@angel-chrystian.com',
          from = 'mailer@situricia.mx',
          subject = 'edovate-api Site error [#CGI.SERVER_NAME#]',
          type = 'html',
          body = '#err.message# #err.detail#'
      );
      mailService.send();
    }
  }

}