({
    close : function(component, event, helper) {
        component.find("popuplib").notifyClose();
    },
    accountsuccess : function(component, event, helper) {
        var statusVal = event.getParam("response");
        //console.log(JSON.stringify(statusVal));
        var data = {'Id':statusVal.id,'Name':statusVal.fields.Name.value,'Phone':statusVal.fields.Phone.value,'Type':statusVal.fields.Type.value,'Industry':statusVal.fields.Industry.value};
        var appEvent = $A.get("e.c:ApplicationEvent");
        appEvent.setParams({
            "data" : data,
            "flag": component.get("v.flag"),
            "rowIndex":component.get("v.rowIndex")
        });
        appEvent.fire();
        component.find("popuplib").notifyClose();
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type":"success",
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    },
    contactsuccess : function(component, event, helper) {
        var statusVal = event.getParam("response");
        var data = {'Id':statusVal.id,'FirstName':statusVal.fields.FirstName.value,'Phone':statusVal.fields.Phone.value,'LastName':statusVal.fields.LastName.value,'Email':statusVal.fields.Email.value};
        var appEvent = $A.get("e.c:ApplicationEvent");
        appEvent.setParams({
            "data" : data,
            "flag": component.get("v.flag"),
            "rowIndex":component.get("v.rowIndex")
        });
        appEvent.fire();
        component.find("popuplib").notifyClose();
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type":"success",
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    },
    errors: function(component, event, helper) {
        var statusVal = event.getParam("error");
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type":"error",
            "title": "Error!",
            "message": statusVal.message
        });
        toastEvent.fire();
    },
})