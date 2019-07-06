({
    handleRemoveEmail : function(component, event, helper) {
        var cmpEvent = component.getEvent("getEmailRecordToRemove");
        cmpEvent.setParams({
            "index" : component.get("v.index")});
        cmpEvent.fire();
    }
})