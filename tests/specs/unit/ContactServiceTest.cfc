/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="root.models.services.ContactService"{

	/*********************************** LIFE CYCLE Methods ***********************************/

  this.loadColdbox = true;

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		// init the model object
		model.init();
		controller.getWirebox().autowire( model );
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

    describe( "getDataQuery() function", function(){

    	it( "Returns a query with top limit or records", function(){
        // Remove query cache
        cacheRemoveAll('query');
        // Test the function with 5 records limit
        local.result = model.getDataQuery( top = 5 );
        // Expect a query
        expect( local.result ).toBeTypeOf( "query", "Result is not a query" );
        expect( local.result.recordCount ).notToBe( 0, "Must return records" );

        for( var contact in local.result ){
          local.isParentNull = ( contact.parent == "" );
          if( !local.isParentNull ) break;
        }

        expect( local.isParentNull ).toBe( true );
      });

      it( "Returns a query", function(){
        // Remove query cache
        cacheRemoveAll('query');
        // Test the function with 5 records limit
        local.result = model.getDataQuery();
        // Expect a query
        expect( local.result ).toBeTypeOf( "query", "Result is not a query" );
        expect( local.result.recordCount ).notToBe( 0, "Must return records" );

        for( var contact in local.result ){
          local.isParentNull = ( contact.parent == "" );
          if( !local.isParentNull ) break;
        }

        expect( local.isParentNull ).toBe( true );
      });

    });


    describe( "get() function", function(){

      it( "Throws an error when de contacID is to large", function(){
        cacheRemoveAll('query');
        expect( function(){
        	local.result = model.get(3559056000000);
        }).toThrow();
      });

      it( "Returns an empty struct when the contact is not found", function(){
        cacheRemoveAll('query');
        local.result = model.get(6549);
        debug( local.result );
      });

      it( "Returns a Contact object", function(){
        cacheRemoveAll('query');
        local.result = model.get(3537793);
        expect( local.result ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
          replace( getMetaData( local.result ).name, 'root.', '' )
        ).toBe( 'models.Contact' );
      });

      it( "Returns a Contact as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( contactID = 3537793, asStruct = true );
        expect( local.result ).toBeTypeOf( "struct", "Result is not a Struct" );
      });

      it( "Returns an array of Contact objects", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = 5 );
        expect( local.result[1] ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
          replace( getMetaData( local.result[1] ).name, 'root.', '' )
        ).toBe( 'models.Contact' );
      });

      it( "Returns an array of Contacts as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = 5, asStruct = true );
        expect( local.result[1] ).toBeTypeOf( "struct", "Result is not a Struct" );
      });

    });

	}

}
