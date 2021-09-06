/**
@description 
<pre>
Controler class to get the information for the Contact PDF -- Clase controladora para obtener información del PDF del contacto
<br/>
FECHA         AUTOR                  DESCRIPCIÓN<br/>

23/07/2021    Javier López Quesada   Create apex class.

</pre>
@author Javier López Quesada
@Date 23/07/2021
*/
public class ContactControllerPDF {
	
	//var declaration
    Public Contact contactInfo{get;set;}
    Public Account accountInfo{get;set;}
    Public Opportunity opportunityInfo{get;set;}
    Public signature__Signature__c signatureContactInfo{get;set;}
    Public signature__Signature__c signatureAccountInfo{get;set;}
	
	Public String name{get;set;}
    Public String email{get;set;}
	Public String nif{get;set;}
	Public String area{get;set;}
    Public String titulation{get;set;}
	Public String phone{get;set;}
    Public String mobile{get;set;}
    
    Public PageReference visualForce{get;set;}
    
    
    //constructor
    ////@param std Standard controller of page
    public ContactControllerPDF(ApexPages.standardController std){
		
		contactInfo = getContact(std.getID());
        opportunityInfo = getOpportunity(std.getID());
        
		name = getName(contactInfo);
		email = getEmail(contactInfo);
		nif = getNif(contactInfo);
		area = getArea(contactInfo);
		titulation = getTitulation(contactInfo);
		phone = getPhone(contactInfo);
		mobile = getMobile(contactInfo);
        
        accountInfo = getAccount(contactInfo);
        signatureContactInfo = getSignatureContact(contactInfo);
        signatureAccountInfo = getSignatureAccount(accountInfo);
        
	}
    
    public Contact getContact(id contactoID){
       //Query  para recuperar algunos datos usados en la página de VisualForce                  
       return [SELECT Id, FirstName, LastName, Email, NIF__c, Area__c, Titulation__c, Phone, MobilePhone, AccountId, Signature__c
               FROM Contact 
               WHERE id =: contactoID]; 
    }
    
    public Account getAccount(Contact c){
       //Query  para recuperar algunos datos usados en la página de VisualForce                  
       return [SELECT Id, name, Signature__c
               FROM Account 
               WHERE id =: c.AccountId]; 
    }
    
    public Opportunity getOpportunity(id contactoID){
       //Query  para recuperar algunos datos usados en la página de VisualForce                  
       List<Opportunity> aux = new List<Opportunity>( [SELECT Id, name, startDate__c, endDate__c, totalTime__c, amount
               FROM Opportunity 
               WHERE contactID =: contactoID] );
        return aux[0];
    }
    
    public signature__Signature__c getSignatureContact(Contact c){
       //Query  para recuperar algunos datos usados en la página de VisualForce                  
       return [SELECT Id, signature__Signature__c
               FROM signature__Signature__c 
               WHERE id =: c.Signature__c]; 
    }
    
    public signature__Signature__c getSignatureAccount(Account a){
       //Query  para recuperar algunos datos usados en la página de VisualForce                  
       return [SELECT Id, signature__Signature__c
               FROM signature__Signature__c 
               WHERE id =: a.Signature__c]; 
    }
	
	public String getName(Contact c){
        if(c.FirstName <> null){
            return c.FirstName + ' ' + c.LastName;
        }else{
            return c.LastName;
        }
	}
	
	public String getEmail(Contact c){
		return c.Email;
	}
	
	public String getNif(Contact c){
		return c.NIF__c;
	}
	
	public String getArea(Contact c){
		return c.Area__c;
	}
	
	public String getTitulation(Contact c){
		return c.Titulation__c;
	}
	
	public String getPhone(Contact c){
        if(c.Phone <> null){
			return c.Phone;
        }else{
            return 'Nulo';
        }
	}
	
	public String getMobile(Contact c){
		if(c.MobilePhone <> null){
			return c.MobilePhone;
        }else{
            return 'Nulo';
        }
	}
    
    public PageReference signaturePage()
	{
   		visualForce = new PageReference('/apex/signature__EmbeddedSignature?id=' + signatureContactInfo.id);
        visualForce.setRedirect(true);  
   		return visualForce;
	}
    
}