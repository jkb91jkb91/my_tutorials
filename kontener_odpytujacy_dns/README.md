ITS Additional container used as seperate ECS SERVICE  

ONE ECS SERVICE for all others services used to:  
-make GET requests to check if DOMAIN is achievable in this way  

Why to use such solution ??  
Lets say we have ALB and 2 ECS cointaners ( ALB > oauth-container > app-container)  
IF script from monitoring container will send GET REQUEST >>> it check whole traffic  
REQUEST FROM OUTSIDE >>>> ALB >>> ECS1 CONTAINER >> ECS2 CONTAINER
