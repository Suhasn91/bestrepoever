<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata"><fieldUpdates>
        <fullName>Update_Account_Owner_Text</fullName>
        <field>Account_Owner_Text__c</field>
        <formula>Account_Owner_Formula__c</formula>
        <name>Update Account Owner Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates><rules>
        <fullName>Check Opportunity</fullName>
        <actions>
            <name>Update_Account_Owner_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(  AccountId   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules></Workflow>