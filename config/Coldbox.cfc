component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= getSystemSetting( "APPNAME", "Edovate API" ),
			eventName 				= "event",

			//Auto-deserialization of JSON Payloads
			jsonPayloadToRC = true,

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "Main.welcome",
			requestStartHandler		= "",
			requestEndHandler		= "",
			applicationStartHandler = "",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			invalidHTTPMethodHandler = "",
			exceptionHandler		= "Main.onException",
			invalidEventHandler			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			viewCaching				= false
		};

		// custom settings
    settings = {
      adminEmail    = "issues@angel-chrystian.com",
      testMode      = false,
      testingEmail  = "issues@angel-chrystian.com",
      rootDirectory = getDirectoryFromPath( expandPath("/") ),
      maintenance   = false,
      developerMail = 'issues@angel-chrystian.com'
    };
    settings.logDirectory = settings.rootDirectory & 'logs/';

		// Relax Configuration Settings
    relax = {
        // The location of the relaxed APIs, defaults to models.resources
        APILocation = "models.resources",
        // Default API to load, name of the directory inside of resources
        defaultAPI = "forgebox",
        // Whether to cache the API Service as a singleton - In development/authoring, you'll want this set to false
        cache = true
    };

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "edovate-api\.local",
			staging = "apidev\.edovate\.com"
		};

		// Module Directives
		modules = {
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		mailsettings = {
      server = 'mail.angel-chrystian.com',
      username = 'issues@angel-chrystian.com',
      password = 'Brad2610*'
    };

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" },
				dumpAppender = {
          properties = {},
          class = "models.logAppenders.DumpAppender",
          levelMin=4,
          levelMax=4
        },
        dumpErrorAppender = {
          properties = {},
          class = "models.logAppenders.DumpAppender",
          levelMin=0,
          levelMax=0
        },
        emailAppender = {
          properties = {
            subject = ' Error #coldbox.appName#',
            from = settings.adminEmail,
            to = settings.developerMail,
            mailserver = mailsettings.server,
            mailusername = mailsettings.username,
            mailpassword = mailsettings.password
          },
          class = "coldbox.system.logging.appenders.EmailAppender",
          levelMin=0,
          levelMax=0
        },
        fileAppender = {
          properties = {
            filePath = '/logs',
            fileMaxArchives = 5,
            fileMaxSize = 5000,
            async = false,
            fileName = 'edovateapilogs',
            fileEncoding = 'utf-8'
          },
          class = "coldbox.system.logging.appenders.RollingFileAppender",
          levelMin=0,
          levelMax=3
        }
			},
			// Root Logger
			root = { levelmin="FATAL", levelmax="DEBUG", appenders="*" },
			// Implicit Level Categories
			off = [ 'coldbox.system' ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
		];

		/*
		// module setting overrides
		moduleSettings = {
			moduleName = {
				settingName = "overrideValue"
			}
		};

		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		layouts = [
			{ name = "login",
		 	  file = "Layout.tester.cfm",
			  views = "vwLogin,test",
			  folders = "tags,pdf/single"
			}
		];

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "models",
			eventAction 	 = "index"
		};

		*/

	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		relax.cache = false;
	}

}