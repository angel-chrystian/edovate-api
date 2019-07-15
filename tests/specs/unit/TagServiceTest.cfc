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

      it( "Returns the default top tags related to the default Company as structure", function(){
        cacheRemoveAll('query');
        local.result = model.get( companyID = 3536615, asStruct = true );
        expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
        expect( local.result.len() ).NottoBe( 0 );
        expect( local.result[1] ).toBeTypeOf( 'struct', "Result is not a structure" );
        expect( local.result[1].id ).notToBe( "" );
        expect( local.result[1].name ).notToBe( "" );
      });

    });

    describe( "getDataQuery() function", function(){

    	it( "Throws an error when no tag[id], tag[name] or companyID is provided", function(){
        cacheRemoveAll('query');

        expect( function(){
        	local.result = model.getDataQuery();
        }).toThrow();
      });

      it( "Filters by tag[id]", function(){
        cacheRemoveAll('query');

        local.args["id"] = 1671;
        local.result = model.getDataQuery( argumentCollection = local.args );
        debug( local.result );
        expect( local.result.recordCount ).notToBe( 0 );
      });

      it( "Filters by tag[name]", function(){
        cacheRemoveAll('query');

        local.args["name"] = "Partnership: BJU Press";
        local.result = model.getDataQuery( argumentCollection = local.args );
        debug( local.result );
        expect( local.result.recordCount ).notToBe( 0 );
      });

    });

	}

}
