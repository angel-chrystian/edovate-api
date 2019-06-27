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
		route( "/companies/:companyID-numeric" )
		  .withAction({
		  	GET = 'getCompany',
		  	POST = 'save',
		  	PUT = 'save',
		  	DELETE = 'remove'
		  })
		  .toHandler( "companies" );


		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}