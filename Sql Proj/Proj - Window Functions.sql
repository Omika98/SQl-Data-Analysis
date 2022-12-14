/*This project contains complex window functions*/

create database win_fun;
use win_fun;
create table ineuron_students(
student_id int ,
student_batch varchar(40),
student_name varchar(40),
student_stream varchar(30),
students_marks int ,
student_mail_id varchar(50));

insert into ineuron_students values(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com'),
(100 ,'fsda' , 'saurabh','cs',80,'saurabh@gmail.com'),
(102 ,'fsda' , 'sanket','cs',81,'sanket@gmail.com'),
(103 ,'fsda' , 'shyam','cs',80,'shyam@gmail.com'),
(104 ,'fsda' , 'sanket','cs',82,'sanket@gmail.com'),
(105 ,'fsda' , 'shyam','ME',67,'shyam@gmail.com'),
(106 ,'fsds' , 'ajay','ME',45,'ajay@gmail.com'),
(106 ,'fsds' , 'ajay','ME',78,'ajay@gmail.com'),
(108 ,'fsds' , 'snehal','CI',89,'snehal@gmail.com'),
(109 ,'fsds' , 'manisha','CI',34,'manisha@gmail.com'),
(110 ,'fsds' , 'rakesh','CI',45,'rakesh@gmail.com'),
(111 ,'fsde' , 'anuj','CI',43,'anuj@gmail.com'),
(112 ,'fsde' , 'mohit','EE',67,'mohit@gmail.com'),
(113 ,'fsde' , 'vivek','EE',23,'vivek@gmail.com'),
(114 ,'fsde' , 'gaurav','EE',45,'gaurav@gmail.com'),
(115 ,'fsde' , 'prateek','EE',89,'prateek@gmail.com'),
(116 ,'fsde' , 'mithun','ECE',23,'mithun@gmail.com'),
(117 ,'fsbc' , 'chaitra','ECE',23,'chaitra@gmail.com'),
(118 ,'fsbc' , 'pranay','ECE',45,'pranay@gmail.com'),
(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com');
select * from ineuron_students;
/*Divide each batch and Give rank acc to students marks*/
select student_id,student_batch, Student_name, Students_marks,
Row_Number() Over (partition by student_batch order by students_marks desc) as 'Row_Num'
 from ineuron_students ;
 
 /*get max batch wise max marks*/
select student_id,student_batch, Student_name, Students_marks,
max(Students_marks)  Over (partition by student_batch ) as 'max_marks'
 from ineuron_students ;
 
/*get only those records having max marks from each dept
(using rank because row will skip if 2 records are same)*/
select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank' 
from ineuron_students ) as test where row_rank = 1;

/*Get Top 3 highest marks in each Dept*/
select * from (select student_id , student_batch , student_stream,students_marks ,
dense_rank() over(partition by student_batch order by students_marks desc) as 'Dense_rank'
from ineuron_students ) as test where `dENSE_Rank` in (1,2,3)



