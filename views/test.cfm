<cfoutput>
<cftry>
<cfset orgID = 8450>

<div style="font-family: Gotham, 'Helvetica Neue', Helvetica, Arial, 'sans-serif'">

<h1>Get Parent Info</h1>
<cfquery name="getParent">
select

	en.pk_entityID as contact_id,
	onw.firstname as ownerFirstName,
	onw.lastname as ownerLastName,
	en.created as created_on,
	en.entityName as parent_name,
	enEm.EmailAddress as email,
	enPh.PhoneNumber as phone,
	ext2163.extFieldValue as blc_username,
	ext2164.extFieldValue as blc_password,
	er.pk_EntityRelationshipId

from mb_EntityRelationship er
	INNER JOIN mb_entity en ON en.pk_EntityId = er.fk_RelatedEntityId
	LEFT JOIN mb_entity onw ON onw.pk_entityID = en.CreatedBy
	LEFT JOIN mb_entityEmail enEm ON enEm.fk_entityID = en.pk_entityID and enEm.PrimaryEmail = 1
	LEFT JOIN mb_entityPhone enPh ON enPh.fk_entityID = en.pk_entityID and enPh.PrimaryPhone = 1
	LEFT JOIN mb_entityExtCustomFieldValues ext2163 ON ext2163.fk_entityID = en.pk_entityID and ext2163.fk_extfieldid = 2163
	LEFT JOIN mb_entityExtCustomFieldValues ext2164 ON ext2164.fk_entityID = en.pk_entityID and ext2164.fk_extfieldid = 2164

where er.fk_coid = <cfqueryparam value="#orgID#">
	and en.pk_entityID = <cfqueryparam value="3536615"><!---the parent contact ID--->
</cfquery>
<cfdump var="#getParent#">

<h1>Get Parent Tags</h1>
<cfquery name="getParentTags">
	select
		rt.RelationType as tagName,
		rt.pk_RelationTypeId as tagID

	from mb_EntityAccountTypeRelation atr
	INNER JOIN mb_EntityRelationship er ON er.pk_EntityRelationshipId = atr.fk_entityrelationshipID
	LEFT JOIN mb_relationtype rt ON rt.pk_RelationTypeId = atr.fk_relationtypeID
	where er.fk_coid = <cfqueryparam value="#orgID#">
	and er.fk_RelatedEntityId = <cfqueryparam value="3536615"><!---the parent contact ID--->
</cfquery>
<cfdump var="#getParentTags#">

<h1>Get Students of a Parent</h1>
<cfquery name="getStudents">
select

	en.pk_entityID as contact_id,
	onw.firstname as ownerFirstName,
	onw.lastname as ownerLastName,
	en.created as created_on,

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

where er.fk_coid = <cfqueryparam value="#orgID#">
	and erP.fk_RelatedEntityId = <cfqueryparam value="3536615"><!---the parent contact ID--->
</cfquery>
<cfdump var="#getStudents#">

<h1>Get Student Info</h1>
<cfquery name="getStudent">
select

	en.pk_entityID as contact_id,
	onw.firstname as ownerFirstName,
	onw.lastname as ownerLastName,
	en.created as created_on,
	en.entityname,

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

where er.fk_coid = <cfqueryparam value="#orgID#">
	and en.pk_entityID = <cfqueryparam value="3537793"><!---the student contact ID--->
</cfquery>
<cfdump var="#getStudent#">

<h1>Get Student Tags</h1>
<cfquery name="getStudentTags">
	select
		rt.RelationType as tagName,
		rt.pk_RelationTypeId as tagID

	from mb_EntityAccountTypeRelation atr
	INNER JOIN mb_EntityRelationship er ON er.pk_EntityRelationshipId = atr.fk_entityrelationshipID
	LEFT JOIN mb_relationtype rt ON rt.pk_RelationTypeId = atr.fk_relationtypeID
	where er.fk_coid = <cfqueryparam value="#orgID#">
	and er.fk_RelatedEntityId = <cfqueryparam value="3537793"><!---the student contact ID--->
</cfquery>
<cfdump var="#getParentTags#">

</div>
<cfcatch>
	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>
</cfoutput>