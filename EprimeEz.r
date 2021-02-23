library(tidyverse)
#Let's suppose your filename is "eprimefile" and you've imported this file as it is.
#I will use names as the image that I shared with you in README.md

#I want to check each subject' mean acc ratios by the condition

df<-eprimefile%>%group_by(subject,condition)%>%summarise(mean(acc))

##then, I want to this data more readable and suitable for those who wanted to continue analyzing in SPSS or excel.

#let's create an empty list for our loop
a<-list()

#As you noticed, I have 16 different condition in "condition" column. But don't worry, I will only show you for 3 condition. 
for(i in 1:nrow(df)){
  if(df$condition[i]=="1"){ #1 is one of our conditions
    a$1[[i]]<-df$acc[i]
  }
  else if(df$condition[i]=="2"){
    a$2[[i]]<-df$condition[i]
  }else if(df$condition[i]=="3"){
    a$3[[i]]<-df$acc[i]
    
  }

    
}

#now let's create an empty data frame that suitable for our dataset. You may change these values.
b<-data.frame(matrix(nrow = 50,ncol = 3))
names(b)[1]<-"1"
names(b)[2]<-"2"
names(b)[3]<-"3"

c<-unlist(a$1)
d<-unlist(a$2)
e<-unlist(a$3)
b$1<-c
b$2<-d
b$3<-e
view(b)
![image](https://user-images.githubusercontent.com/54986652/108913407-f5dcc880-763a-11eb-97e8-9004da37cf61.png)


####bonus#####
##easy way with tidyverse#####


acclast<-df %>%
group_by(condition) %>% 
mutate(id = subject) %>% 
ungroup() %>% 
pivot_wider(id_cols = id, names_from = condition, values_from = `mean(acc)`) %>% select(-id) # #sometimes after first tidying, the column name may change into the `mean(acc)` instead of acc.


![image](https://user-images.githubusercontent.com/54986652/108914119-f88bed80-763b-11eb-9a6a-362addaa6b14.png)

