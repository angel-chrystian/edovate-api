component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 */

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});

		// Companies resource
		route( "/api/company/:parentID-numeric" )
		  .withAction({
		  	GET = 'view',
		  	POST = 'save',
		  	PUT = 'save',
		  	DELTE = 'remove'
		  })
		  .toHandler( "parents" );
    route( "/api/company/" )
      .withAction({
        GET = 'list'
      })
      .toHandler( "parents" );

    // Students resource
    route( "/api/student/:studentID-numeric" )
      .withAction({
        GET = 'view',
        POST = 'save',
        PUT = 'save',
        DELTE = 'remove'
      })
      .toHandler( "students" );
    route( "/api/student/" )
      .withAction({
        GET = 'list'
      })
      .toHandler( "students" );

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}