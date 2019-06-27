/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	I model the data layer for companies.
 **/
component accessors="true" singleton="true"{

	// Properties
	property name="wirebox" inject="wirebox";

	/**
	 * Constructor
	 */
	CompanyService function init(){

		return this;
	}

/**
 * Returns a Company by ID
 * @companyID ID of the company to retrieve
 * @asStruct  If true returns a struct otherwise an object of type Company
 **/
  public any function getCompany( required numeric companyID, asStruct = false ){
    local.Company = wirebox.getInstance( 'Company' );
    local.data = getDataQuery( companyID = arguments.companyID );
    if( local.data.recordCount ){
    	populator.populateFromQuery( local.Company, local.data );
    	if( arguments.asStruct ){
    		return local.Company.$renderData();
    	}else{
    		return local.Company;
    	}
    }
  }

/**
 * Returns an array of Companies
 * @asStruct  If true returns an array of structs otherwise an array of objects of type Company
 **/
  public array function getCompanies( asStruct = false, numeric top = 0 ){
    local.data = getDataQuery( top = arguments.top );
    local.result = [];
    if( local.data.recordCount ){
      for( var i = 1; i <= local.data.recordCount; i++ ){
      	local.Company = wirebox.getInstance( 'Company' );
      	populator.populateFromQuery( local.Company, local.data, i );
      	// Convert the object to struct in required
      	if( arguments.asStruct ) local.Company = local.Company.$renderData();
      	local.result.append( local.Company );
      }
    }
    return local.result;
  }

/**
 * Performs the query
 * @companyID If ommited the function returns all the companies otherwise the company corresponding to the companyID
 **/
  public query function getDataQuery( numeric orgID = 8450, companyID = "", top = 0 ){
    // Query parameters
    local.params = {
    	orgID = { value = arguments.orgID, cfsqltype="cf_sql_integer" }
    };

    // Limit the results
    local.top = "";
    if( arguments.top ){
    	local.top = " top #arguments.top# ";
    }

    // SQL construction
    savecontent variable="local.sql"{
    	writeoutput("
      	select #local.top# en.pk_entityID as id,
               onw.firstname as ownerFirstName,
               onw.lastname as ownerLastName,
               onw.lastName + ' ' + onw.firstName as owner,
               en.created as created,
               en.entityName as parent,
               enEm.EmailAddress as email,
               enPh.PhoneNumber as phone,
               ext2163.extFieldValue as blc_username,
               ext2164.extFieldValue as blc_password,
               er.pk_EntityRelationshipId as tag
        from mb_EntityRelationship er INNER JOIN mb_entity en ON en.pk_EntityId = er.fk_RelatedEntityId
                LEFT JOIN mb_entity onw ON onw.pk_entityID = en.CreatedBy
                LEFT JOIN mb_entityEmail enEm ON enEm.fk_entityID = en.pk_entityID and enEm.PrimaryEmail = 1
                LEFT JOIN mb_entityPhone enPh ON enPh.fk_entityID = en.pk_entityID and enPh.PrimaryPhone = 1
                LEFT JOIN mb_entityExtCustomFieldValues ext2163 ON ext2163.fk_entityID = en.pk_entityID and ext2163.fk_extfieldid = 2163
                LEFT JOIN mb_entityExtCustomFieldValues ext2164 ON ext2164.fk_entityID = en.pk_entityID and ext2164.fk_extfieldid = 2164
        where er.fk_coid = :orgID
    	");
    	// Add companyID if passed
    	if( isNumeric( arguments.companyID ) ){
    		writeoutput("
    		  and en.pk_entityID = :companyID
    		");
    		local.params.companyID = { value = arguments.companyID, cfsqltype = "cf_sql_integer" };
    	}
    }

    local.result = queryExecute( local.sql, local.params, { cachedWithin = createTimeSpan( 0, 0, 20, 0 ) } );
    return local.result;
  }

  // Runs after Dependency Injection has been completed
  function onDIComplete(){
  	variables.populator = wirebox.getObjectPopulator();
  }

}