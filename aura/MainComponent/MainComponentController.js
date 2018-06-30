({
    doInit : function(component, event, helper) 
    {
        if(component.get("v.Id") == '')
        {
            var wrap = { 'accountRecord' : 
                        {
                            'sobjectType' : 'Account'
                        },
                        'contactsList' : 
                        [
                            {
                                'contactRecord': {
                                    'sobjectType' : 'contact'
                                },
                                'mailObjectList': [
                                    {
                                        'sobjectType' : 'Contact_Email__c',
                                        'Email__c' : '',
                                        'Email_Type__c' : ''
                                    }
                                ]
                            }
                        ]
                       };
            component.set("v.completeWrapper",wrap);
        }
        else
        {
            var action = component.get("c.getRecords");
            action.setParams
            ({ 
                "accountRecordId" : component.get("v.Id")
            });
            action.setCallback(this, function(a) 
                               {
                                   var state = a.getState();
                                   if (state === "SUCCESS") 
                                   {
                                       if(a.getReturnValue() != null)
                                       {
                                           component.set("v.completeWrapper", a.getReturnValue());
                                       } 
                                       else
                                       {
                                           alert('Return value is null');
                                       }   
                                   }
                                   else
                                   {
                                       alert('Error while saving');
                                   }
                               });
            $A.enqueueAction(action);
            
        }
    },
    addContact : function(component, event, helper) 
    {
        var existingcontactList = component.get("v.completeWrapper.contactsList");
        var wrap = {
            'contactRecord': {
                'sobjectType' : 'contact'
            },
            'mailObjectList': [
                {
                    'sobjectType' : 'Contact_Email__c',
                    'Email__c' : '',
                    'Email_Type__c' : ''
                }
            ]
        };
        existingcontactList.push(wrap);
        component.set("v.completeWrapper.contactsList",existingcontactList);
    },
    handleRemoveContactDetails : function(component, event, helper)
    {
        var indexToRemove = event.getParam("index");
        var existingcontactList = component.get("v.completeWrapper.contactsList");
        var existingRecordsDelete = component.get("v.contactRecordsDelete");
        if(component.get("v.completeWrapper.contactsList["+indexToRemove+"].contactRecord.Id") != undefined)
        {
            existingRecordsDelete.push(component.get("v.completeWrapper.contactsList["+indexToRemove+"].contactRecord.Id"));
            component.set("v.contactRecordsDelete", existingRecordsDelete);
        }
        existingcontactList.splice(indexToRemove,1);
        component.set("v.completeWrapper.contactsList", existingcontactList);
    },
    upsertAccount : function(component, event, helper)
    {
        var completeData = component.get("v.completeWrapper");
        console.log('DataContent'+JSON.stringify(completeData));
        
        var action = component.get("c.createRecords");
        action.setParams
        ({ 
            "DataContent" : JSON.stringify(component.get("v.completeWrapper")),
            "emailListIdsToDelete" : JSON.stringify(component.get("v.emailRecordsDelete")),
            "contactListIdsToDelete" : JSON.stringify(component.get("v.contactRecordsDelete"))
        });
        action.setCallback( this, function(a) 
                           {
                               var state = a.getState();
                               if (state === "SUCCESS") 
                               {
                                   if(a.getReturnValue() != null)
                                   {
                                       if ((typeof sforce != 'undefined') && sforce && (!!sforce.one)) {
                                           // Manage navigation in Lightning Experience & Salesforce1
                                           sforce.one.navigateToSObject(a.getReturnValue());
                                       }
                                       else
                                       {
                                           window.location.href = "/" + a.getReturnValue();
                                       }    
                                   } 
                                   else
                                   {
                                       alert('Return value is null');
                                   }   
                               }
                               else
                               {
                                   alert('Error while saving');
                               }
                           });
        $A.enqueueAction(action);
    }
})