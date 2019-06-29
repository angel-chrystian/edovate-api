/**
 *	Author: Angel Chrystian Torres
 *	Date: 6/21/2019
 *	I model a Tag that will be a collection of Company.
 **/
component accessors="true"{

	// Properties
	property name="id" type="string" default="" hint="Id of the Tag";
	property name="name" type="string" hint="The name of the Tag";

	/**
	 * Constructor
	 */
	Tag function init(){

		return this;
	}

/**
 * Returns a structure representation of the object
 **/
  public struct function $renderData(){

    return {
    	id = getId(),
    	name = getName()
    };
  }

}