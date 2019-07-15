component extends="coldbox.system.EventHandler"{
  property name="log" inject="logbox:logger:{this}";

	// Default Action
	function index(event,rc,prc){
	}

/**
 * Welcome page
 **/
  public any function welcome( event, rc, prc ){
    event.renderData( type = "html", data = "<h1>Welcome to EDOVATE API</h1>" );
  }

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){

	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		event.setHTTPHeader( statusCode = 500 );
		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var e = prc.exception;
		//Place exception handler below:

		savecontent variable="local.message"{
      writeoutput(
        'Error in: #getPageContext().getRequest().getScheme()#://#cgi.server_name#/#cgi.script_name#?#cgi.query_string# </br>' &
        'Message: #e.getexceptionStruct().message#  </br> Detail: #e.getexceptionStruct().detail# </br>'
      );
      for( var i = 1; i lte e.getExceptionStruct().TagContext.len(); i++ ){
        writeoutput(
          'Raw Trace: #e.getExceptionStruct().TagContext[ i ].RAW_TRACE ?: ''# </br>'&
          'Tag Context: #e.getExceptionStruct().TagContext[ i ].TEMPLATE# </br></hr>'
        );
      }

    }
    writedump(var = local.message, output="#getSetting('rootdirectory')#logs/OnError_#dateFormat( now(), 'ddmmyy')#_#timeFormat( now(), 'hhmm')#.htm" );
    log.FATAL( '<strong>Server:</strong> #CGI.SERVER_NAME# <strong>Event:</strong> #rc.event#', e.getExceptionStruct() );
	}

	function onMissingTemplate(event,rc,prc){
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");

	}

/**
 *
 **/
  public any function onInvalidEventHandler( event, rc, prc ){
    writedump( var = event, top = 5 );abort;
  }

}