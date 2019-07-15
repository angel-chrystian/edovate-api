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

      it( "Returns a query of companies limited to a list of company id", function(){
        cacheRemoveAll('query');
        local.result = model.getDataQuery( companyIDList = '3536615,1726782,1726831' );
        expect( local.result ).toBeTypeOf( "query", "Result is not a Struct" );
        expect( local.result.recordCount ).toBe( 3 );
        expect( local.result.parent[1] ).notToBeEmpty();
      });

      it( "Returns a query of companies filtered by tag[id]", function(){
        cacheRemoveAll('query');
        local.args["tag[id]"] = 1671;
        local.result = model.getDataQuery( argumentCollection = local.args );
        expect( local.result.recordCount ).NottoBe( 0 );
      });

      it( "Returns a query of companies filtered by tag[name]", function(){
        cacheRemoveAll('query');
        local.args["tag[name]"] = 'Partnership: BJU Press';
        local.result = model.getDataQuery( argumentCollection = local.args );
        expect( local.result.recordCount ).NottoBe( 0 );
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

      it( "Returns an array of Company objects with pagination", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( offset = 1, pageSize = 3 );
        expect( local.result.len() ).toBe( 3 );
      });

      it( "Filter the company by email", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( email = 'jsoto@gcasps.org' );
        for( local.row in local.result ){
        	expect( local.row.getEmail() ).toBe( 'jsoto@gcasps.org' );
        }
        expect( local.result.len() ).notToBe( 0 );

      });

      it( "Filter the company by type", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( type = 'jsoto@gcasps.org' );
        for( local.row in local.result ){
          expect( local.row.getEmail() ).toBe( 'jsoto@gcasps.org' );
        }
        expect( local.result.len() ).notToBe( 0 );

      });

      it( "Filter the company by owner", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( owner = 'Farrell Brenda' );
        for( local.row in local.result ){
          expect( local.row.getOwner() ).toBe( 'Farrell Brenda' );
        }
        expect( local.result.len() ).notToBe( 0 );

      });

      it( "Filter the company by parent", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( parent = 'Great Commission Academy' );
        for( local.row in local.result ){
          expect( local.row.getParent() ).toBe( 'Great Commission Academy' );
        }
        expect( local.result.len() ).notToBe( 0 );

      });

      it( "Filter the company by phone", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( phone = '504-551-5189' );
        for( local.row in local.result ){
          expect( local.row.getPhone() ).toBe( '504-551-5189' );
        }
        expect( local.result.len() ).notToBe( 0 );

      });

      it( "Filter the company by blc_username", function(){
        // Pagination
        cacheRemoveAll('query');
        local.result = model.get( blc_username = 'nicoleanderson2' );
        for( local.row in local.result ){
          expect( local.row.getBlc_username() ).toBe( 'nicoleanderson2' );
        }
        expect( local.result.len() ).notToBe( 0 );

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
