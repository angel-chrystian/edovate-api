/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="root.models.services.CompanyService"{

	/*********************************** LIFE CYCLE Methods ***********************************/
  this.loadColdbox = true;

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		// init the model object
		model.init();
		controller.getWirebox().autowire( model );

		// Global variables
		variables.top = 10;
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

    describe( "getDataQuery() function", function(){

      it( "Returns a query of companies", function(){
        cacheRemoveAll('query');
        local.result = model.getDataQuery( top = variables.top );
        expect( local.result ).toBeTypeOf( "query", "Result is not a Struct" );
        local.isParentNull = false;
        for( var company in local.result ){
          local.isParentNull = ( company.parent == "" );
          if( local.isParentNull ) break;
        }
        expect( local.isParentNull ).toBe( false );
      });

      it( "Returns a query of companies limited to the company id", function(){
        cacheRemoveAll('query');
        local.result = model.getDataQuery( companyID = 3536615 );
        expect( local.result ).toBeTypeOf( "query", "Result is not a Struct" );
        expect( local.result.recordCount ).toBe( 1 );
        expect( local.result.parent[1] ).notToBeEmpty();
      });

    });

    describe( "get() function", function(){

      it( "Returns a Company object", function(){
        cacheRemoveAll('query');
        local.result = model.get(3536615);
        expect( local.result ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
        	replace( getMetaData( local.result ).name, 'root.', '' )
        ).toBe( 'models.Company' );
        expect( local.result.getParent() ).notToBe( '' );
      });

      it( "Returns a Company as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( companyID = 3536615, asStruct = true );
        expect( local.result ).toBeTypeOf( "struct", "Result is not a Struct" );
        expect( local.result.parent ).notToBe( '' );
      });

      it( "Returns an array of Company objects", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = variables.top );
        expect( local.result[1] ).toBeTypeOf( "component", "Result is not a Component" );
        expect(
          replace( getMetaData( local.result[1] ).name, 'root.', '' )
        ).toBe( 'models.Company' );

        for( var Company in local.result ){
        	local.isParentNull = ( Company.getParent() == "" );
        	if( local.isParentNull ) break;
        }
        expect( local.isParentNull ).toBeFalse();
      });

      it( "Returns an array of Company as a structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( top = variables.top, asStruct = true );
        expect( local.result[1] ).toBeTypeOf( "struct", "Result is not a Struct" );
        for( var company in local.result ){
          local.isParentNull = ( company.parent == "" );
          if( local.isParentNull ) break;
        }
        expect( local.isParentNull ).toBeFalse();
      });

    });

	}

}
