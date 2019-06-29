/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="models.services.CompanyService"{

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

    describe( "get() function", function(){
      it( "Returns a Company object", function(){
        cacheRemoveAll('query');
        local.result = model.get(3536615);
        expect( local.result ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
        	replace( getMetaData( local.result ).name, 'root.', '' )
        ).toBe( 'models.Company' );
      });

      it( "Returns a Company as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( companyID = 3536615, asStruct = true );
        expect( local.result ).toBeTypeOf( "struct", "Result is not a Struct" );
      });

      it( "Returns an array of Company objects", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = 5 );
        expect( local.result[1] ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
          replace( getMetaData( local.result[1] ).name, 'root.', '' )
        ).toBe( 'models.Company' );
      });

      it( "Returns an array of Company as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = 5, asStruct = true );
        expect( local.result[1] ).toBeTypeOf( "struct", "Result is not a Struct" );
      });

    });

	}

}
