/**
 *	Author: Angel Chrystian Torres
 *	Date: 2/16/2019
 *	Custom appender that writes a dump in  an html format.
 **/
component accessors="true" extends="coldbox.system.logging.AbstractAppender"{
  pageEncoding "utf-8";

  /**
   * Constructor
   *
   * @name The unique name for this appender.
   * @properties A map of configuration properties for the appender"
   * @layout The layout class to use in this appender for custom message rendering.
   * @levelMin The default log level for this appender, by default it is 0. Optional. ex: LogBox.logLevels.WARN
   * @levelMax The default log level for this appender, by default it is 5. Optional. ex: LogBox.logLevels.WARN
   */
  function init(
    required name,
    struct properties={},
    layout="",
    levelMin=4,
    levelMax=4
  ){
    // Init supertype
    super.init( argumentCollection=arguments );

    return this;
    }

  /**
   * @logEvent The logging event to log
   */
  function logMessage( required coldbox.system.logging.LogEvent logEvent ){
    var loge = arguments.logEvent;
    logDir = application.cbController.getSetting( 'logDirectory' );
    if( hasCustomLayout() ){
        entry = getCustomLayout().format( arguments.logEvent );
    }else{
        savecontent variable="entry"{
          writeOutput( "
            <p>TimeStamp: #loge.getTimeStamp()#</p>
            <p>Severity: #loge.getSeverity()#</p>
            <p>Category: #loge.getCategory()#</p>
            <hr/>
            <p>#loge.getMessage()#</p>
            <hr/>
            <p>Extra Info Dump:</p>
          " );
        if( isObject( loge.getExtraInfo() ) ){
          writeDump( var = loge.getExtraInfo(), top = 1 );
        }else{
        	writeDump( loge.getExtraInfo() );
        }
      }
    }
    fileWrite( '#logDir#debug_#dateFormat(now(),"ddmmyy")#_#timeFormat(now(),"HHmmss")#.html', entry );
    return this;
  }

}