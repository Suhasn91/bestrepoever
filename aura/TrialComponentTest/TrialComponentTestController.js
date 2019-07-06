({
    init: function (cmp, event, helper) {
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        cmp.set('v.mycolumns', [
            {label: 'First Name', fieldName: 'firstName', type: 'text'},
            {label: 'Last Name', fieldName: 'lastName', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'text'},
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);
        var contactList = cmp.get('v.mydata');
        contactList.push(cmp.get('v.contact'));
        cmp.set('v.mydata', contactList);
    },
    createContact: function(cmp, event, helper) {
        var modalBody;
        $A.createComponent("c:CRUDComp", {},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   cmp.find('popuplib').showCustomModal({
                                       header: 'Create Contact',
                                       body: modalBody, 
                                       showCloseButton: true
                                   })
                               }
                           });
    }
})