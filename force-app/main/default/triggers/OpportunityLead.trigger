trigger OpportunityLead on OpportunityLead__c (before insert) {
    
    if (trigger.isBefore){
        List<OpportunityLead__c> leadNew = [SELECT Lead__c, Opportunity__c FROM OpportunityLead__c WHERE Lead__c = :trigger.new[0].Lead__c AND Opportunity__c = :trigger.new[0].Opportunity__c ];
        system.debug(leadNew);
        if (!leadNew.isEmpty()){
            delete leadNew;
        }
    }
    
}