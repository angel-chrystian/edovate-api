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

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}