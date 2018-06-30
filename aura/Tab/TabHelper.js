({
    handleActiveHelper: function (cmp, event, helper) {
        var tab = event.getSource();
        switch (tab.get('v.id')) {
            case 'accounts' :
                this.injectComponent('c:AccountTab', tab);
                break;
            case 'cases' :
                this.injectComponent('c:CaseTab', tab);
                break;
        }
    },
    injectComponent: function (name, target) {
        $A.createComponent(name, {
        }, function (contentComponent, status, error) {
            if (status === "SUCCESS") {
                target.set('v.body', contentComponent);
            } else {
                throw new Error(error);
            }
        });
    }
})