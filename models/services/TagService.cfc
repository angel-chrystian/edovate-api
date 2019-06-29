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
  	required numeric companyID,
  	boolean asStruct = false,
  	numeric top = 0
  ){
    local.args = { top = arguments.top };
    if( arguments.companyID > 0 ) local.args.companyID = arguments.companyID;
    local.data = getDataQuery( argumentCollection = local.args );
    local.result = super.formatResult( local.data, arguments.asStruct );
    return local.result;
  }

/**
 * Performs the query
 * @companyID If ommited the function returns all the companies otherwise the company corresponding to the companyID
 **/
  public query function getDataQuery( required numeric companyID, numeric orgID = this.getOrgID(), numeric top = 0 ){
    // Query parameters
    local.params = {
      orgID = { value = arguments.orgID, cfsqltype="cf_sql_integer" },
      companyID = { value = arguments.companyID, cfsqltype="cf_sql_integer" }
    };

    // SQL construction
    savecontent variable="local.sql"{
      writeoutput("
        select
          rt.RelationType as name,
          rt.pk_RelationTypeId as id
        from mb_EntityAccountTypeRelation atr
        INNER JOIN mb_EntityRelationship er ON er.pk_EntityRelationshipId = atr.fk_entityrelationshipID
        LEFT JOIN mb_relationtype rt ON rt.pk_RelationTypeId = atr.fk_relationtypeID
        where er.fk_coid = :orgID
        and er.fk_RelatedEntityId = :companyID;
      ");
    }

    local.qryOptions = { cachedWithin = createTimeSpan( 0, 0, 20, 0 ) };
    if( arguments.top > 0 ){
    	local.qryOptions.maxRows = arguments.top;
    }

    local.result = queryExecute( local.sql, local.params, local.qryOptions );

    return local.result;
  }

}