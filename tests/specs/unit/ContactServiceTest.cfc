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

    	it( "Returns a query", function(){
        cacheRemoveAll('query');
        local.result = model.getDataQuery(3537793);
        expect( local.result ).toBeTypeOf( "query", "Result is not a Query" );
        expect( local.result.recordCount ).toBe( 1 );
      });

    });


    describe( "get() function", function(){

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
