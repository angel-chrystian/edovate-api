/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="models.services.BaseService"{

	/*********************************** LIFE CYCLE Methods ***********************************/
  this.loadColdbox = true;
  variables.testHelper = new tests.resources.TestHelper();

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

		describe( "getCollections() function", function(){
			it( "Returns a list of the fields that are of type array", function(){
				makePublic( model, 'getCollections', 'getCollections2' );
				local.Instance = createObject( "component", "root.models.Company" );
				local.result = model.getCollections2( Instance );
				expect( local.result ).toBe( [ "tag" ] );
				expect( arrayLen( local.result ) ).toBe( 1 );
			});

			it( "Returns one resource created from the first row of a given query ", function(){
				local.testQry = testHelper.getCompanyQuery();
				model.setResourceName( "Company" );
				local.result = model.getResource(
					dataQry = local.testQry,
					asStruct = true
				);
			});

    });

	}



}
