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

		describe( "getCompany() function", function(){
			it( "Returns a Company object when asStruct is false", function(){
				local.result = model.getCompany( 3536615 );
				expect( local.result ).toBeTypeOf( "component", "Result is not a component" );
				expect( getMetaData( local.result ).name ).toBe( 'models.Company', "Result is not type Company" );
			});

			it( "Returns a Struct when asStruct is true", function(){
        local.result = model.getCompany( 3536615, true );
        expect( local.result ).toBeTypeOf( "struct", "Result is not a struct" );
        expect( structIsEmpty( local.result ) ).toBeFalse();
      });

		});

		describe( "getCompanies() function", function(){
      it( "Returns an array of Company objects when asStruct is false", function(){
        local.result = model.getCompanies( top = 2 );
        debug( local.result );
        expect( local.result ).toBeTypeOf( "array", "Result is not an array" );
        expect( local.result[1] ).toBeTypeOf( "component", "Result is not an array" );
        expect( getMetaData( local.result[1] ).name ).toBe( 'models.Company', "Result is not type Company" );
      });

      it( "Returns a Struct when asStruct is true", function(){
        local.result = model.getCompanies( asStruct = true, top = 2 );
        debug( local.result );
        expect( local.result[1] ).toBeTypeOf( "struct", "Result is not a struct" );
        expect( structIsEmpty( local.result[1] ) ).toBeFalse();
      });

    });

	}

}
