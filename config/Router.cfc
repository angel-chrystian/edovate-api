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

		// A route to the queries been implemented
		route( "/test",function(event,rc,prc){
			return renderView( "test" );
		});

		// Companies resource
		route( "/companies/:companyID-numeric" )
		  .withAction({
		  	GET = 'getCompany',
		  	GET = 'save',
		  	PUT = 'save',
		  	DELETE = 'remove'
		  })
		  .toHandler( "companies" );

		// Contacts resource
    route( "/contacts/:contactID-numeric" )
      .withAction({
        GET = 'getContact',
        POST = 'save',
        PUT = 'save',
        DELETE = 'remove'
      })
      .toHandler( "contacts" );


		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}