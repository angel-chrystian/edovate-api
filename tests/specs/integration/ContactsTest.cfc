/*******************************************************************************
*	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
*
*	Extends the integration class: coldbox.system.testing.BaseTestCase
*
*	so you can test your ColdBox application headlessly. The 'appMapping' points by default to
*	the '/root' mapping created in the test folder Application.cfc.  Please note that this
*	Application.cfc must mimic the real one in your root, including ORM settings if needed.
*
*	The 'execute()' method is used to execute a ColdBox event, with the following arguments
*	* event : the name of the event
*	* private : if the event is private or not
*	* prePostExempt : if the event needs to be exempt of pre post interceptors
*	* eventArguments : The struct of args to pass to the event
*	* renderResults : Render back the results of the event
*******************************************************************************/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root"{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		// do your own stuff here
	}

	function afterAll(){
		// do your own stuff here
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "/contacts route", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "Returns all the contacts", function(){
				var event = execute( route = "/contacts", renderResults = true );
        var rc = event.getCollection();
        local.data = rc.cbox_render_data.data;
        local.content = rc.cbox_rendered_content;
        expect( rc.cbox_render_data.contentType ).toBe( 'application/json' );
        expect( local.data ).toBeTypeOf( 'array' );
        expect( local.data.len() ).toBeGT( 0 );
        expect( rc.cbox_statusCode ).toBe( 200 );
        expect( isJSon( local.content ) ).toBeTrue();
			});

		});

		describe( "/contacts/:contactID route", function(){

      beforeEach(function( currentSpec ){
        // Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
        setup();
      });

      it( "Returns one contact", function(){
        var event = execute( route = "/contacts/3559056000000", renderResults = true );
        var rc = event.getCollection();
        local.data = rc.cbox_render_data.data;
        local.content = rc.cbox_rendered_content;
        debug( rc );
        expect( rc.cbox_render_data.contentType ).toBe( 'application/json' );
        expect( local.data ).toBeTypeOf( 'struct' );
        expect( rc.cbox_statusCode ).toBe( 404, "The status code is not 404" );
        expect( structIsEmpty( local.data ) ).toBeTrue( "The result is not empty" );
        expect( isJSon( local.content ) ).toBeTrue();
      });

    });

	}

}
