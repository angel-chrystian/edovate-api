/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="models.Parent"{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		// init the model object
		model.init();
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "Parent Suite", function(){

			it( "Throws an error when assigning invalid data", function(){
				expect( function(){ model.setCreated_on( 'abcdd' ); } ).toThrow();
			});

			it( "Must have implicit getters and setters defined", function(){
        model.setType( 'company' );
        model.setPhone( '527773746926' );
        expect( model.getType() ).toBe( 'company' );
        expect( model.getPhone() ).toBe( '527773746926' );

      });

		});

	}

}
