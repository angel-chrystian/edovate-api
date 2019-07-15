/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	I model the data layer for companies.
 **/
component extends="BaseService"  accessors="true" singleton="true"{

	/**
	 * Constructor
	 */
	TagService function init(){
    this.setResourceName( 'Tag' );
		return this;
	}

/**
 * Returns a Resource by ID
 * @companyID ID of the company to retrieve if it is -1 or omitted, returns all the records limited but "top" argument
 * @asStruct  If true returns a struct otherwise an object of type Company
 * @top       Greater than 0 limits the query to the number if 0, returns all the records
 **/
  public any function get(
  	numeric companyID,
  	boolean asStruct = false,
  	numeric top = 0
  ){
    local.args = {};
    structAppend( local.args, arguments );
    local.data = getDataQuery( argumentCollection = local.args );
    local.result = super.formatResult( local.data, arguments.asStruct );
    return local.result;
  }

/**
 * Performs the query
 * @companyID If ommited the function returns all the companies otherwise the company corresponding to the companyID
 **/
  public query function getDataQuery(
  	numeric companyID = 0,
  	numeric id = 0,
  	string name = "",
  	numeric orgID = this.getOrgID(),
  	numeric top = 0
  ){

  	if( arguments.companyID == 0 && arguments.id == 0 && arguments.name == "" ){
  		throw( 'Must provide companyID or id or name to proceed with the search' );
  	}

    // Query parameters
    local.params = {
      orgID = { value = arguments.orgID, cfsqltype="cf_sql_integer" }
    };

    // SQL construction
    savecontent variable="local.sql"{
      writeoutput("
        select
          rt.RelationType as name,
          rt.pk_RelationTypeId as id,
          er.fk_RelatedEntityId as companyID
        from mb_EntityAccountTypeRelation atr
        INNER JOIN mb_EntityRelationship er ON er.pk_EntityRelationshipId = atr.fk_entityrelationshipID
        LEFT JOIN mb_relationtype rt ON rt.pk_RelationTypeId = atr.fk_relationtypeID
        where er.fk_coid = :orgID
      ");

      // Filter on companyID
      if( arguments.companyID ){
      	writeoutput("
      	 and er.fk_RelatedEntityId = :companyID;
      	");
      	local.params.companyID = { value = arguments.companyID, cfsqltype="cf_sql_integer" };
      }

      // Filter on ID
      if( arguments.id ){
        writeoutput("
         and rt.pk_RelationTypeId = :ID;
        ");
        local.params.ID = { value = arguments.ID, cfsqltype="cf_sql_integer" };
      }

      // Filter on name
      if( len( arguments.name ) ){
        writeoutput("
         and rt.RelationType = :name;
        ");
        local.params.name = { value = arguments.name, cfsqltype="cf_sql_varchar" };
      }

    }

    local.qryOptions = { cachedWithin = createTimeSpan( 0, 0, 20, 0 ) };
    if( arguments.top > 0 ){
    	local.qryOptions.maxRows = arguments.top;
    }

    local.result = queryExecute( local.sql, local.params, local.qryOptions );

    return local.result;
  }

}