({
    addEmail : function(component, event, helper) {
        var existingEmailList = component.get("v.EmailRecordWrapper");
        var wrap = {
            'sobjectType' : 'Contact_Email__c',
            'Email__c' : '',
            'Email_Type__c' : ''
        };
        existingEmailList.push(wrap);
        component.set("v.EmailRecordWrapper", existingEmailList);
    },
    handleRemoveEmailDetails : function(component, event, helper) {
        var indexToRemove = event.getParam("index");
        var existingEmailList = component.get("v.EmailRecordWrapper");
        var existingEmailDeleteList = component.get("v.emailRecordsDelete");
        if(component.get("v.EmailRecordWrapper["+indexToRemove+"].Id") != undefined)
        {
            existingEmailDeleteList.push(component.get("v.EmailRecordWrapper["+indexToRemove+"].Id"));
            component.set("v.emailRecordsDelete", existingEmailDeleteList);
        }
        existingEmailList.splice(indexToRemove,1);
        component.set("v.EmailRecordWrapper", existingEmailList);
    },
    submitClose : function(component, event, helper) {
        var cmpEvent = $A.get("e.c:EmailChildRecordsList");
        cmpEvent.setParams({
            "emailRecordsList" : component.get("v.EmailRecordWrapper"),
            "index" : component.get("v.index"),
            "emailRecordsDelete" : component.get("v.emailRecordsDelete")
        });
        cmpEvent.fire();
        component.find("popUpCompId").notifyClose();
    }
})