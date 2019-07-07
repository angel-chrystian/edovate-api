/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	I model the data layer for companies.
 **/
component extends="BaseService"  accessors="true" singleton="true"{

	// Properties
	property name="wirebox" inject="wirebox";
	property name="orgID" type="numeric" default="8450";

	/**
	 * Constructor
	 */
	ContactService function init(){
    this.setResourceName( 'Contact' );
		return this;
	}

/**
 * Returns a Resource by ID
 * @contactID ID of the contact to retrieve if it is -1 or omitted, returns all the records limited but "top" argument
 * @asStruct  If true returns a struct otherwise an object of type Contact
 * @top       Greater than 0 limits the query to the number if 0, returns all the records
 **/
  public any function get(
    numeric contactID = -1,
    boolean asStruct = false,
    numeric top = 0
  ){
  	// If contactID is gt 0 then a list is requested
  	local.isList = arguments.contactID <= 0;
  	// Set the limit of rows to return
    local.args = { top = arguments.top };

    // Return one contact only
    if( arguments.contactID > 0 ) local.args.contactID = arguments.contactID;

    // Execute the query
    local.data = getDataQuery( argumentCollection = local.args );

    // If not a list and no records return an empty struct
    if( !local.isList && local.data.recordCount == 0 ) return {};

    // Format the result
    local.result = super.formatResult( local.data, arguments.asStruct, local.isList );
    return local.result;
  }

/**
 * Performs the query
 * @contactID If ommited the function returns all the companies otherwise the contact corresponding to the contactID
 * @orgID     Organization ID of the contac(s) to retrieve
 * @top       Greater than 0 limits the query to the number if 0, returns all the records
 **/
  public query function getDataQuery(
  	numeric contactID = -1,
  	numeric orgID = this.getOrgID(),
  	numeric top = 0
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
        select #local.top#

          en.pk_entityID as contact_id,
          onw.firstname as ownerFirstName,
          onw.lastname as ownerLastName,
          en.created as created_on,
          en.entityname as parent,

          erP.fk_RelatedEntityId as parent_id,
          en.firstName as first_name,
          en.lastName as last_name,
          enEm.EmailAddress as email,
          ext2163.extFieldValue as blc_username,
          ext2164.extFieldValue as blc_password,

          ext2280.extFieldValue as azure_id,
          ext2278.extFieldValue as azure_username,
          ext1872.extFieldValue as lsa_learning_style,
          ext1871.extFieldValue as lsa_personality_style,

          ext2111.extFieldValue as enroll_start_date,
          ext2114.extFieldValue as enroll_final_due_date,
          ext1969.extFieldValue as student_status


        from mb_EntityRelationship er
          INNER JOIN mb_entity en ON en.pk_EntityId = er.fk_RelatedEntityId
          LEFT JOIN mb_EntityEntityRelationship EER ON EER.fk_relatedEntityRelationshipId = er.pk_EntityRelationshipId
          LEFT JOIN mb_EntityRelationship erP ON erP.pk_EntityRelationshipId = EER.fk_EntityRelationshipId

          LEFT JOIN mb_entity onw ON onw.pk_entityID = en.CreatedBy
          LEFT JOIN mb_entityEmail enEm ON enEm.fk_entityID = en.pk_entityID and enEm.PrimaryEmail = 1
          LEFT JOIN mb_entityExtCustomFieldValues ext2163 ON ext2163.fk_entityID = en.pk_entityID and ext2163.fk_extfieldid = 2163
          LEFT JOIN mb_entityExtCustomFieldValues ext2164 ON ext2164.fk_entityID = en.pk_entityID and ext2164.fk_extfieldid = 2164
          LEFT JOIN mb_entityExtCustomFieldValues ext2280 ON ext2280.fk_entityID = en.pk_entityID and ext2280.fk_extfieldid = 2280
          LEFT JOIN mb_entityExtCustomFieldValues ext2278 ON ext2278.fk_entityID = en.pk_entityID and ext2278.fk_extfieldid = 2278
          LEFT JOIN mb_entityExtCustomFieldValues ext1872 ON ext1872.fk_entityID = en.pk_entityID and ext1872.fk_extfieldid = 1872
          LEFT JOIN mb_entityExtCustomFieldValues ext1871 ON ext1871.fk_entityID = en.pk_entityID and ext1871.fk_extfieldid = 1871
          LEFT JOIN mb_entityExtCustomFieldValues ext2111 ON ext2111.fk_entityID = en.pk_entityID and ext2111.fk_extfieldid = 2111
          LEFT JOIN mb_entityExtCustomFieldValues ext2114 ON ext2114.fk_entityID = en.pk_entityID and ext2114.fk_extfieldid = 2114
          LEFT JOIN mb_entityExtCustomFieldValues ext1969 ON ext1969.fk_entityID = en.pk_entityID and ext1969.fk_extfieldid = 1969
        where er.fk_coid = :orgID and en.entityname is null
    	");
    	// Add contactID if passed
    	if( arguments.contactID > 0 ){
    		writeoutput("
    		  and en.pk_entityID = :contactID
    		");
    		local.params.contactID = { value = arguments.contactID, cfsqltype = "cf_sql_integer" };
    	}
    }
    local.result = queryExecute( local.sql, local.params, { cachedWithin = createTimeSpan( 0, 0, 20, 0 ) } );

    return local.result;
  }

}