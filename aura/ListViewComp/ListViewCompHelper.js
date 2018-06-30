({
    fetchAcc : function(component, event, helper) {
        var action = component.get("c.fetchAccount");
        var counts = component.get("v.currentCount");
        action.setParams({
            "limits": component.get("v.initialRows"),
            "offsets": counts 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert("From server: " + response.getReturnValue().totalRows);
                component.set("v.accountdata",response.getReturnValue().accList);
                component.set("v.totalNumberOfRows",response.getReturnValue().totalRows);
                
                var countstemps = component.get("v.currentCount");
                countstemps = countstemps+component.get("v.initialRows");
                component.set("v.currentCount",countstemps);
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
    fetchCon : function(component, event, helper) {
        var action = component.get("c.fetchContact");
        var counts = component.get("v.contactcurrentCount");
        action.setParams({
            "limits": component.get("v.contactinitialRows"),
            "offsets": counts 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert("From server: " + response.getReturnValue().totalRows);
                component.set("v.contactdata",response.getReturnValue().conList);
                component.set("v.contacttotalNumberOfRows",response.getReturnValue().totalRows);
                
                var countstemps = component.get("v.contactcurrentCount");
                countstemps = countstemps+component.get("v.contactinitialRows");
                component.set("v.contactcurrentCount",countstemps);
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
    fetchData: function(component, event, helper){
        //alert('testtest');
        return new Promise($A.getCallback(function(resolve, reject) {
            var currentDatatemp = component.get('c.fetchAccount');
            var counts = component.get("v.currentCount");
            currentDatatemp.setParams({
                "limits": component.get("v.initialRows"),
                "offsets": counts 
            });
            currentDatatemp.setCallback(this, function(a) {
                //alert(a.getReturnValue().accList.length);
                resolve(a.getReturnValue().accList);
                var countstemps = component.get("v.currentCount");
                countstemps = countstemps+component.get("v.initialRows");
                component.set("v.currentCount",countstemps);
                
            });
            $A.enqueueAction(currentDatatemp);
        }));
        
    } ,
    fetchConData: function(component, event, helper){
        //alert('testtest');
        return new Promise($A.getCallback(function(resolve, reject) {
            var currentDatatemp = component.get('c.fetchContact');
            var counts = component.get("v.contactcurrentCount");
            currentDatatemp.setParams({
                "limits": component.get("v.contactinitialRows"),
                "offsets": counts 
            });
            currentDatatemp.setCallback(this, function(a) {
                //alert(a.getReturnValue().conList.length);
                resolve(a.getReturnValue().conList);
                var countstemps = component.get("v.contactcurrentCount");
                countstemps = countstemps+component.get("v.contactinitialRows");
                component.set("v.contactcurrentCount",countstemps);
                
            });
            $A.enqueueAction(currentDatatemp);
        }));
        
    },
    handleShowModal: function(component, evt, helper,header,flag,recID,rowIndex) {
        alert('Inside');
        var modalBody;
        $A.createComponent("c:CRUDComp", {"flag":flag,"recID":recID,"rowIndex":rowIndex},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   component.find('popuplib').showCustomModal({
                                       header: header,
                                       body: modalBody, 
                                       showCloseButton: true
                                   })
                                   
                               }
                               
                           });
    }
})