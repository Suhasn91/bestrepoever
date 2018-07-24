({
    openClassis : function(component, event, helper) {
        var action = component.get("c.getEmail");
        action.setParams({ recordId : component.get("v.recordId")});
        alert(component.get("v.recordId"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "https://suhasnlightning-dev-ed.my.salesforce.com/_ui/core/email/author/EmailAuthor?p2_lkid="+component.get("v.recordId")+"&&p24=sumanthn95@gmail.com&&retURL="+component.get("v.recordId")
                });
                urlEvent.fire();
            }
            else if (state === "ERROR") 
            {
                // do something
            }
        });
        $A.enqueueAction(action);
    }
})