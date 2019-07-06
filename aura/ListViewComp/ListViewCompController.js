({
    init : function(component, event, helper) {
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        component.set('v.accountcolumns', [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);
        helper.fetchAcc(component, event, helper);
        
        component.set('v.contactcolumns', [
            {label: 'First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Email', fieldName: 'Email', type: 'email'},
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);
        helper.fetchCon(component, event, helper);
    },
    createAccount: function (cmp, event, helper) {
        helper.handleShowModal(cmp, event, helper,'Create Account','account');
    },
    createContact: function (cmp, event, helper) {
        helper.handleShowModal(cmp, event, helper,'Create Contact','contact');
    },
    handleApplicationEvent: function (cmp, event, helper) {
        var data = event.getParam("data");
        var flag = event.getParam("flag");
        var rowIndex = event.getParam("rowIndex");
        if(flag == 'account')
        {
            if(rowIndex != null)
            {
                var accountdata = cmp.get("v.accountdata");
                accountdata[rowIndex] = data;
                cmp.set("v.accountdata",accountdata);
            }else
            {
                var accountdata = cmp.get("v.accountdata");
                accountdata.unshift(data);
                cmp.set("v.accountdata",accountdata);
            }
        }else if(flag == 'contact')
        {
            if(rowIndex != null)
            {
                var contactdata = cmp.get("v.contactdata");
                contactdata[rowIndex] = data;
                cmp.set("v.contactdata",contactdata);
            }else
            {
                var contactdata = cmp.get("v.contactdata");
                contactdata.unshift(data);
                cmp.set("v.contactdata",contactdata);
            }
        }
    },
    handleRowAction: function (cmp, event, helper) {
        console.log(event);
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'edit':
                var rows = cmp.get('v.accountdata');
                var rowIndex = rows.indexOf(row);
                helper.handleShowModal(cmp, event, helper,'Edit Account','account',row.Id,rowIndex);
                break;
            case 'delete':
                var rows = cmp.get('v.accountdata');
                var rowIndex = rows.indexOf(row);
                rows.splice(rowIndex, 1);
                cmp.set('v.accountdata', rows);
                break;
        }
    },
    contacthandleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        //alert(JSON.stringify(row));
        switch (action.name) {
            case 'edit':
                var rows = cmp.get('v.contactdata');
                var rowIndex = rows.indexOf(row);
                
                helper.handleShowModal(cmp, event, helper,'Create Contact','contact',row.Id,rowIndex);
                break;
            case 'delete':
                var rows = cmp.get('v.contactdata');
                var rowIndex = rows.indexOf(row);
                rows.splice(rowIndex, 1);
                cmp.set('v.contactdata', rows);
                break;
        }
    },
    loadMoreData: function (cmp, event, helper) {
        //Display a spinner to signal that data is being loaded
        event.getSource().set("v.isLoading", true);
        //Display "Loading" when more data is being loaded
        cmp.set('v.loadMoreStatus', 'Loading');
        helper.fetchData(cmp,event, helper)
        .then($A.getCallback(function (data) {
            //alert(cmp.get('v.accountdata').length);
            //alert(cmp.get('v.totalNumberOfRows'));
            if (cmp.get('v.accountdata').length >= cmp.get('v.totalNumberOfRows')) {
                cmp.set('v.enableInfiniteLoading', false);
                cmp.set('v.loadMoreStatus', 'No more data to load');
            } else {
                var currentData = cmp.get('v.accountdata');
                //Appends new data to the end of the table
                var newData = currentData.concat(data);
                cmp.set('v.accountdata', newData);
                cmp.set('v.loadMoreStatus', '');
            }
            event.getSource().set("v.isLoading", false);
        }));
    },
    contactloadMoreData: function (cmp, event, helper) {
        //Display a spinner to signal that data is being loaded
        event.getSource().set("v.isLoading", true);
        //Display "Loading" when more data is being loaded
        cmp.set('v.loadMoreStatus', 'Loading');
        helper.fetchConData(cmp,event, helper)
        .then($A.getCallback(function (data) {
            //alert(cmp.get('v.accountdata').length);
            //alert(cmp.get('v.totalNumberOfRows'));
            if (cmp.get('v.contactdata').length >= cmp.get('v.contacttotalNumberOfRows')) {
                cmp.set('v.contactenableInfiniteLoading', false);
                cmp.set('v.contactloadMoreStatus', 'No more data to load');
            } else {
                var currentData = cmp.get('v.contactdata');
                //Appends new data to the end of the table
                var newData = currentData.concat(data);
                cmp.set('v.contactdata', newData);
                cmp.set('v.contactloadMoreStatus', '');
            }
            event.getSource().set("v.isLoading", false);
        }));
    }
})