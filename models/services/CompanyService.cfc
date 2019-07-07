/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	I model the data layer for companies.
 **/
component extends="BaseService"  accessors="true" singleton="true"{

	/**
	 * Constructor
	 */
	CompanyService function init(){
    // Configure BaseService to use Company as the resource
    this.setResourceName( 'Company' );
		return this;
	}

/**
 * Returns a Resource by ID
 * @companyID ID of the company to retrieve if it is -1 or omitted, returns all the records limited but "top" argument
 * @asStruct  If true returns a struct otherwise an object of type Company
 * @top       Greater than 0 limits the query to the number if 0, returns all the records
 **/
  public any function get(
    numeric companyID = -1,
    boolean asStruct = false,
    numeric top = 0
  ){
  	// companyID greater than 0 returns a list
  	local.isList = arguments.companyID <= 0;

    // Set the query arguments
    local.args = { top = arguments.top };
    if( arguments.companyID > 0 ) local.args.companyID = arguments.companyID;

    // Run the query
    local.data = getDataQuery( argumentCollection = local.args );

    // Format the result
    local.result = super.formatResult( local.data, arguments.asStruct, local.isList );
    return local.result;
  }

/**
 * Performs the query that retrieves the companies
 * @orgID     The organization ID for the moment it defaults to 8450
 * @companyID If ommited or less than zero, the function returns all the companies otherwise the company corresponding to the companyID
 * @top       The number of rows to return if 0 returns all the rows
 **/
  public query function getDataQuery(
  	numeric orgID = this.getOrgID(),
  	companyID = -1,
  	top = 0
  ){
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
               er.pk_EntityRelationshipId
        from mb_EntityRelationship er INNER JOIN mb_entity en ON en.pk_EntityId = er.fk_RelatedEntityId
                LEFT JOIN mb_entity onw ON onw.pk_entityID = en.CreatedBy
                LEFT JOIN mb_entityEmail enEm ON enEm.fk_entityID = en.pk_entityID and enEm.PrimaryEmail = 1
                LEFT JOIN mb_entityPhone enPh ON enPh.fk_entityID = en.pk_entityID and enPh.PrimaryPhone = 1
                LEFT JOIN mb_entityExtCustomFieldValues ext2163 ON ext2163.fk_entityID = en.pk_entityID and ext2163.fk_extfieldid = 2163
                LEFT JOIN mb_entityExtCustomFieldValues ext2164 ON ext2164.fk_entityID = en.pk_entityID and ext2164.fk_extfieldid = 2164
        where er.fk_coid = :orgID and
                en.entityname is not null and en.entityname != ''
    	");
    	// Add companyID if passed
    	if( arguments.companyID > 0 ){
    		writeoutput("
    		  and en.pk_entityID = :companyID
    		");
    		local.params.companyID = { value = arguments.companyID, cfsqltype = "cf_sql_integer" };
    	}
    }

    local.result = queryExecute( local.sql, local.params, { cachedWithin = createTimeSpan( 0, 0, 20, 0 ) } );
    return local.result;
  }

}