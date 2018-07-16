({
    getAccounts : function(cmp,next,prev,offset) {
        offset = offset || 0;
        var action = cmp.get("c.getacc");
        action.setParams({
            "next" : next,
            "prev" : prev,
            "off" : offset            
        });
        action.setCallback(this,function(res){
            var state = res.getState();            
            if(state=="SUCCESS"){
              var result = res.getReturnValue();
              cmp.set('v.offset',result.offst);
              cmp.set('v.accounts',result.acc);
              cmp.set('v.next',result.hasnext);
              cmp.set('v.prev',result.hasprev);
            }
        });        
        $A.enqueueAction(action);
    }
})