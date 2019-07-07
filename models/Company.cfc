/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/21/2019
 *	I model a Company.
 **/
component accessors="true"{
  property name="wirebox" inject="wirebox" setter="false" ;
  property name="tagService" inject="services.TagService";

	// Properties
	property name="id" type="string" default="" hint="Id of the company"  ;
	property name="type" type="string" default="company" hint="Value is 'company'" setter="false" ;
	property name="owner" type="string"  default="" hint="The contact owner";
	property name="created" type="date" hint="The time the company was added to Edovate";
	property name="parent" type="string" hint="The company name";
  property name="email" type="string" hint="Primary email";
  property name="phone" type="string" hint="Primary phone";
  property name="blc_username" type="string" hint="BLC Username (ext_field_2163)";
  property name="blc_password" type="string" hint="BLC Password (ext_field_2164)";
	property name="tag" type="array" hint="Collection of tags";

	variables.tagsLoaded = false;

  // Validation constraints
  this.constraints = {
    first_name = { required = true, requiredMessage = "First Name is required for a contact" }
  };

	/**
	 * Constructor
	 * @return Company instance
	 */
	Company function init(){
    variables.tag = [];
		return this;
	}

/**
 * Returns an array of Tags related to the company
 * @asStruct  Flag if true returns an Object otherwise returns a struct
 * @top       Number of rows to return
 **/
  public array function getTag( boolean asStruct = false, numeric top = 0 ){
    if( variables.tagsLoaded ){
    	return variables.tag;
    }else{
      if( this.getID() != '' ){
        arrayClear( variables.tag );
        local.tagQuery = tagService.getDataQuery( this.getID() );
        for( var row in local.tagQuery ){
          local.Resource = tagService.getResource(
          	dataQry = local.tagQuery,
          	asStruct = arguments.asStruct,
          	rowNumber = local.tagQuery.currentRow
          );
          variables.tag.append( local.Resource );
        }
      }
      return variables.tag;
    }
  }

/**
 * Returns a structure representation of the object
 **/
  public struct function $renderData(){
    local.result = {
    	id = getId(),
    	type = getType(),
    	owner = getOwner(),
    	created = getCreated(),
    	parent = getParent(),
    	email = getEmail(),
    	phone = getPhone(),
    	blc_username = getBlc_username(),
    	blc_password = getBlc_password(),
    	tag = variables.tag
    };
    return local.result;
  }

}