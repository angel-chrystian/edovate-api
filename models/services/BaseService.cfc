/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/27/2019
 *	Base service that provides functions to transform queries into objects
 **/
component accessors="true" singleton="false"{

	// Properties
	property name="wirebox" inject="wirebox" hint="Injector object" ;
	property name="queryHelper" inject="QueryHelper@cbcommons" hint="Object to help in manipulation of queries";
	property name="orgID" type="numeric" default="8450" hint="orgID" ;
	property name="ResourceName" type="string" hint="Name of the component (Entity) to manipulate" ;

	/**
	 * Constructor
	 */
	any function init(){

		return this;
	}

 /**
 * Transforms the query in an array of structures
 * @dataQry   Query that will be marshalled
 * @asStruct  If true the result is a structure otherwise is an object
 * @isList    List of columns to exclude while populating from the query
 * @exclude   Row of the query to use when populating the resource
 * @offSet    The number of row that starts the results
 * @pageSize  The total number of rows to return
 * @return    If isList is true, the function returns an array otherwise it returns an object or struct depending on asStruct parameter
 **/
  public any function formatResult(
  	required query dataQry,
  	boolean asStruct = false,
  	boolean isList = true,
  	exclude = '',
  	numeric offSet = 1,
  	numeric pageSize = 20
  ){

  	if( !arguments.isList ){
  		// Return only one resource
  		return getResource( argumentCollection = arguments );
  	}else{
  		// Return an array of resources
  		local.result = [];

  		for( local.i = arguments.offSet; local.i <= arguments.pageSize; local.i++ ){

  			if( local.i > arguments.dataQry.recordCount ) break;

  			local.Resource = getResource(
  				dataQry = arguments.dataQry,
  				asStruct = arguments.asStruct,
  				exclude = arguments.exclude,
  				rowNumber = local.i
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
    // Get an instance of the Entity and populate it from the corresponding row in the query
    local.Resource = wirebox.getInstance( this.getResourceName() );
    populator.populateFromQuery(
      target = local.Resource,
      qry = arguments.dataQry,
      exclude = arguments.exclude,
      rowNumber = arguments.rowNumber
    );

    // Get the collection type field names
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
 * @Instance  Any object instance
 * @return    Array with the names of the properties of the object that are array (collections)
 **/
  private array function getCollections( required any Instance ){
    local.metaData = getMetaData( arguments.Instance );
    local.names = [];
    for( var item in local.metaData.properties ){
    	if( structKeyExists( item, 'type' ) && item.type == 'array' ) local.names.append( item.name );
    }

    return local.names;
  }

  /**
   * Runs after Dependency Injection has been completed, Injects the ObjectPopulator object
   **/
  function onDIComplete(){
  	// ObjectPopulator to populate objects from query
  	variables.populator = wirebox.getObjectPopulator();
  }

}