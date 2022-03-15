# joints and pivots 
# 03-15-22

# help -> cheatsheets -> data transforomations with dplyr 

library(tidyverse)

data1 = data.frame(ID = c(1,2), 
                   X1 = c("a1", "a2"))
data2 = data.frame(ID = c(2, 3), 
                   X2 = c("b1", "b2"))
data1
data2


# left join keeps the left (first) table and adds data from the second table, but nly data from table 2 that applies to table 1 is added 

#without specifying joining variable 

left_join(data1, data2)

#specifying joining variable 

left_join(data1, data2, by = "ID")

#with piping

data12_left = data1 %>%
  left_join(data2, by = "ID")
data12_left


# inner join matches data that exists in both tables, mating variables in common 


inner_table = data1 %>%
  inner_join(data2, by = "ID")
inner_table


# full join returns all values from both tables, adding NA to missing values 

full_table = data1 %>%
  full_join(data2, by = "ID")
full_table

#semi join is a filtering function that does not create new columns, keeping onl columns in data 1

semi_table = semi_join(data1, data2, by = "ID")
semi_table

#anti join returns all rows from data1 where there are no matching values in data 2
anti_table = anti_join(data1, data2, by = "ID")
anti_table


# pivots 

survey = data.frame(quadrat_id = c(101, 102, 103, 104), 
                     barnacle_n = c(2, 11, 8, 27), 
                     chiton_n = c(1, 0, 0, 2), 
                     mussel_n = c(0, 1, 1, 4))
survey

# ggplot and other packages play better with data if you pivot data frame to longer version 

long = survey %>%
  pivot_longer(cols = c("barnacle_n", "chiton_n", "mussel_n"), 
               names_to = "beastie", 
               values_to = "counts")
long

wide = long %>%
  pivot_wider(names_from = beastie, values_from = counts)
wide


# tedious with wide data 
ggplot(data = wide) +
  geom_point(aes(x = quadrat_id, y = barnacle_n), color = 'red') + 
  geom_point(aes(x = quadrat_id, y = chiton_n), color = "green") +
  geom_point(aes(x = quadrat_id, y = mussel_n), color = "blue")


# easy with long data 
ggplot(aes(x = quadrat_id, y = counts, color = beastie), data = long) + 
  geom_point()










