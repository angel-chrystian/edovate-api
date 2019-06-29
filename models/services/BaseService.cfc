/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	I model the data layer for companies.
 **/
component accessors="true" singleton="true"{

	// Properties
	property name="wirebox" inject="wirebox";
	property name="queryHelper" inject="QueryHelper@cbcommons";
	property name="orgID" type="numeric" default="8450";
	property name="ResourceName" type="string";

	/**
	 * Constructor
	 */
	any function init(){

		return this;
	}

/**
 * Returns a Resource by ID
 * @companyID ID of the company to retrieve if it is -1 or omitted, returns all the records limited but "top" argument
 * @asStruct  If true returns a struct otherwise an object of type Company
 * @top       Greater than 0 limits the query to the number if 0, returns all the records
 **/
  public any function formatResult(
  	required query dataQry,
  	boolean asStruct = false,
  	boolean isList = true,
  	exclude = ''
  ){

  	if( !arguments.isList ){
  		return getResource( argumentCollection = arguments );
  	}else{
  		local.result = [];
  		for( var row in arguments.dataQry ){
  			local.Resource = getResource(
  				dataQry = arguments.dataQry,
  				asStruct = arguments.asStruct,
  				exclude = arguments.exclude,
  				rowNumber = arguments.dataQry.currentRow
  			);
  			local.result.append( local.Resource );
  		}
  		return local.result;
  	}

  }

/**
 * Returns one Resource, as object or struct
 * @dataQry   Query that will be marshalled
 * @asStruct  If true the result is a structure otherwise is an object
 * @exclude   List of columns to exclude while populating from the query
 * @rowNumber Row of the query to use when populating the resource
 **/
  public any function getResource(
  	required query dataQry,
  	boolean asStruct = false,
  	exclude = '',
  	numeric rowNumber = 1
  ){

    local.Resource = wirebox.getInstance( this.getResourceName() );
    populator.populateFromQuery(
      target = local.Resource,
      qry = arguments.dataQry,
      exclude = arguments.exclude,
      rowNumber = arguments.rowNumber
    );

    // Get the collection fields
    local.collectionNames = getCollections( local.Resource );

    if( arguments.asStruct ){
    	local.result = local.Resource.$renderData();
    	// Populate all the collections
      for( var field in local.collectionNames ){
        local.result[ field ] = invoke( local.Resource, 'get#field#', { asStruct = true });
      }
      // return a struct
      return local.result;
    }else{
      // Return an object
      return local.Resource;
    }
  }


/**
 * Returns an array of fields that are collections
 **/
  private array function getCollections( required any Instance ){
    local.metaData = getMetaData( arguments.Instance );
    local.names = [];
    for( var item in local.metaData.properties ){
    	if( structKeyExists( item, 'type' ) && item.type == 'array' ) local.names.append( item.name );
    }

    return local.names;
  }

  // Runs after Dependency Injection has been completed
  function onDIComplete(){
  	variables.populator = wirebox.getObjectPopulator();
  }

}