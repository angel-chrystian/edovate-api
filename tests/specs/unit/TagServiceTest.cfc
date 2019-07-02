/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="root.models.services.TagService"{

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
			it( "Returns 35 object tags related to the default Company", function(){
				cacheRemoveAll('query');
				local.result = model.get(3536615);
				expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
				expect( local.result.len() ).toBe( 35 );
				expect( local.result[1] ).toBeTypeOf( 'component', "Result is not a structure" );
				expect( local.result[1].getId() ).notToBe( "" );
				expect( local.result[1].getName() ).notToBe( "" );
			});

			it( "Returns N top object tags related to the default Company", function(){
        cacheRemoveAll('query');
        local.top = 6;
        local.result = model.get( companyID = 3536615, top = local.top );
        expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
        expect( local.result.len() ).toBe( local.top );
        expect( local.result[1] ).toBeTypeOf( 'component', "Result is not a structure" );
        expect( local.result[1].getId() ).notToBe( "" );
        expect( local.result[1].getName() ).notToBe( "" );
      });

      it( "Returns 35 tags related to the default Company as structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( companyID = 3536615, asStruct = true);
        expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
        expect( local.result.len() ).toBe( 35 );
        expect( local.result[1] ).toBeTypeOf( 'struct', "Result is not a structure" );
        expect( local.result[1].id ).notToBe( "" );
        expect( local.result[1].name ).notToBe( "" );
      });

      it( "Returns N top tags related to the default Company as structure", function(){
        cacheRemoveAll('query');
        local.top = 6;
        local.result = model.get( companyID = 3536615, top = local.top, asStruct = true );
        expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
        expect( local.result.len() ).toBe( local.top );
        expect( local.result[1] ).toBeTypeOf( 'struct', "Result is not a structure" );
        expect( local.result[1].id ).notToBe( "" );
        expect( local.result[1].name ).notToBe( "" );
      });

    });

	}

}
