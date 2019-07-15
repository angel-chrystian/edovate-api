/**
 *	Author: Angel Chrystian Torres
 *	Date: 7/1/2019
 *	I model a Contact.
 **/
component accessors="true"{

	// Properties
  property name="contact_id" type="string" default="" hint="Id of the contact"  ;
  property name="type" type="string" default="contact" hint="Value is 'contact'" setter="false" ;
  property name="owner" type="string"  default="" hint="The contact owner";
  property name="created_on" type="string" hint="The time the contact was added to Edovate";
  property name="parent_id" type="string" hint="The entity id of the parent's relationship";
  property name="first_name" type="string" default=""  hint="First name of the contact";
  property name="last_name" type="string" default=""  hint="Last name of the contact";
  property name="email" type="string" default="" hint="Primary email";
  property name="phone" type="string" default="" hint="Primary phone";
  property name="blc_username" type="string" default="" hint="BLC Username (ext_field_2163)";
  property name="blc_password" type="string" default="" hint="BLC Password (ext_field_2164)";
  property name="azure_id" type="string" default="" hint="Azure ID (ext_field_2280)";
  property name="azure_name" type="string" default="" hint="Azure Username (ext_field_2278)";
  property name="lsa_learning_style" type="string" default="" hint="LSA learning style (ext_field_1872)";
  property name="lsa_personality_style" type="string" default="" hint="LSA personality style (ext_field_1871)";
  property name="contact_tag" type="integer" default="" hint="The contact tags representing the contact";
  property name="enroll_start_date" type="string" default=""  hint="The current enrollment start date (ext_field_2111)";
  property name="enroll_final_due_date" type="string" default="" hint="The current enrollment final due date (ext_field_2114)";
  property name="student_status" type="string" default="" hint="The current enrollment status of the student (ext_field_1969)";
  property name="billing_status" type="string" default="" hint="The current payment status of this student (current, past due, etc)";

	/**
	 * Constructor
	 */
	Contact function init(){

		return this;
	}

  // Validation constraints
  this.constraints = {
  	first_name = { required = true, requiredMessage = "First Name is required for a contact" }
  };

/**
 * Returns a structure representation of the object if an instance of this object is returned in a handler
 * this function will be implicitly invoked to return this object data in a specific format.
 * @return Contact in a struct format
 **/
  public struct function $renderData(){
    local.result = {
      id = getcontact_Id(),
      type = getType(),
      owner = getOwner(),
      created = getCreated_on(),
      parent = getParent_id(),
      first_name = getFirst_name(),
      last_name = getLast_name(),
      email = getEmail(),
      phone = getPhone(),
      blc_username = getBlc_username(),
      blc_password = getBlc_password(),
      azure_id = getAzure_id(),
      azure_name = getAzure_name(),
      lsa_learning_style = getlsa_learning_style(),
      lsa_personality_style = getlsa_personality_style(),
      contact_tag = getcontact_tag(),
      enroll_start_date = getenroll_start_date(),
      enroll_final_due_date = getenroll_final_due_date(),
      student_status = getstudent_status(),
      billing_status = getbilling_status()
    };
    return local.result;
  }

}