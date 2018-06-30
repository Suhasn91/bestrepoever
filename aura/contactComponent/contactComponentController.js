({
    showEmailDetails : function(component, event, helper) {
        var modalBody;
        $A.createComponent("c:ContactEmailComponent", { EmailRecordWrapper : component.get("v.contactRecordWrapper.mailObjectList"), index : component.get("v.index")},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   component.find('popupCompId').showCustomModal({
                                       header: "Contact Email Details",
                                       body: modalBody, 
                                       showCloseButton: true
                                   })
                               }
                           });
    },
    handleRemoveContact : function(component, event, helper) {
        var cmpEvent = component.getEvent("getContactRecordToRemove");
        cmpEvent.setParams({
            "index" : component.get("v.index")});
        cmpEvent.fire();
    },
    handleSubmitEmailRecordsList : function(component, event, helper) {
        if(component.get("v.index") == event.getParam("index"))
        {
            component.set("v.contactRecordWrapper.mailObjectList", event.getParam("emailRecordsList"));
            var completeEmailDeleteList = component.get("v.emailRecordsDelete").concat(event.getParam("emailRecordsDelete"));
        	component.set("v.emailRecordsDelete",completeEmailDeleteList);
            alert(JSON.stringify(component.get("v.emailRecordsDelete")));
        }
    }
})