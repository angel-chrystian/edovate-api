/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/21/2019
 *	I model a Company.
 **/
component accessors="true"{

	// Properties
	property name="id" type="string" default="" hint="Id of the company"  ;
	property name="type" type="string" default="" hint="Value is company";
	property name="owner" type="string"  default="" hint="The contact owner";
	property name="created" type="date" hint="The time the company was added to Edovate";
	property name="parent" type="string" hint="The company name";
  property name="email" type="string" hint="Primary email";
  property name="phone" type="string" hint="Primary phone";
  property name="blc_username" type="string" hint="BLC Username (ext_field_2163)";
  property name="blc_password" type="string" hint="BLC Password (ext_field_2164)";
	property name="tag" type="string" hint="The contact tags representing the contact";

	/**
	 * Constructor
	 */
	Company function init(){

		return this;
	}

/**
 * Returns a structure representation of the object
 **/
  public struct function $renderData(){

    return {
    	id = getId(),
    	type = getType(),
    	owner = getOwner(),
    	created = getCreated(),
    	parent = getParent(),
    	email = getEmail(),
    	phone = getPhone(),
    	blc_username = getBlc_username(),
    	blc_password = getBlc_password(),
    	tag = getTag()
    };
  }

}