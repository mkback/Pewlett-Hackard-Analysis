# Pewlett-Hackard Analysis


#### In this project we look at employee information for a computer hardware company Pewlett-Hackard (yes, a play on HP… for purposes of this project it is a fake dataset and company). This company wishes to prepare for upcoming retirements on their teams. We would like to analyze the number of employees this is and what department this may affect. We can do so by preforming SQL queries.  

To first grasp the information given in the database, an entity relationship diagram was created to visualize the relationships between the tables. See below for a diagram of this ERD: 

![Alt Image Text](https://github.com/mkback/Pewlett-Hackard-Analysis/tree/main/Resources/EmployeeDB.png)

Once the relationships have been established tables were imported and new tables were created using inner join, left join, group by and other SQL functions. Analysis was then preformed to answer the questions asked by the company. See the queries in the folder labeled Queries to find this code.  

## Results   

The dataset has information on 300K employees. 60K of which no longer work at the company. Out of the 240K of employees who still work at the company, 72K are eligible to retire soon. These employees are spread across many titles in the company. As no surprise, the majority of those retiring are in Senior positions. About 50K of these employees eligible to retire are on Senior Engineer or Senior Staff positions. 
 
![Alt Image Text](https://github.com/mkback/Pewlett-Hackard-Analysis/tree/main/Resources/Retiring_titles.png)

These employees eligible for retirement make up 30% of the company’s workforce which raises some concerns for the future of Pewlett-Hackward. To alleviate the impact, the company wants to put together a mentorship program for those employees born in 1965. This mentorship program includes 1.5K employees across all roles. The largest portion of employees here are also in the Senior Engineer and Senior Staff roles which will great to partner them with those retiring. 

![Alt Image Text](https://github.com/mkback/Pewlett-Hackard-Analysis/tree/main/Resources/Mentor_eligible_1965.png)

With 72k employees retiring, I suggest the company expands its mentorship program so they can train more employees to take on those roles. If we expand the mentorship to those born in 1963-1967 rather than just 1965, the count of employees expands to 38K. The more employees Pewlett-Hackward can train and mentor, the easier the transition will be when this “silver tsunami” hits.  

![Alt Image Text](https://github.com/mkback/Pewlett-Hackard-Analysis/tree/main/Resources/Mentor_eligible_1963_1967.png)

