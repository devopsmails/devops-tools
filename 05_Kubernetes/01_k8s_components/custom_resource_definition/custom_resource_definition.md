What & Why Custom_resoure_definition used?
---------------------
  => It extends the capabilities of Kubernetes  
  => We can customize any feature which is not available using kubernetes.   
  EX: Istios  
    There are 3 types of custom resourcing:  
1.CUSTOM RESOURCE DEFINITION(CRD):   
  => Will be written in YAML   
  => K8 will have """Rosource Definition""" to compare your ex: Deployment.yml. If any resource is entered  which is not defined in Resource Definition, It pops an error.  
  => This is the predifined custom template to check the custom resourece.   
  
2.CUSTOM CONTROLLER:  
    => It's like Deployment controller who does all the actions to create RS, SERVICE, PODS .  
3.CUSTOM RESOURCE:
    => What customization is needed to perform as an action.  

How to write CRD? 
================  
  => By using """Go Lang"""(bcz CNCF is using GO LANG) as most populor.  
  => Need to create Custom watchers  
