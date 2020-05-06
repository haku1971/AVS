use AVS_Database_Final

create table Jobs (
job_ID int primary key not null identity(1,1),
job_Name nvarchar(100) not null
)

create table Users (
user_ID int primary key not null identity(1,1),
user_Name nvarchar(15) not null,
user_Password nvarchar(300) not null,
user_FullName nvarchar(100),
user_DOB date not null,
user_Workplaces nvarchar(1000),
user_Gender int not null,
user_Mail nvarchar(300) not null,
user_Phone nvarchar(20),
job_ID int not null,
ban_Status int not null DEFAULT 0,
FOREIGN KEY(job_ID)		REFERENCES Jobs(job_ID)
)

create table ModifyUser (
moduser_ID int primary key not null identity(1,1),
user_ID int not null,
admin_id int not null,
moduser_Time datetime not null,
ban_Status int not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(admin_ID) REFERENCES Users(user_ID)
)


create table Roles(
role_ID int primary key not null identity(1,1),
role_Name nvarchar(200) not null
)

create table UserRoles (
userRole_ID int primary key not null identity(1,1),
role_ID int not null,
user_ID int not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(role_ID) REFERENCES Roles(role_ID)
)

create table Category(
category_ID int primary key not null identity(1,1),
category_Name nvarchar(200) not null
)

create table News (
news_ID int primary key not null identity(1,1),
news_Tittles nvarchar(300) not null,
news_Content nvarchar(MAX) not null,
news_DateRealease datetime not null,
news_Resource nvarchar(300),
news_Imgs nvarchar(MAX),
user_ID int not null,
delete_Status int not null DEFAULT 0,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID)
)

create table Comments (
comment_ID int primary key not null identity(1,1),
comment_Content nvarchar(MAX) not null,
comment_Datetime datetime not null,
user_ID int not null,
news_ID int not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(news_ID) REFERENCES News(news_ID)
)

create table Algorithm (
algo_ID int primary key not null identity(1,1),
algo_Name nvarchar(200) not null,
algo_CodeJava nvarchar(MAX),
algo_CodeCplus nvarchar(MAX),
algo_CodeJS nvarchar(MAX),
algo_Description nvarchar(MAX),
category_ID int not null,
algo_DateTime datetime not null,
algo_Resource nvarchar(MAX) not null,
algo_Files nvarchar(MAX),
algo_CompareStatus int not null DEFAULT 0,
delete_Status int not null DEFAULT 0,
FOREIGN KEY(category_ID) REFERENCES Category(category_ID)
)


create table ModifyAlgorithm (
modalgo_ID int primary key not null identity(1,1),
user_ID int not null,
algo_ID int not null,
modalgo_Time datetime not null,
Action nvarchar(MAX) not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(algo_ID) REFERENCES Algorithm(algo_ID)
)

create table ModifyNews (
modnews_ID int primary key not null identity(1,1),
user_ID int not null,
news_ID int not null,
modnews_Time datetime,
Action nvarchar(MAX),
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(news_ID) REFERENCES News(news_ID),
)

create table LikeComment (
user_ID int  not null,
comment_ID int  not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(comment_ID) REFERENCES Comments(comment_ID),
Primary Key(user_ID,comment_ID)
)
create table LikeNews (
user_ID int  not null,
news_ID int  not null,
FOREIGN KEY(user_ID) REFERENCES Users(user_ID),
FOREIGN KEY(news_ID) REFERENCES News(news_ID),
Primary Key(user_ID,news_ID)
)







create table History (
history_ID int not null primary key identity(1,1),
IP nvarchar(MAX) not null,
algo_ID int not null,
dateAccess date not null,
totalTime bigint not null,
FOREIGN KEY(algo_ID) REFERENCES Algorithm(algo_ID)
)


insert into Jobs(job_Name)
values('Teacher')
insert into Jobs(job_Name)
values('Student')
insert into Jobs(job_Name)
values('Employee')
insert into Jobs(job_Name)
values('Manager')
insert into Jobs(job_Name)
values('None')

insert into Users(user_Name,user_Password,user_FullName,user_DOB,user_Workplaces,user_Gender,user_Mail,user_Phone,job_ID)
values ('anhmn12','MTIzNDU2','Mai Nhat Anh','2013-10-10','FPT Uniersity',1,'anhmn@gmail.com','0123456789',2)
insert into Users(user_Name,user_Password,user_FullName,user_DOB,user_Workplaces,user_Gender,user_Mail,user_Phone,job_ID)
values ('duongph','MTIzNDU2','Phi Hoang Duong','2013-10-10','FPT Uniersity',1,'duongph@gmail.com','0936219916',2)
insert into Users(user_Name,user_Password,user_FullName,user_DOB,user_Workplaces,user_Gender,user_Mail,user_Phone,job_ID)
values ('binhnt','123456','Ngo Thanh Binh','2013-10-10','FPT Uniersity',1,'binhnt@gmail.com','0987654321',2)





insert into Roles(role_Name)
values('Admin')
insert into Roles(role_Name)
values('User')

insert into UserRoles(role_ID,user_ID)
values(1,1)
insert into UserRoles(role_ID,user_ID)
values(1,2)
insert into UserRoles(role_ID,user_ID)
values(2,3)



insert into News(news_Tittles,news_Content,news_DateRealease,news_Resource,news_Imgs,user_ID,delete_Status)
values ('Every child needs a personalised learning plan','If I had to pick between an amazing teacher and amazing technology, I’d pick the teacher every time. But we need to empower these teachers with better tools to engage in the task of serving a population of students with diverse needs. In 2020, they will have tools that allow each student to work on what is most appropriate for their needs in an environment of fast-cycle, continual improvement. This will help put education, which has had decades of little improvement in countries such as the US or UK, finally on track to accelerate student learning.','20200223 10:34:09 AM','Cnet','null',1,0);
insert into News(news_Tittles,news_Content,news_DateRealease,news_Resource,news_Imgs,user_ID,delete_Status)
values ('Amazon VP resigns in protest over firings of activist employees','Amazon in recent weeks fired six workers, including four warehouse employees and two tech workers, after they raised concerns about safety in Amazon warehouses during the coronavirus pandemic. Amazon had previously defended the firings, saying each of the fired employees violated different internal protocols.

In a blog post, Bray scolded Amazons leaders over the terminations, calling the move "chickenshit" and intended to deter other Amazon employees from speaking out. His last day at the company was Friday, the same day Amazon, Instacart, Target and other essential workers staged May Day protests across the country to call for better protections from the coronavirus.

"The justifications were laughable; it was clear to any reasonable observer that they were turfed for whistleblowing," Bray said. He said he was giving up over $1 million in pre-tax money, both in salary and restricted stock, "not to mention the best job Ive ever had." 

Bray has worked at Amazon for five years and was a distinguished engineer for Amazon Web Services. He previously worked at Google and Sun Microsystems and is a co-creator of the XML language.

Amazon representatives declined a request for comment for this story.','20200223 10:34:09 AM','Cnet','null',1,0);
insert into News(news_Tittles,news_Content,news_DateRealease,news_Resource,news_Imgs,user_ID,delete_Status)
values ('COVID-19’s potential impact on global technology and data innovation','COVID-19 is a global health crisis whose scale and speed are unprecedented in recent history. Companies should act now to protect their people and ensure business continuity. High tech firms will likely need to evaluate impacts on three fronts: supply chain, market demand and employees. High tech leaders should balance preparing for the short-term while also developing new capabilities and ways of working that will change how they operate in mid- and long-term.

High tech is well positioned to ride out the crisis
In the short-term, supply disruption will reduce manufacturing and assembly capacity, plant reopenings will be further delayed by lags in component supply, and travel bans will exacerbate workforce shortages and consumer demand. The good news is High tech companies are set up for remote work more than other industries and so will suffer less of a workplace culture shock.

The shift to working from home with the help of digital collaboration tools is likely to drive demand for High tech in many categories. A growing need for infrastructure to support this shift, like cloud computing for business or increased broadband consumption for consumers, will be a boon to the industry.','20200223 10:34:09 AM','Accenture','null',2,0);
insert into News(news_Tittles,news_Content,news_DateRealease,news_Resource,news_Imgs,user_ID,delete_Status)
values ('The Benefits of Using React
','React is a simple, yet powerful, UI library. When it was released in 2013, it offered an alternative to the existing popular monolithic JavaScript frameworks of the time. React’s most important advances are the emphasis on components, one-way data flow, the Virtual DOM, JSX, and architecture that extends beyond HTML.

React’s simplicity lies in that it makes it easy to declare user-interfaces in self-contained independent components. It hides its complex rendering engine implementation and exposes a simple component API. There are only a few public methods to override inside the component such as componentWillMount, componentDidMount, etc.

In React, every UI is composed of components, so there is no mismatch of multiple types to worry about. Since there is only one common object, it makes it easy to nest components inside components and encourages the principle of single responsibility for each component.

Components
The React UI is declared inside components. A component is like a function that accepts props as inputs and outputs the declared interface. The UI should be composed of as many components as possible to maximize reusability.

If a widget is composed of multiple components, the state should be inside the parent component. Any asynchronous I/O requests shouldn’t be inside the pure component. Doing so would make it less usable as it couples the I/O requests to the component. If you tried to use the component in a large list, it would create a large amount of requests on rendering the components.

Try to avoid using inheritance, and use composition from components. For example, if you need more functionality from a component, make a wrapper component. There are different kinds of components besides just UI components and container components. It is useful to think of these as pages or screens that contain all the components, handle actions to request the data, and also handle local inner component communications.

One-Way Data Flow
React uses one-way data flow, so only changes to the data result in changes to the UI. If you use Redux, you change data in a global app store, and the components listen for changes there. The benefits of having all the app state in one place is having one source of truth. Another benefit is it makes it easier to inspect changes in the app and captures the different states of the app. This helps when trying to reproduce errors.

Virtual DOM
The Virtual DOM allows the UI to be efficient in diffing UI changes. This in-between process between what the component should render and what the actual rendering is that it allows React to work on different platforms. React Native runs on mobile devices and there are also native OS platforms that run on Ubuntu, Mac, and Windows.

The in-between step is where React actually does most of its work. It does this using the difference between the last declared render and the updated render in a virtual model of the interface, applying to it the real interface implementation. The reason for the virtual DOM is that in browsers, certain changes to the DOM cause browser engines to recalculate the CSS layout, reimplement the layout, and redraw the page. React batches the minimum amount of changes needed in each UI cycle, reducing the redraw frequency.

Ecosystem
React isn’t just the UI, it’s a framework/ecosystem. You can manage the state using a state manager such as Redux. This is abstracted away from the component tree. It makes debugging easier to not have state hidden in multiple places. There are good tools following this stack such as Redux DevTools, which allows you to see the app state as a collapsable tree widget.','20200223 10:34:09 AM','Sourcetoad','null',2,0);
insert into News(news_Tittles,news_Content,news_DateRealease,news_Resource,news_Imgs,user_ID,delete_Status)
values ('Google, Apple COVID-19 Exposure Notification System Spotted In Action','Apple and Google recently announced their partnership to develop a COVID-19 exposure tracking notification system. Quite recently, the API of the system was spotted in the developer version. And now, screenshots of how the notification system would look, function, its UI, and other details have surfaced online.','20200223 10:34:09 AM','60secondsnow','null',2,0);


insert into Category(category_Name)
values ('Internal Sorting')
insert into Category(category_Name)
values ('Optimum Sorting')
insert into Category(category_Name)
values ('External Sorting')
insert into Category(category_Name)
values ('Sequential Searching')
insert into Category(category_Name)
values ('Searching by Comparision of Keys')
insert into Category(category_Name)
values ('Hashing')


insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Bubble Sort','<table><tr id="line_1"> <td>for (int i = 0; i < array.length - 1; i++) {</td></tr><tr id="line_2"> <td>&emsp;&emsp;for (int j = 0; j < array.length - i - 1; j++) {</td></tr><tr id="line_3"> <td>&emsp;&emsp;&emsp;&emsp;int temp = array[i];</td></tr><tr id="line_4"> <td>&emsp;&emsp;&emsp;&emsp;array[i] = array[j];</td></tr><tr id="line_5"> <td>&emsp;&emsp;&emsp;&emsp;array[j] = temp;</td></tr><tr id="line_6"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_7"> <td>&emsp;&emsp;}</td></tr><tr id="line_8"> <td>}</td></tr></table>','<table>
            <tr><td>void swap(int *xp, int *yp)  </td></tr>  
            <tr><td>{</td></tr>  
            <tr><td>&emsp;&emsp;int temp = *xp;  </td></tr>  
            <tr><td>&emsp;&emsp;*xp = *yp;  </td></tr>  
            <tr><td>&emsp;&emsp;*yp = temp;  </td></tr>  
            <tr><td>  }   </td></tr>  
            <tr><td><div class="codecomment">// A function to implement bubble sort  </div></td></tr>  
            <tr><td>void bubbleSort(int arr[], int n)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int i, j;  </td></tr>  
            <tr><td>&emsp;&emsp;for (i = 0; i < n-1; i++)          </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Last i elements are already in place </div> </td></tr>  
            <tr><td>&emsp;&emsp;for (j = 0; j < n-i-1; j++)  </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;if (arr[j] > arr[j+1])  </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp; swap(&arr[j], &arr[j+1]);  </td></tr>  
            <tr><td>}   </td></tr>          
        </table>','   <table>
            <tr><td> function bubbleSort(arr)  </td></tr>
 <tr><td>    { </td></tr>  
 <tr><td>    &emsp;    var n = arr.length; </td></tr>  
 <tr><td>    &emsp;    for (var i = 0; i < n-1; i++) </td></tr>  
  <tr><td>    &emsp;&emsp;       for (var j = 0; j < n-i-1; j++) </td></tr>  
  <tr><td>     &emsp;&emsp;&emsp;          if (arr[j] > arr[j+1]) </td></tr>  
  <tr><td>      &emsp;&emsp;&emsp;         { </td></tr>  
  <tr><td>         <div class="codecomment" >  &emsp;&emsp;&emsp; &emsp;  // swap arr[j+1] and arr[i] </div> </td></tr>  
  <tr><td>        &emsp;&emsp;&emsp;&emsp;            var temp = arr[j]; </td></tr>  
 <tr><td>         &emsp;&emsp;&emsp;&emsp;            arr[j] = arr[j+1]; </td></tr>  
 <tr><td>        &emsp;&emsp;&emsp;&emsp;             arr[j+1] = temp; </td></tr>  
  <tr><td>       &emsp;&emsp;&emsp;         } </td></tr>  
  <tr><td>   }                </td></tr>          
        </table>','<div class="algoName"> 
Bubble Sort
</div> Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in wrong order.
<span id="dots">...</span><br><br><span id="more">
<br> The bubble sort works by iterating down an array to be sorted from the first element to the last, comparing each pair of elements and switching their positions if necessary. This process is repeated as many times as necessary, until the array is sorted.
<br><br>
<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n^2)</div> 
<div class="average"> Average: O(n^2)</div>
<div class="worstcase"> Worst Case: O(n^2)</div></span>




',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/bubble-sort/','bubblesort',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Quick Sort','<table>
            <tr><td><div class="codecomment">/* This function takes last element as pivot,</div> </td></tr>
 <tr><td><div class="codecomment">places the pivot element at its correct </div>  </td></tr> 
 <tr><td><div class="codecomment">position in sorted array, and places all </div>  </td></tr> 
 <tr><td><div class="codecomment">smaller (smaller than pivot) to left of </div>  </td></tr> 
 <tr><td><div class="codecomment">pivot and all greater elements to right </div>  </td></tr>  
            <tr><td>int partition(int arr[], int low, int high)  </td></tr>  
            <tr><td>{</td></tr>  
            <tr><td>&emsp;&emsp;int pivot = arr[high];  </td></tr> 
            <tr><td><div class="codecomment">&emsp;&emsp;// Index of smaller element</div></td></tr>
            <tr><td>&emsp;&emsp;int i = (low-1);</td></tr> 
            <tr><td>&emsp;&emsp;for (int j = low; j < high; j++)</td></tr> 
            <tr><td>&emsp;&emsp; {  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// If current element is smaller than the pivot</div></td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp;if (arr[j] < pivot) </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp;{  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;i++;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;&emsp;// swap arr[i] and arr[j]</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp; &emsp;int temp = arr[i];</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp; &emsp;arr[i] = arr[j];</td></tr> 
            <tr><td>&emsp;&emsp;&emsp;&emsp; &emsp;arr[j] = temp;</td></tr> 
            <tr><td>&emsp;&emsp;&emsp;&emsp;}</td></tr>  
            <tr><td>&emsp;&emsp;}</td></tr> 
            <tr><td><div class="codecomment">&emsp;&emsp;// swap arr[i+1] and arr[high] (or pivot)</div></td></tr>
            <tr><td>&emsp;&emsp;int temp = arr[i+1];</td></tr>  
            <tr><td>&emsp;&emsp;arr[i+1] = arr[high];</td></tr>
            <tr><td>&emsp;&emsp;arr[high] = temp;</td></tr>
            <tr><td>&emsp;&emsp;return i+1; </td></tr>
            <tr><td>}</td></tr>
            
            <tr><td><div class="codecomment">/* The main function that implements QuickSort() </div> </td></tr> 
 <tr><td><div class="codecomment">arr[] --> Array to be sorted, </div> </td></tr> 
 <tr><td><div class="codecomment">low  --> Starting index, </div> </td></tr> 
 <tr><td><div class="codecomment">high  --> Ending index */</div> </td></tr>
            <tr><td>void sort(int arr[], int low, int high)  </td></tr>  
            <tr><td>{</td></tr> 
            <tr><td>&emsp;&emsp;if (low < high)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;/* pi is partitioning index, arr[pi] is </div>  </td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;now at right place */</div> </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;int pi = partition(arr, low, high);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// Separately sort elements before</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// partition and after partition</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;sort(arr, low, pi-1);</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;sort(arr, pi+1, high);</td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}</td></tr>
        </table>','<table>
            <tr><td>void swap(int* a, int* b)</td></tr>
            <tr><td>{  </td></tr>
            <tr><td>&emsp;&emsp;int t = *a;</td></tr>
            <tr><td>&emsp;&emsp;*a = *b;</td></tr>  
            <tr><td>&emsp;&emsp;*b = t;</td></tr>
            <tr><td>}</td></tr>  
            <tr><td><div class="codecomment">/* This function takes last element as pivot,</div> </td></tr>
 <tr><td><div class="codecomment">places the pivot element at its correct </div>  </td></tr> 
 <tr><td><div class="codecomment">position in sorted array, and places all </div>  </td></tr> 
 <tr><td><div class="codecomment">smaller (smaller than pivot) to left of </div>  </td></tr> 
 <tr><td><div class="codecomment">pivot and all greater elements to right </div>  </td></tr> 
 <tr><td><div class="codecomment">of pivot */</div></td></tr> 
            <tr><td>int partition (int arr[], int low, int high)  </td></tr>  
            <tr><td>{</td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// pivot</div></td></tr>
            <tr><td>&emsp;&emsp;int pivot = arr[high];  </td></tr> 
            <tr><td><div class="codecomment">&emsp;&emsp;// Index of smaller element</div></td></tr>
            <tr><td>&emsp;&emsp;int i = (low - 1);</td></tr> 
            <tr><td>&emsp;&emsp;for (int j = low; j <= high - 1; j++)</td></tr> 
            <tr><td>&emsp;&emsp; {  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// If current element is smaller than the pivot</div></td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp;if (arr[j] < pivot) </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp;{  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;&emsp;// increment index of smaller element</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;i++;</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;swap(&arr[j], &arr[j+1]);</td></tr>  
            <tr><td>&emsp;&emsp;&emsp;&emsp;}</td></tr>  
            <tr><td>&emsp;&emsp;}</td></tr> 
            <tr><td>&emsp;&emsp;swap(&arr[i + 1], &arr[high]);</td></tr>  
            <tr><td>&emsp;&emsp;return(i + 1);</td></tr> 
            <tr><td>}</td></tr>
            <tr><td><div class="codecomment">/* The main function that implements QuickSort() </div> </td></tr> 
 <tr><td><div class="codecomment">arr[] --> Array to be sorted, </div> </td></tr> 
 <tr><td><div class="codecomment">low  --> Starting index, </div> </td></tr> 
 <tr><td><div class="codecomment">high  --> Ending index */</div> </td></tr> 
            <tr><td>void quickSort(int arr[], int low, int high)  </td></tr>  
            <tr><td>{</td></tr> 
            <tr><td>&emsp;&emsp;if (low < high)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;/* pi is partitioning index, arr[pi] is </div>  </td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;now at right place */</div> </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;&emsp;int pi = partition(arr, low, high);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// Separately sort elements before</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;&emsp;// partition and after partition</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;quickSort(arr, low, pi - 1);</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;quickSort(arr, pi + 1, high);</td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}</td></tr>
        </table>',' <table>
            <tr><td><div class="codecomment">/* This function takes last element as pivot,</div> </td></tr>
 <tr><td><div class="codecomment">places the pivot element at its correct </div>  </td></tr> 
 <tr><td><div class="codecomment">position in sorted array, and places all </div>  </td></tr> 
 <tr><td><div class="codecomment">smaller (smaller than pivot) to left of </div>  </td></tr> 
 <tr><td><div class="codecomment">pivot and all greater elements to right </div>  </td></tr> 
 <tr><td><div class="codecomment">&emsp;of pivot */ </div> </td></tr> 
 <tr><td>function partition(arr,  low, high)  </td></tr> 
 <tr><td>{  </td></tr> 
 <tr><td>&emsp;var pivot = arr[high];   </td></tr> 
 <tr><td><div class="codecomment">&emsp;// index of smaller element </div> </td></tr> 
 <tr><td>&emsp;var i = (low-1); </td></tr> 
 <tr><td>&emsp;for (var j=low; j<high; j++)  </td></tr> 
 <tr><td>&emsp;{  </td></tr> 
  <tr><td><div class="codecomment">&emsp;&emsp;// If current element is smaller than the pivot </div> </td></tr> 
 <tr><td>&emsp;&emsp;if (arr[j] < pivot)  </td></tr> 
 <tr><td>&emsp;&emsp;{  </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;i++;   </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// swap arr[i] and arr[j] </div> </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;var temp = arr[i];  </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;arr[i] = arr[j];  </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;arr[j] = temp;  </td></tr> 
 <tr><td>&emsp;&emsp;}  </td></tr> 
 <tr><td>&emsp;}</td></tr> 
 <tr><td><div class="codecomment">&emsp;// swap arr[i+1] and arr[high] (or pivot) </div> </td></tr> 
 <tr><td>&emsp;var temp = arr[i+1];  </td></tr> 
 <tr><td>&emsp;arr[i+1] = arr[high];  </td></tr> 
 <tr><td>&emsp;arr[high] = temp;  </td></tr> 
 <tr><td>&emsp;return i+1;  </td></tr> 
 <tr><td>}  </td></tr> 
<tr><td><div class="codecomment">/* The main function that implements QuickSort() </div> </td></tr> 
 <tr><td><div class="codecomment">arr[] --> Array to be sorted, </div> </td></tr> 
 <tr><td><div class="codecomment">low  --> Starting index, </div> </td></tr> 
 <tr><td><div class="codecomment">high  --> Ending index */</div> </td></tr> 
<tr><td>function quicksort(arr, low, high)  </td></tr> 
<tr><td>{  </td></tr> 
 <tr><td>&emsp;if (low < high)  </td></tr> 
<tr><td>&emsp;{  </td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;/* pi is partitioning index, arr[pi] is </div>  </td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;now at right place */</div> </td></tr> 
 <tr><td>&emsp;&emsp;var pi = partition(arr, low, high);   </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// Recursively sort elements before </div> </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// partition and after partition </div> </td></tr> 
 <tr><td>&emsp;&emsp;sort(arr, low, pi-1);  </td></tr> 
 <tr><td>&emsp;&emsp;sort(arr, pi+1, high);  </td></tr> 
  <tr><td>&emsp;} </td></tr> 
<tr><td>}</td></tr>          
        </table>','<div class="algoName"> 
Quick Sort
</div> Quicksort is a divide and conquer algorithm. It first divides a large list into two smaller sub-lists and then recursively sort the two sub-lists.

<span id="dots">...</span><br><br><span id="more">
<br> Quicksort, like mergesort, is a divide-and-conquer recursive algorithm. The basic divide-and-conquer process for sorting a subarray S[p..r] is summarized in the following three easy steps:
Divide: Partition S[p..r] into two subarrays S[p..q-1] and S[q+1..r] such that each element of S[p..q-1] is less than or equal to S[q], which is, in turn, less than or equal to each element of S[q+1..r]. Compute the index q as part of this partitioning procedure
Conquer: Sort the two subarrays S[p...q-1] and S[q+1..r] by recursive calls to quicksort.
Combine: Since the subarrays are sorted in place, no work is needed to combing them: the entire array S is now sorted.
<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n*log(n))</div> 
<div class="average"> Average: O(n*log(n))</div>
<div class="worstcase"> Worst Case: O(n^2)</div></span>
',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/quick-sort/','',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Simple Selection Sort','<table><tr id="line_1"><td>for (int i = 0; i < array.length - 1; i++)  {</td></tr><tr id="line_2"><td>&emsp;&emsp;int index = i;</td></tr><tr id="line_3"><td>&emsp;&emsp;for (int j = i + 1; j < array.length; j++){</td></tr><tr id="line_4"><td>&emsp;&emsp;&emsp;&emsp;if (array[j] < array[index]){</td></tr><tr id="line_5"><td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;index = j;  </td></tr><tr id="line_6"><td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_7"><td>&emsp;&emsp;}</td></tr><tr id="line_8"> <td>&emsp;&emsp;int smallerNumber = array[index];</td></tr><tr id="line_9"> <td>&emsp;&emsp;array[index] = array[i];</td></tr><tr id="line_10"> <td>&emsp;&emsp;array[i] = smallerNumber; </td></tr><tr id="line_11"> <td>}</td></tr></table>','<table>
            <tr><td>void swap(int *xp, int *yp)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int temp = *xp;  </td></tr>  
            <tr><td>&emsp;&emsp;*xp = *yp;  </td></tr>  
            <tr><td>&emsp;&emsp;*yp = temp;  </td></tr>  
            <tr><td>}   </td></tr>  
            <tr><td>void selectionSort(int arr[], int n)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int i, j, min_idx;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// One by one move boundary of unsorted subarray </div> </td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n-1; i++)          </td></tr>
            <tr><td>&emsp;&emsp;{  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Find the minimum element in unsorted arraye </div> </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;min_idx = i;   </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;for (j = i+1; j < n; j++)  </td></tr>  
            <tr><td>&emsp;&emsp;&emsp;if (arr[j] < arr[min_idx])  </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;&emsp;min_idx = j;   </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Swap the found minimum element with the first element </div> </td></tr>            
            <tr><td>&emsp;&emsp;&emsp;swap(&arr[min_idx], &arr[i]);</td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}   </td></tr>          
        </table>','  <table>
            <tr><td>void selctionSort(arr) </td></tr>   
  <tr><td>{ </td></tr>   
   <tr><td>&emsp;&emsp;var n = arr.length; </td></tr>   
   <tr><td><div class="codecomment">&emsp;&emsp;// One by one move boundary of unsorted sub-array </div></td></tr>   
    <tr><td>&emsp;&emsp;for (var i = 0; i < n-1; i++) </td></tr>   
   <tr><td>&emsp;&emsp;{ </td></tr>   
   <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Find the minimum element in unsorted array </div></td></tr>   
  <tr><td>&emsp;&emsp;&emsp;var min_idx = i; </td></tr>   
  <tr><td>&emsp;&emsp;&emsp;for (var j = i+1; j < n; j++) </td></tr>   
   <tr><td>&emsp;&emsp;&emsp;&emsp;if (arr[j] < arr[min_idx]) </td></tr>   
   <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;min_idx = j;  </td></tr>   
    <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Swap the found minimum element with the first </div></td></tr>   
    <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// element </div> </td></tr>   
   <tr><td>&emsp;&emsp;&emsp;var temp = arr[min_idx]; </td></tr>   
    <tr><td>&emsp;&emsp;&emsp;arr[min_idx] = arr[i]; </td></tr>   
   <tr><td>&emsp;&emsp;&emsp;arr[i] = temp; </td></tr>   
    <tr><td>&emsp;&emsp;} </td></tr>   
   <tr><td>}      </td></tr>          
        </table>','<div class="algoName"> 
Selection Sort
</div> The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning.
<span id="dots">...</span><br><br><span id="more">
<br>Selection sort is the most conceptually simple of all the sorting algorithms. It works by selecting the smallest (or largest, if you want to sort from big to small) element of the array and placing it at the head of the array. Then the process is repeated for the remainder of the array; the next largest element is selected and put into the next slot, and so on down the line.
<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n^2)</div> 
<div class="average"> Average: O(n^2)</div>
<div class="worstcase"> Worst Case: O(n^2)</div></span>
',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/selection-sort/','selectionsort',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Heap Sort','<table>
             <tr><td>public void sort(int arr[])  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int n = arr.length;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Build heap (rearrange array)</div></td></tr>
            <tr><td>&emsp;&emsp;for (int i = n / 2 - 1; i >= 0; i--)</td></tr> 
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, n, i);          </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// One by one extract an element from heap</div></td></tr>
            <tr><td>&emsp;&emsp;for (int i=n-1; i>0; i--)</td></tr> 
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Move current root to end</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;int temp = arr[0];          </td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[0] = arr[i];          </td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[i] = temp;          </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// call max heapify on the reduced heap</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, i, 0);          </td></tr> 
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}   </td></tr>
            <tr><td><div class="codecomment">// To heapify a subtree rooted with node i which is  </div></td></tr>
            <tr><td><div class="codecomment">// an index in arr[]. n is size of heap  </div></td></tr>
            <tr><td>void heapify(int arr[], int n, int i)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Initialize largest as root</div></td></tr>
            <tr><td>&emsp;&emsp;int largest = i;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// left = 2*i + 1</div></td></tr>
            <tr><td>&emsp;&emsp;int l = 2*i + 1;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// right = 2*i + 2</div></td></tr>
            <tr><td>&emsp;&emsp;int r = 2*i + 2;  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// If left child is larger than root</div></td></tr>
            <tr><td>&emsp;&emsp;if (l < n && arr[l] > arr[largest])  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;  largest = l;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// If right child is larger than largest so far</div></td></tr>
            <tr><td>&emsp;&emsp;if (r < n && arr[r] > arr[largest])  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;largest = r;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// If largest is not root</div></td></tr>
            <tr><td>&emsp;&emsp;if (largest != i)  </td></tr>
            <tr><td>&emsp;&emsp;{  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;int swap = arr[i];  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[i] = arr[largest];  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[largest] = swap;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Recursively heapify the affected sub-tree</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, n, largest);  </td></tr>
            <tr><td>&emsp;&emsp;}  </td></tr>
            <tr><td>}   </td></tr>  
        </table>','<table>
            <tr><td><div class="codecomment">// To heapify a subtree rooted with node i which is  </div></td></tr>
            <tr><td><div class="codecomment">// an index in arr[]. n is size of heap  </div></td></tr>
            <tr><td>void heapify(int arr[], int n, int i)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Initialize largest as root</div></td></tr>
            <tr><td>&emsp;&emsp;int largest = i;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// left = 2*i + 1</div></td></tr>
            <tr><td>&emsp;&emsp;int l = 2*i + 1;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// right = 2*i + 2</div></td></tr>
            <tr><td>&emsp;&emsp;int r = 2*i + 2;  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// If left child is larger than root</div></td></tr>
            <tr><td>&emsp;&emsp;if (l < n && arr[l] > arr[largest])  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;largest = l;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// If right child is larger than largest so far</div></td></tr>
            <tr><td>&emsp;&emsp;if (r < n && arr[r] > arr[largest])  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;largest = r;  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// If largest is not root</div></td></tr>
            <tr><td>&emsp;&emsp;if (largest != i)  </td></tr>
            <tr><td>&emsp;&emsp;{  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;  swap(arr[i], arr[largest]);  </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Recursively heapify the affected sub-tree</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, n, largest);  </td></tr>
            <tr><td>&emsp;&emsp;}  </td></tr>
            <tr><td>}   </td></tr>  
            <tr><td><div class="codecomment">// main function to do heap sort</div></td></tr>  
            <tr><td>void heapSort(int arr[], int n)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Build heap (rearrange array)</div></td></tr>
            <tr><td>&emsp;&emsp;for (int i = n / 2 - 1; i >= 0; i--)</td></tr> 
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, n, i);          </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// One by one extract an element from heap</div></td></tr>
            <tr><td>&emsp;&emsp;for (int i=n-1; i>0; i--)</td></tr> 
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Move current root to end</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;swap(arr[0], arr[i]);          </td></tr> 
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// call max heapify on the reduced heap</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;heapify(arr, i, 0);</td></tr> 
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}   </td></tr>          
        </table>','<table>
            <tr><td> function heapSort(arr) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td>&emsp;var n = arr.length; </td></tr>  
<tr><td><div class="codecomment">&emsp;// Build heap (rearrange array) </div></td></tr>  
 <tr><td>&emsp;for (var i = n / 2 - 1; i >= 0; i--) </td></tr>  
 <tr><td>&emsp;&emsp;heapify(arr, n, i); </td></tr>  
 <tr><td><div class="codecomment">&emsp;// One by one extract an element from heap </div></td></tr>  
 <tr><td>&emsp;for (var i=n-1; i>0; i--) </td></tr>  
 <tr><td>&emsp;{ </td></tr>  
 <tr><td><div class="codecomment">&emsp;&emsp;// Move current root to end </div></td></tr>  
  <tr><td>&emsp;&emsp;var temp = arr[0]; </td></tr>  
  <tr><td>&emsp;&emsp;arr[0] = arr[i]; </td></tr>  
  <tr><td>&emsp;&emsp;arr[i] = temp; </td></tr>  
 <tr><td><div class="codecomment">&emsp;&emsp;// call max heapify on the reduced heap</div> </td></tr>  
  <tr><td>&emsp;&emsp;heapify(arr, i, 0); </td></tr>  
 <tr><td>&emsp;} </td></tr>  
 <tr><td>}  </td></tr>  
 <tr><td><div class="codecomment">// To heapify a subtree rooted with node i which is</div> </td></tr>  
<tr><td><div class="codecomment">// an index in arr[]. n is size of heap </div></td></tr>  
<tr><td>function heapify(arr, n,  i) </td></tr>  
<tr><td>{ </td></tr>  
 <tr><td><div class="codecomment">&emsp;// Initialize largest as root </div></td></tr>  
 <tr><td>&emsp;var largest = i; </td></tr>  
 <tr><td><div class="codecomment">&emsp;// left = 2*i + 1 </div> </td></tr>  
<tr><td>&emsp;var l = 2*i + 1; </td></tr>  
<tr><td><div class="codecomment">&emsp;// right = 2*i + 2 </div> </td></tr>  
 <tr><td>&emsp;var r = 2*i + 2; </td></tr>  
 <tr><td><div class="codecomment">&emsp;// If left child is larger than root </div></td></tr>  
 <tr><td>&emsp;if (l < n && arr[l] > arr[largest]) </td></tr>  
 <tr><td>&emsp;&emsp;largest = l;  </td></tr>  
 <tr><td><div class="codecomment">&emsp;// If right child is larger than largest so far</div> </td></tr>  
 <tr><td>&emsp;if (r < n && arr[r] > arr[largest]) </td></tr>  
 <tr><td>&emsp;&emsp;largest = r;   </td></tr>  
 <tr><td><div class="codecomment">&emsp;// If largest is not root </div></td></tr>  
 <tr><td>&emsp;if (largest != i) </td></tr>  
 <tr><td>&emsp;{ </td></tr>  
 <tr><td>&emsp;&emsp;var swap = arr[i]; </td></tr>  
 <tr><td>&emsp;&emsp;arr[i] = arr[largest]; </td></tr>  
  <tr><td>&emsp;&emsp;arr[largest] = swap;  </td></tr>  
<tr><td><div class="codecomment">&emsp;&emsp;// Recursively heapify the affected sub-tree </div></td></tr>  
 <tr><td>&emsp;&emsp;heapify(arr, n, largest); </td></tr>  
 <tr><td>&emsp;} </td></tr>  
 <tr><td>}  </td></tr>          
        </table>','<div class="algoName"> 
Heap Sort
</div> Heap sort is a comparison based sorting technique based on Binary Heap data structure.
<span id="dots">...</span><br><br><span id="more">

<br>Perhaps the simplest of these algorithms is heap sort, which is based on the heap data structure. The first important thing to remember about heaps is that the top element of the heap is always "next" in order (either the next highest or next lowest, in the case of numbers).
<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n*log(n))</div> 
<div class="average"> Average: O(n*log(n))</div>
<div class="worstcase"> Worst Case: O(n*log(n))</div></span>
',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/heap-sort/','',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Simple Insertion Sort','<table><tr id="line_1"> <td>for (int i = 1; i < arr.length; ++i) {</td></tr><tr id="line_2"> <td>&emsp;&emsp;int key = arr[i];</td></tr><tr id="line_3"> <td>&emsp;&emsp;int j = i - 1;</td></tr><tr id="line_4"> <td>&emsp;&emsp;while (j >= 0 && arr[j] > key) {</td></tr><tr id="line_5"> <td>&emsp;&emsp;&emsp;&emsp;arr[j + 1] = arr[j];</td></tr><tr id="line_6"> <td>&emsp;&emsp;&emsp;&emsp;j = j - 1;</td></tr><tr id="line_7"> <td>&emsp;&emsp;}</td></tr><tr id="line_8"> <td>&emsp;&emsp;arr[j + 1] = key;</td></tr><tr id="line_9"> <td>}</td></tr></table>','<table>
            <tr><td><div class="codecomment">/* Function to sort an array using insertion sort*/</div></td></tr>
            <tr><td>void insertionSort(int arr[], int n)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int i, key, j;</td></tr> 
            <tr><td>&emsp;&emsp;for (i = 1; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td>&emsp;&emsp;&emsp;key = arr[i];         </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;j = i - 1;         </td></tr> 
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;/* Move elements of arr[0..i-1], that are</div></td></tr>
<tr><td><div class="codecomment">&emsp;&emsp;&emsp;greater than key, to one position ahead</div> </td></tr>
<tr><td><div class="codecomment">&emsp;&emsp;&emsp;of their current position */</div> </td></tr>
            <tr><td>&emsp;&emsp;&emsp;while (j >= 0 && arr[j] > key)   </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;&emsp;arr[j + 1] = arr[j]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;j = j - 1; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr> 
            <tr><td>&emsp;&emsp;&emsp;arr[j + 1] = key; </td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}   </td></tr>          
        </table>','   <table>
            <tr><td><div class="codecomment">/*Function to sort array using insertion sort*/ </div> </td></tr>    
  <tr><td>void insertionSort(arr) </td></tr>    
  <tr><td>{ </td></tr>    
   <tr><td>&emsp;var n = arr.length; </td></tr>    
   <tr><td>&emsp;for (var i = 1; i < n; ++i) { </td></tr>    
  <tr><td>&emsp;&emsp;var key = arr[i]; </td></tr>    
 <tr><td>&emsp;&emsp;var j = i - 1;  </td></tr>    
   <tr><td><div class="codecomment">&emsp;&emsp;/* Move elements of arr[0..i-1], that are </div></td></tr>    
  <tr><td><div class="codecomment">&emsp;&emsp;greater than key, to one position ahead  </div></td></tr>    
  <tr><td><div class="codecomment">&emsp;&emsp;of their current position */   </div></td></tr>    
   <tr><td>&emsp;&emsp;while (j >= 0 && arr[j] > key) { </td></tr>    
   <tr><td>&emsp;&emsp;&emsp;arr[j + 1] = arr[j]; </td></tr>    
  <tr><td>&emsp;&emsp;&emsp;j = j - 1; </td></tr>    
 <tr><td>&emsp;} </td></tr>    
 <tr><td>&emsp;arr[j + 1] = key; </td></tr>    
  <tr><td>&emsp;}  </td></tr>    
  <tr><td>}   </td></tr>          
        </table>','<div class="algoName"> 
Insertion Sort
</div> Insertion sort is a simple sorting algorithm that works the way we sort playing cards in our hands.
<span id="dots">...</span><br><br><span id="more">
<br> Insertion sort does exactly what you would expect: it inserts each element of the array into its proper position, leaving progressively larger stretches of the array sorted.

<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n)</div> 
<div class="average"> Average: O(n^2)</div>
<div class="worstcase"> Worst Case: O(n^2)</div></span>
',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/insertion-sort/','insertionsort',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Merge Sort','<table>
            <tr><td><div class="codecomment">// Merges two subarrays of arr[].</div></td></tr>
            <tr><td><div class="codecomment">// First subarray is arr[l..m]</div></td></tr>
            <tr><td><div class="codecomment">// Second subarray is arr[m+1..r]</div></td></tr>
            <tr><td>void merge(int arr[], int l, int m, int r)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Find sizes of two subarrays to be merged</div></td></tr>
            <tr><td>&emsp;&emsp;int n1 = m - l + 1;</td></tr>
            <tr><td>&emsp;&emsp;int n2 =  r - m;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* create temp arrays */</div></td></tr>
            <tr><td>&emsp;&emsp;int L[] = new int [n1]; </td></tr>
            <tr><td>&emsp;&emsp;int R[] = new int [n2]; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Copy data to temp arrays L[] and R[] */</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n1; ++i) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;L[i] = arr[l + i]; </td></tr>
            <tr><td>&emsp;&emsp;for (j = 0; j < n2; ++j) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;R[j] = arr[m + 1+ j];</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Merge the temp arrays back into arr[l..r]*/</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Initial indexes of first and second subarrays </div></td></tr>
            <tr><td>&emsp;&emsp;int i = 0, j = 0; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Initial index of merged subarray</div></td></tr>
            <tr><td>&emsp;&emsp;k = l; </td></tr>
            <tr><td>&emsp;&emsp;while (i < n1 && j < n2)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (L[i] <= R[j]) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;arr[k] = L[i]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;i++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr>
            <tr><td>&emsp;&emsp;&emsp;else </td></tr>
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;arr[k] = R[j]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;j++;  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td><div class="codecomment"><br>&emsp;&emsp;/* Copy remaining elements of L[] if any */</div></td></tr>
            <tr><td>&emsp;&emsp;while (i < n1)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[k] = L[i]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;i++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td><div class="codecomment"><br>&emsp;&emsp;/* Copy remaining elements of R[] if any */</div></td></tr>
            <tr><td>&emsp;&emsp;while (j < n2)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[k] = R[j]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;j++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td>}   </td></tr> 
            <tr><td><div class="codecomment">// Main function that sorts arr[l..r] using merge()</div></td></tr>
            <tr><td>void sort(int arr[], int l, int r)</td></tr> 
            <tr><td>{   </td></tr> 
            <tr><td>&emsp;&emsp;if (l < r)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Find the middle point </div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;int m = (l+r)/2;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Sort first and second halves</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;sort(arr, l, m); </td></tr>
            <tr><td>&emsp;&emsp;&emsp;sort(arr , m+1, r); </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Merge the sorted halves</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp; merge(arr, l, m, r);</td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td>}   </td></tr> 
        </table>','<table>
            <tr><td><div class="codecomment">// Merges two subarrays of arr[].</div></td></tr>
            <tr><td><div class="codecomment">// First subarray is arr[l..m]</div></td></tr>
            <tr><td><div class="codecomment">// Second subarray is arr[m+1..r]</div></td></tr>
            <tr><td>void merge(int arr[], int l, int m, int r)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int i, j, k;</td></tr>
            <tr><td>&emsp;&emsp;int n1 = m - l + 1;</td></tr>
            <tr><td>&emsp;&emsp;int n2 =  r - m;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* create temp arrays */</div></td></tr>
            <tr><td>&emsp;&emsp;int L[n1], R[n2]; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Copy data to temp arrays L[] and R[] */</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n1; i++) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;L[i] = arr[l + i]; </td></tr>
            <tr><td>&emsp;&emsp;for (j = 0; j < n2; j++) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;R[j] = arr[m + 1+ j];</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Merge the temp arrays back into arr[l..r]*/</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Initial index of first subarray</div></td></tr>
            <tr><td>&emsp;&emsp;i = 0; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Initial index of second subarray</div></td></tr>
            <tr><td>&emsp;&emsp;j = 0; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Initial index of merged subarray</div></td></tr>
            <tr><td>&emsp;&emsp;k = l; </td></tr>
            <tr><td>&emsp;&emsp;while (i < n1 && j < n2)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (L[i] <= R[j]) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;arr[k] = L[i]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;i++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr>
            <tr><td>&emsp;&emsp;&emsp;else </td></tr>
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;arr[k] = R[j]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;j++;  </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Copy the remaining elements of L[], if there</div></td></tr>
<tr><td><div class="codecomment">&emsp;&emsp;are any */</div></td></tr>
            <tr><td>&emsp;&emsp;while (i < n1)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[k] = L[i]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;i++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;/* Copy the remaining elements of R[], if there</div></td></tr>
<tr><td><div class="codecomment">&emsp;&emsp;are any */</div></td></tr>
            <tr><td>&emsp;&emsp;while (j < n2)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[k] = R[j]; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;j++; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;k++; </td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td>}   </td></tr> 
            <tr><td><div class="codecomment">/* l is for left index and r is right index of the</div></td></tr>
<tr><td><div class="codecomment">&emsp;&emsp;sub-array of arr to be sorted */</div></td></tr>
            <tr><td>void mergeSort(int arr[], int l, int r)  </td></tr> 
            <tr><td>{   </td></tr> 
            <tr><td>&emsp;&emsp;if (l < r)</td></tr>
            <tr><td>&emsp;&emsp; {</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Same as (l+r)/2, but avoids overflow for</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// large l and h</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;int m = l+(r-l)/2; </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Sort first and second halves</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;mergeSort(arr, l, m); </td></tr>
            <tr><td>&emsp;&emsp;&emsp;mergeSort(arr, m+1, r); </td></tr>
            <tr><td>&emsp;&emsp;&emsp;merge(arr, l, m, r); </td></tr>
            <tr><td>&emsp;&emsp; }</td></tr>
            <tr><td>}   </td></tr> 
        </table>','<table>
            <tr><td><div class="codecomment">// Merges two subarrays of arr[]. </td></tr>
 <tr><td><div class="codecomment">// First subarray is arr[l..m] </td></tr>
 <tr><td><div class="codecomment">// Second subarray is arr[m+1..r] </td></tr>
 <tr><td>function merge(arr, l, m, r) </td></tr>
 <tr><td>{ </td></tr>
 <tr><td><div class="codecomment">&emsp;// Find sizes of two subarrays to be merged </td></tr>
 <tr><td>&emsp;var n1 = m - l + 1; </td></tr>
 <tr><td>&emsp;var n2 = r - m; </td></tr>
  <tr><td><div class="codecomment">&emsp;/* Create temp arrays */</td></tr>
  <tr><td>&emsp;var L=new Array(n1); </td></tr>
 <tr><td>&emsp;var R= new Array(n2); </td></tr>
 <tr><td><div class="codecomment">&emsp;/*Copy data to temp arrays*/</td></tr>
 <tr><td>&emsp;for (var i= 0; i<n1; ++i) </td></tr>
 <tr><td>&emsp;&emsp;L[i] = arr[l + i]; </td></tr>
 <tr><td>&emsp;for (var j= 0; j<n2; ++j) </td></tr>
 <tr><td>&emsp;&emsp;R[j] = arr[m + 1+ j];   </td></tr>
 <tr><td><div class="codecomment">&emsp;/* Merge the temp arrays */</td></tr>
<tr><td><div class="codecomment">&emsp;// Initial indexes of first and second subarrays </td></tr>
 <tr><td>&emsp;var i = 0, j = 0;   </td></tr>
<tr><td><div class="codecomment">&emsp;// Initial index of merged subarry array </td></tr>
 <tr><td>&emsp;var k = l; </td></tr>
 <tr><td>&emsp;while (i < n1 && j < n2) </td></tr>
 <tr><td>&emsp;{ </td></tr>
  <tr><td>&emsp;&emsp;if (L[i] <= R[j]) </td></tr>
  <tr><td>&emsp;&emsp;{ </td></tr>
 <tr><td>&emsp;&emsp;&emsp;arr[k] = L[i]; </td></tr>
 <tr><td>&emsp;&emsp;&emsp;i++; </td></tr>
 <tr><td>&emsp;&emsp;} </td></tr>
 <tr><td>&emsp;&emsp;else</td></tr>
 <tr><td>&emsp;&emsp;{ </td></tr>
  <tr><td>&emsp;&emsp;&emsp;arr[k] = R[j]; </td></tr>
  <tr><td>&emsp;&emsp;&emsp;j++; </td></tr>
  <tr><td>&emsp;&emsp;} </td></tr>
 <tr><td>&emsp;&emsp;k++; </td></tr>
 <tr><td>&emsp;}  </td></tr>
 <tr><td><div class="codecomment">&emsp;/* Copy remaining elements of L[] if any */</td></tr>
<tr><td>&emsp;while (i < n1) </td></tr>
 <tr><td>&emsp;{ </td></tr>
  <tr><td>&emsp;&emsp;arr[k] = L[i]; </td></tr>
  <tr><td>&emsp;&emsp;i++; </td></tr>
  <tr><td>&emsp;&emsp;k++; </td></tr>
  <tr><td>&emsp;}  </td></tr>
 <tr><td><div class="codecomment">&emsp;/* Copy remaining elements of R[] if any */</td></tr>
 <tr><td>&emsp;while (j < n2) </td></tr>
  <tr><td>&emsp;{ </td></tr>
  <tr><td>&emsp;&emsp;arr[k] = R[j]; </td></tr>
   <tr><td>&emsp;&emsp;j++; </td></tr>
 <tr><td>&emsp;&emsp;k++; </td></tr>
 <tr><td>&emsp;} </td></tr>
 <tr><td>}  </td></tr>
 <tr><td><div class="codecomment">// Main function that sorts arr[l..r] using </td></tr>
 <tr><td><div class="codecomment">// merge() </td></tr>
<tr><td>function sort(arr, l, r) </td></tr>
<tr><td>{ </td></tr>
 <tr><td>&emsp;if (l < r) </td></tr>
 <tr><td>&emsp;{ </td></tr>
 <tr><td><div class="codecomment">&emsp;&emsp;// Find the middle point </td></tr>
 <tr><td>&emsp;&emsp;var m = (l+r)/2;   </td></tr>
 <tr><td><div class="codecomment">&emsp;&emsp;// Sort first and second halves </td></tr>
 <tr><td>&emsp;&emsp;sort(arr, l, m); </td></tr>
 <tr><td>&emsp;&emsp;sort(arr , m+1, r);  </td></tr>
 <tr><td><div class="codecomment">&emsp;&emsp;// Merge the sorted halves </td></tr>
 <tr><td>&emsp;&emsp;merge(arr, l, m, r); </td></tr>
 <tr><td>&emsp;} </td></tr>
 <tr><td>}  </td></tr>          
        </table>','<div class="algoName"> 
Merge Sort
</div> Merge sort is the second guaranteed O(nlog(n)) sort we will look at. Like heap sort, merge sort requires additional memory proportional to the size of the input for scratch space, but, unlike heap sort, merge sort is stable, meaning that "equal" elements are ordered the same once sorting is complete.
<span id="dots">...</span><br><br><span id="more">

<br> Merge sort works using the principle that if you have two sorted lists, you can merge them together to form another sorted list. Consequently, sorting a large list can be thought of as a problem of sorting two smaller lists and then merging those two lists together.
<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case: O(n*log(n))</div> 
<div class="average"> Average: O(n*log(n))</div>
<div class="worstcase"> Worst Case: O(n*log(n))</div></span>
.',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/merge-sort/','',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Radix Sort','<table>
            <tr><td><div class="codecomment">// A utility function to get maximum value in arr[] \.</div></td></tr>
            <tr><td>int getMax(int arr[], int n) </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int mx = arr[0];</td></tr>
            <tr><td>&emsp;&emsp;for (int i = 1; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[i] > mx)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;mx = arr[i];</td></tr>
            <tr><td>&emsp;&emsp;return mx; </td></tr>
            <tr><td>}</td></tr>
            <tr><td><div class="codecomment">// A function to do counting sort of arr[] according to</div></td></tr>
            <tr><td><div class="codecomment">// the digit represented by exp.</div></td></tr>
            <tr><td>void countSort(int arr[], int n, int exp) </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// output array</div></td></tr>
            <tr><td>&emsp;&emsp;int output[] = new int[n];</td></tr>
            <tr><td>&emsp;&emsp;int i;</td></tr>
            <tr><td>&emsp;&emsp;int count[] = new int[10];</td></tr>
            <tr><td>&emsp;&emsp;Arrays.fill(count,0);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Store count of occurrences in count[]</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[ (arr[i]/exp)%10 ]++;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Change count[i] so that count[i] now contains actual</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;//  position of this digit in output[]</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 1; i < 10; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[i] += count[i - 1];</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Build the output array</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = n - 1; i >= 0; i--)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td>&emsp;&emsp;&emsp;output[count[ (arr[i]/exp)%10 ] - 1] = arr[i];</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[ (arr[i]/exp)%10 ]--; </td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Copy the output array to arr[], so that arr[] now</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// contains sorted numbers according to current digit</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[i] = output[i];</td></tr>
            <tr><td>}</td></tr>
            <tr><td><div class="codecomment">// The main function to that sorts arr[] of size n using </div></td></tr>
            <tr><td><div class="codecomment">// Radix Sort</div></td></tr>
            <tr><td>static void radixsort(int arr[], int n) </td></tr>
            <tr><td>{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Find the maximum number to know number of digits</div></td></tr>
            <tr><td>&emsp;&emsp;int m = getMax(arr, n);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Do counting sort for every digit. Note that instead</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// of passing digit number, exp is passed. exp is 10^i </div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// where i is current digit number </div></td></tr>
            <tr><td>&emsp;&emsp;for (int exp = 1; m/exp > 0; exp *= 10)</td></tr>
            <tr><td>&emsp;&emsp;countSort(arr, n, exp);</td></tr>
            <tr><td>}</td></tr>
        </table>','<table>
            <tr><td><div class="codecomment">// A utility function to get maximum value in arr[] \.</div></td></tr>
            <tr><td>int getMax(int arr[], int n) </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int mx = arr[0];</td></tr>
            <tr><td>&emsp;&emsp;for (int i = 1; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[i] > mx)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;mx = arr[i];</td></tr>
            <tr><td>&emsp;&emsp;return mx; </td></tr>
            <tr><td>}</td></tr>
            <tr><td><div class="codecomment">// A function to do counting sort of arr[] according to</div></td></tr>
            <tr><td><div class="codecomment">// the digit represented by exp.</div></td></tr>
            <tr><td>void countSort(int arr[], int n, int exp) </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// output array</div></td></tr>
            <tr><td>&emsp;&emsp;int output[n];</td></tr>
            <tr><td>&emsp;&emsp;int i, count[10] = {0};</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Store count of occurrences in count[]</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[ (arr[i]/exp)%10 ]++;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Change count[i] so that count[i] now contains actual</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;//  position of this digit in output[]</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 1; i < 10; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[i] += count[i - 1];</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Build the output array</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = n - 1; i >= 0; i--)</td></tr>
            <tr><td>&emsp;&emsp;{</td></tr>
            <tr><td>&emsp;&emsp;&emsp;output[count[ (arr[i]/exp)%10 ] - 1] = arr[i];</td></tr>
            <tr><td>&emsp;&emsp;&emsp;count[ (arr[i]/exp)%10 ]--; </td></tr>
            <tr><td>&emsp;&emsp;}</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Copy the output array to arr[], so that arr[] now</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// contains sorted numbers according to current digit</div></td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;arr[i] = output[i];</td></tr>
            <tr><td>}</td></tr>
            <tr><td><div class="codecomment">// The main function to that sorts arr[] of size n using </div></td></tr>
            <tr><td><div class="codecomment">// Radix Sort</div></td></tr>
            <tr><td>void radixsort(int arr[], int n)  </td></tr>
            <tr><td>{</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Find the maximum number to know number of digits</div></td></tr>
            <tr><td>&emsp;&emsp;int m = getMax(arr, n);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Do counting sort for every digit. Note that instead</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// of passing digit number, exp is passed. exp is 10^i </div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// where i is current digit number </div></td></tr>
            <tr><td>&emsp;&emsp;for (int exp = 1; m/exp > 0; exp *= 10)</td></tr>
            <tr><td>&emsp;&emsp;countSort(arr, n, exp);</td></tr>
            <tr><td>}</td></tr>
        </table>','<table>
            <tr><td><div class="codecomment">// A utility function to get maximum value in arr[] </div></td></tr>  
<tr><td>function getMax(arr,  n) </td></tr>  
 <tr><td>{ </td></tr>  
 <tr><td>&emsp;var mx = arr[0]; </td></tr>  
 <tr><td>&emsp;for (var i = 1; i < n; i++) </td></tr>  
 <tr><td>&emsp;if (arr[i] > mx) </td></tr>  
<tr><td>&emsp;&emsp;mx = arr[i]; </td></tr>  
<tr><td>&emsp;return mx; </td></tr>  
<tr><td>}  </td></tr>  
<tr><td><div class="codecomment">// A function to do counting sort of arr[] according to  </div></td></tr>  
 <tr><td><div class="codecomment">// the digit represented by exp.  </div></td></tr>  
 <tr><td>function countSort(arr,  n, exp) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td><div class="codecomment">&emsp;// output array  </div></td></tr>  
 <tr><td>&emsp;var output= new Array(n); </td></tr>  
<tr><td>&emsp;var i; </td></tr>  
<tr><td>&emsp;var count = new Array(10);</td></tr>  
<tr><td>&emsp;Arrays.fill(count,0); </td></tr>  
<tr><td><div class="codecomment">&emsp;// Store count of occurrences in count[]  </div></td></tr>  
<tr><td>&emsp;for (i = 0; i < n; i++) </td></tr>  
<tr><td>&emsp;&emsp;count[ (arr[i]/exp)%10 ]++;  </td></tr>  
 <tr><td><div class="codecomment">&emsp;// Change count[i] so that count[i] now contains </div> </td></tr>  
 <tr><td><div class="codecomment">&emsp;// actual position of this digit in output[]  </div></td></tr>  
<tr><td>&emsp;for (i = 1; i < 10; i++) </td></tr>  
<tr><td>&emsp;&emsp;count[i] += count[i - 1]; </td></tr>  
<tr><td><div class="codecomment">&emsp;// Build the output array </div> </td></tr>  
 <tr><td>&emsp;for (i = n - 1; i >= 0; i--) </td></tr>  
 <tr><td>&emsp;{ </td></tr>  
 <tr><td>&emsp;&emsp;output[count[ (arr[i]/exp)%10 ] - 1] = arr[i]; </td></tr>  
 <tr><td>&emsp;&emsp;count[ (arr[i]/exp)%10 ]--; </td></tr>  
 <tr><td>&emsp;}  </td></tr>  
 <tr><td><div class="codecomment">&emsp;// Copy the output array to arr[], so that arr[] now  </div></td></tr>  
 <tr><td><div class="codecomment">&emsp;// contains sorted numbers according to curent digit </div> </td></tr>  
 <tr><td>&emsp;for (i = 0; i < n; i++) </td></tr>  
  <tr><td>&emsp;&emsp;arr[i] = output[i]; </td></tr>  
 <tr><td>}  </td></tr>  
<tr><td><div class="codecomment">// The main function to that sorts arr[] of size n using  </div></td></tr>  
<tr><td><div class="codecomment">// Radix Sort  </div></td></tr>  
<tr><td>function radixsort(arr,  n) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td><div class="codecomment">&emsp;// Find the maximum number to know number of digits </div> </td></tr>  
 <tr><td>&emsp;var m = getMax(arr, n);  </td></tr>  
<tr><td><div class="codecomment">&emsp;// Do counting sort for every digit. Note that instead  </div></td></tr>  
<tr><td><div class="codecomment">&emsp;// of passing digit number, exp is passed. exp is 10^i </td></tr>  
<tr><td><div class="codecomment">&emsp;// where i is current digit number </td></tr>  
 <tr><td>&emsp;for (var exp = 1; m/exp > 0; exp *= 10) </td></tr>  
 <tr><td>&emsp;&emsp;countSort(arr, n, exp); </td></tr>  
 <tr><td>}   </td></tr>          
        </table>','<div class="algoName"> 
Radix Sort
</div> In computer science, radix sort is a non-comparative sorting algorithm. It avoids comparison by creating and distributing elements into buckets according to their radix. 
<span id="dots">...</span><br><br><span id="more">
<br> For elements with more than one significant digit, this bucketing process is repeated for each digit, while preserving the ordering of the prior step, until all digits have been considered. For this reason, radix sort has also been called bucket sort and digital sort.
<br><br>

<div class="algoName">
Internal sorting
</div> 
are type of sorting which is used when the entire collection of data is small enough that sorting can take place within main memory. There is no need for external memory for execution of sorting program. 
<br><br>
<div class="bestcase">Best Case:  N/A</div> 
<div class="average"> Average: N/A</div>
<div class="worstcase"> Worst Case: O(w*n) where w is the number of bits required to store each key.</div></span>
',1,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/radix-sort/','',0,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Linear Search','<table><tr id="line_1">  <td>for(int i = 0; i < array.length; i++) {</td></tr><tr id="line_2">  <td>&emsp;&emsp;if(array[i] == x) {</td></tr><tr id="line_3">  <td>&emsp;&emsp;&emsp;&emsp;return i;</td></tr><tr id="line_4">  <td>&emsp;&emsp;} </td></tr><tr id="line_5">  <td>}</td></tr><tr id="line_6">  <td>return -1;</td></tr></table>','<table>
            <tr><td><div class="codecomment">// C++ code to linearly search x in arr[]. If x</div></td></tr>
             <tr><td><div class="codecomment">// is present then return its location, otherwise</div></td></tr>
            <tr><td><div class="codecomment">// return -1 </div></td></tr>
            <tr><td>int search(int arr[], int n, int x)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;int i;</td></tr>
            <tr><td>&emsp;&emsp;for (i = 0; i < n; i++)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[i] == x)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;return i;</td></tr>
            <tr><td>&emsp;&emsp;return -1; </td></tr>
            <tr><td>}</td></tr>
            
        </table>','<table>
            <tr><td>function linearSearch(arr, n, searchvalue) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td>&emsp;var i; </td></tr>  
 <tr><td>&emsp;for (i = 0; i < n; i++) </td></tr>  
 <tr><td><div class="codecomment">&emsp;&emsp;//found search value </div></td></tr>  
 <tr><td>&emsp;&emsp;if (arr[i] == searchvalue)  {</td></tr>  
<tr><td>&emsp;&emsp;&emsp;return i; </td></tr>  
 <tr><td>&emsp;&emsp;}</td></tr>  
 <tr><td><div class="codecomment">&emsp;//not found search value </div></td></tr>  
<tr><td>&emsp;return -1;</td></tr>  
<tr><td>}    </td></tr>          
        </table>','<div class="algoName"> 
Linear Search
</div> In computer science, a linear search or sequential search is a method for finding an element within a list. It sequentially checks each element of the list until a match is found or the whole list has been searched.
<span id="dots">...</span><br><br><span id="more">
<br>A linear search runs in at worst linear time and makes at most n comparisons, where n is the length of the list.
<br><br>
<div class="algoName">
Algorithms for searching for a key 
</div> 
in an array that has been ordered by numerical values assigned to the keys (key values)<br><br>
<div class="bestcase">Best Case: O(1) </div> 
<div class="average"> Average: O(n) </div>
<div class="worstcase"> Worst Case: O(n) </div></span>
',5,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/linear-search/','linearsearch',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Binary Search','<table><tr id="line_1"> <td>int binarySearch(int arr[], int left, int right, int x) { </td></tr><tr id="line_2"> <td>&emsp;&emsp;if (right >= left) {</td></tr><tr id="line_3"> <td>&emsp;&emsp;&emsp;&emsp;int mid = left + (right - l) / 2; </td></tr><tr id="line_4"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[mid] == x) {</td></tr><tr id="line_5"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return mid; </td></tr><tr id="line_6"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_7"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[mid] > x) {</td></tr><tr id="line_8"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return binarySearch(arr, left, mid - 1, x);</td></tr><tr id="line_9"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_10"> <td>&emsp;&emsp;&emsp;&emsp;return binarySearch(arr, mid + left, right, x);</td></tr><tr id="line_11"> <td>&emsp;&emsp;} </td></tr><tr id="line_12"> <td>&emsp;&emsp;return -1;</td></tr><tr id="line_13"> <td>}</td></tr></table>','<table>
            <tr><td><div class="codecomment">// A recursive binary search function. It returns</div></td></tr>
             <tr><td><div class="codecomment">// location of x in given array arr[l..r] is present,</div></td></tr>
            <tr><td><div class="codecomment">// otherwise -1</div></td></tr>
            <tr><td>int binarySearch(int arr[], int l, int r, int x)  </td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td>&emsp;&emsp;if (r >= l) </td></tr>
            <tr><td>&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;int mid = l + (r - l) / 2;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// If the element is present at the middle</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// itself</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[mid] == x)</td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;return mid;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// If element is smaller than mid, then</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// it can only be present in left subarray</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[mid] > x) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;return binarySearch(arr, l, mid - 1, x);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Else the element can only be present</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// in right subarray</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;return binarySearch(arr, mid + 1, r, x);</td></tr>
            <tr><td>&emsp;&emsp;} </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// We reach here when element is not</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// present in array</div></td></tr>
            <tr><td>&emsp;&emsp;return -1; </td></tr>
            <tr><td>}</td></tr>
            
        </table>','<table>
            <tr><td><div class="codecomment">// A recursive binary search function. It returns </div></td></tr> 
<tr><td><div class="codecomment">// location of search value in given array arr[l..r] is present,</div> </td></tr> 
<tr><td><div class="codecomment">// otherwise -1 </div></td></tr> 
<tr><td>function binarySearch(arr,l, r,searchvalue) </td></tr> 
<tr><td>{ </td></tr> 
 <tr><td>&emsp;if (r >= l) { </td></tr> 
<tr><td>&emsp; &emsp;var mid = l + (r - l) / 2; </td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;// If the element is present at the middle </div></td></tr> 
<tr><td><div class="codecomment">&emsp;&emsp;// itself </div></td></tr> 
<tr><td>&emsp;&emsp;if (arr[mid] == searchvalue) </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;return mid;  </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// If element is smaller than mid, then</div> </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// it can only be present in left subarray</div> </td></tr> 
 <tr><td>&emsp;&emsp;if (arr[mid] > searchvalue) </td></tr> 

 <tr><td>&emsp;&emsp;&emsp;return binarySearch(arr, l, mid - 1, searchvalue); </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// Else the element can only be present </div></td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// in right subarray </div></td></tr> 
 <tr><td>&emsp;&emsp;return binarySearch(arr, mid + 1, r, searchvalue); </td></tr> 
 <tr><td>&emsp;&emsp;}   </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// We reach here when element is not</div> </td></tr> 
 <tr><td><div class="codecomment">&emsp;&emsp;// present in array </div></td></tr> 

 <tr><td>&emsp;&emsp;return -1; </td></tr> 
<tr><td>} </td></tr>          
        </table>','<div class="algoName"> 
Binary Search
</div> In computer science, binary search, also known as half-interval search, logarithmic search,or binary chop, is a search algorithm that finds the position of a target value within a sorted array.
<span id="dots">...</span><br><br><span id="more">

<br>A linear search runs in at worst linear time and makes at most n comparisons, where n is the length of the list.Search a sorted array by repeatedly dividing the search interval in half. Begin with an interval covering the whole array. If the value of the search key is less than the item in the middle of the interval, narrow the interval to the lower half.
<br><br>
<div class="algoName">
Algorithms for searching for a key 
</div> 
in an array that has been ordered by numerical values assigned to the keys (key values)<br><br>
<div class="bestcase">Best Case: O(1) </div> 
<div class="average"> Average: O(log n)</div>
<div class="worstcase"> Worst Case: O(log n) </div></span>
',5,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/binary-search/','binarysearch',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Interpolation Search','<table><tr id="line_1"> <td>int interpolationSearch(int arr[], int x){ </td></tr><tr id="line_2"> <td>&emsp;&emsp;int lo = 0, hi = (arr.length - 1); </td></tr><tr id="line_3"> <td>&emsp;&emsp;while (lo <= hi && x >= arr[lo] && x <= arr[hi]){ </td></tr><tr id="line_4"> <td>&emsp;&emsp;&emsp;&emsp;if (lo == hi){ </td></tr><tr id="line_5"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;if (arr[lo] == x) {</td></tr><tr id="line_6"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return lo; </td></tr><tr id="line_7"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;{</td></tr><tr id="line_8"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return -1; </td></tr><tr id="line_9"> <td>&emsp;&emsp;&emsp;&emsp;} </td></tr><tr id="line_10"> <td>&emsp;&emsp;&emsp;&emsp;int pos = lo + (((hi - lo) / </td></tr><tr id="line_11"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;(arr[hi] - arr[lo])) * (x - arr[lo])); </td></tr><tr id="line_12"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[pos] == x){ </td></tr><tr id="line_13"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;return pos; </td></tr><tr id="line_14"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_15"> <td>&emsp;&emsp;&emsp;&emsp;if (arr[pos] < x){</td></tr><tr id="line_16"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;lo = pos + 1; </td></tr><tr id="line_17"> <td>&emsp;&emsp;&emsp;&emsp;} else{</td></tr><tr id="line_18"> <td>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;hi = pos - 1; </td></tr><tr id="line_19"> <td>&emsp;&emsp;&emsp;&emsp;}</td></tr><tr id="line_20"> <td>&emsp;&emsp;} </td></tr><tr id="line_21"> <td>&emsp;&emsp;return -1; </td></tr><tr id="line_22"> <td>}</td></tr></table>','<table>
            <tr><td><div class="codecomment">// If x is present in arr[0..n-1], then returns</div></td></tr>
            <tr><td><div class="codecomment">// index of it, else returns -1.</div></td></tr>
            <tr><td>int interpolationSearch(int arr[], int n, int x)</td></tr>  
            <tr><td>{  </td></tr>  
            <tr><td><div class="codecomment">&emsp;&emsp;// Find indexes of two corners</div></td></tr>
            <tr><td>&emsp;&emsp;int lo = 0, hi = (n - 1);</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// Since array is sorted, an element present</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;// in array must be in range defined by corner</div></td></tr>
            <tr><td>&emsp;&emsp;while (lo <= hi && x >= arr[lo] && x <= arr[hi]) </td></tr>
            <tr><td>&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;{ </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;if (lo == hi) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;if (arr[lo] == x) return lo; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;&emsp;return -1; </td></tr>
            <tr><td>&emsp;&emsp;&emsp;} </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Probing the position with keepingr</div></td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// uniform distribution in mind.</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;int pos = lo + (((double)(hi - lo) / </td></tr>
<tr><td>&emsp;&emsp;&emsp;&emsp;(arr[hi] - arr[lo])) * (x - arr[lo])); </td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// Condition of target found</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[pos] == x) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;return pos;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// If x is larger, x is in upper part</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;if (arr[pos] < x) </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;lo = pos + 1;</td></tr>
            <tr><td><div class="codecomment">&emsp;&emsp;&emsp;// If x is smaller, x is in the lower part</div></td></tr>
            <tr><td>&emsp;&emsp;&emsp;else </td></tr>
            <tr><td>&emsp;&emsp;&emsp;&emsp;hi = pos - 1;</td></tr>
            <tr><td>&emsp;&emsp;} </td></tr>
            <tr><td>&emsp;&emsp;return -1; </td></tr>
            <tr><td>}</td></tr>

        </table>','<table>
 <tr><td><div class="codecomment">// If search value is present in arr[0..n-1], then returns </div></td></tr> 
 <tr><td><div class="codecomment">// index of it, else returns -1. </div></td></tr> 
 <tr><td>function interpolationSearch(arr,searchvalue) </td></tr> 
 <tr><td>{ </td></tr> 
 <tr><td><div class="codecomment">&emsp;// Find indexes of two corners </div></td></tr> 
 <tr><td>&emsp;var lo = 0, hi = (arr.length - 1);       </td></tr> 
 <tr><td><div class="codecomment">&emsp;// Since array is sorted, an element present </div></td></tr> 
 <tr><td><div class="codecomment">&emsp;// in array must be in range defined by corner </div></td></tr> 
 <tr><td>&emsp;while (lo <= hi && searchvalue >= arr[lo] && searchvalue <= arr[hi]) </td></tr> 
 <tr><td>&emsp;{         </td></tr> 
 <tr><td>&emsp;if (lo == hi) </td></tr> 
 <tr><td>&emsp; { </td></tr> 
  <tr><td>&emsp;&emsp;if (arr[lo] == searchvalue) return lo; </td></tr> 
  <tr><td>&emsp;&emsp;return -1; </td></tr> 
  <tr><td>&emsp;}         </td></tr> 
 <tr><td><div class="codecomment">&emsp;// Probing the position with keeping </div></td></tr> 
 <tr><td><div class="codecomment">&emsp;// uniform distribution in mind.        </div>    </td></tr> 
 <tr><td>&emsp;var pos = lo + (((hi-lo) / </td></tr> 
 <tr><td>&emsp;&emsp;&emsp; (arr[hi]-arr[lo]))*(searchvalue - arr[lo]));      </td></tr>   
<tr><td><div class="codecomment">&emsp;     // Condition of target found </div></td></tr> 
 <tr><td>&emsp;if (arr[pos] == searchvalue) </td></tr> 
 <tr><td>&emsp;&emsp;&emsp; return pos;</td></tr> 
 <tr><td><div class="codecomment">&emsp;// If searchvalue is larger, searchvalue is in upper part </div></td></tr> 
 <tr><td>&emsp;if (arr[pos] < searchvalue) </td></tr> 
 <tr><td>&emsp;&emsp;&emsp;lo = pos + 1;        </td></tr> 
 <tr><td><div class="codecomment">&emsp;// If search value is smaller, searchvalue is in the lower part </div></td></tr> 
 <tr><td>&emsp;else</td></tr> 
 <tr><td>&emsp;&emsp;&emsp;hi = pos - 1; </td></tr> 
 <tr><td>&emsp;&emsp;} </td></tr> 
 <tr><td><div class="codecomment">&emsp;//not found searchvalue </div></td></tr> 
<tr><td>&emsp;return -1; </td></tr> 
 <tr><td>}   </td></tr>          
        </table>','<div class="algoName"> 
Interpolation Search
</div> Interpolation search is an algorithm for searching for a key in an array that has been ordered by numerical values assigned to the keys (key values)
<span id="dots">...</span><br><br><span id="more">
<br> Interpolation search resembles the method by which people search a telephone directory for a name (the key value by which the books entries are ordered): in each step the algorithm calculates where in the remaining search space the sought item might be, based on the key values at the bounds of the search space and the value of the sought key, usually via a linear interpolation.
<br><br>


<div class="algoName">
Algorithms for searching for a key 
</div> 
in an array that has been ordered by numerical values assigned to the keys (key values)<br><br>
<div class="bestcase">Best Case: N/A </div> 
<div class="average"> Average: N/A</div>
<div class="worstcase"> Worst Case: O(n);
 however under the assumption of a uniform distribution of the data on the linear scale used for interpolation, the performance can be shown to be O(log log n) </div></span>
',5,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/interpolation-search/','interpolationsearch',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Separate chaining','<table><tr><td>public V get(K key) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td> int bucketIndex = getBucketIndex(key); </td></tr>  
<tr><td> HashNode&lt; K, V&gt; head = bucketArray.get(bucketIndex); </td></tr>  
<tr><td> while (head != null) </td></tr>  
<tr><td>  { </td></tr>  
<tr><td>    if (head.key.equals(key)) </td></tr>  
<tr><td>     return head.value; </td></tr>  
<tr><td>    head = head.next; </td></tr>  
<tr><td>  }   </td></tr>
<tr><td> return null; </td></tr>  
<tr><td>} </td></tr></table>',' <table>
            <tr><td>#include&lt;bits/stdc++.h> </td></tr>  
<tr><td>using namespace std;   </td></tr>  
<tr><td>class Hash </td></tr>  
<tr><td>{ </td></tr>  
<tr><td><div class="codecomment">&emsp;// No. of buckets </div> </td></tr>  
 <tr><td>&emsp;int BUCKET;     </td></tr>  
 <tr><td><div class="codecomment">&emsp;// Pointer to an array containing buckets </div> </td></tr>  
 <tr><td>&emsp;list<int> *table; </td></tr>  
<tr><td>public:</td></tr>  
<tr><td><div class="codecomment">&emsp;// Constructor   </div></td></tr>  
 <tr><td>&emsp;Hash(int V); </td></tr>  
 <tr><td><div class="codecomment">&emsp;// inserts a key into hash table  </div></td></tr>  
<tr><td>&emsp;void insertItem(int x);  </td></tr>  
<tr><td><div class="codecomment">&emsp;// deletes a key from hash table  </div></td></tr>  
<tr><td>&emsp;void deleteItem(int key);</td></tr>  
<tr><td><div class="codecomment">&emsp;// hash function to map values to key  </div></td></tr>  
 <tr><td>&emsp;int hashFunction(int x) { </td></tr>  
 <tr><td>&emsp;&emsp;return (x % BUCKET); </td></tr>  
 <tr><td>&emsp;} </td></tr>  
 <tr><td>&emsp;void displayHash(); </td></tr>  
 <tr><td>};  </td></tr>  
<tr><td>Hash::Hash(int b) </td></tr>  
<tr><td>{ </td></tr>  
<tr><td>&emsp;this->BUCKET = b; </td></tr>  
<tr><td>&emsp;table = new list&lt;int>[BUCKET]; </td></tr>  
<tr><td>} </td></tr>  
<tr><td>void Hash::insertItem(int key) </td></tr>  
<tr><td>{ </td></tr>  
 <tr><td>&emsp;int index = hashFunction(key); </td></tr>  
 <tr><td>&emsp;table[index].push_back(key);  </td></tr>  
<tr><td>} </td></tr>  
<tr><td>void Hash::deleteItem(int key) </td></tr>  
<tr><td>{ </td></tr>  
 <tr><td><div class="codecomment">&emsp;// get the hash index of key </div> </td></tr>  
 <tr><td>&emsp;int index = hashFunction(key);   </td></tr>  
 <tr><td><div class="codecomment">&emsp;// find the key in (index) list </div> </td></tr>  
 <tr><td>&emsp;list &lt;int> :: iterator i; </td></tr>  
 <tr><td>&emsp;for (i = table[index].begin(); </td></tr>  
 <tr><td>&emsp;&emsp;i != table[index].end(); i++) { </td></tr>  
 <tr><td>&emsp;if (*i == key) </td></tr>  
 <tr><td>&emsp;&emsp;break; </td></tr>  
 <tr><td>}  </td></tr>  
 <tr><td><div class="codecomment">&emsp;// if key is found in hash table, remove it  </div></td></tr>  
 <tr><td>&emsp;if (i != table[index].end()) </td></tr>  
 <tr><td>&emsp; table[index].erase(i); </td></tr>  
<tr><td>}  </td></tr>  
<tr><td><div class="codecomment">// function to display hash table </div> </td></tr>  
<tr><td>void Hash::displayHash() { </td></tr>  
<tr><td>&emsp;for (int i = 0; i < BUCKET; i++) { </td></tr>  
 <tr><td>&emsp;&emsp; cout << i; </td></tr>  
<tr><td>&emsp;for (auto x : table[i]) </td></tr>  
 <tr><td>&emsp;&emsp;&emsp;cout << " --> " << x; </td></tr>  
 <tr><td>&emsp;cout << endl; </td></tr>  
 <tr><td>&emsp;} </td></tr>  
<tr><td>}   </td></tr>           
        </table>','','<div class="algoName"> 
Separate chaining with linked lists
</div> In the method known as separate chaining, each bucket is independent, and has some sort of list of entries with the same index. The time for hash table operations is the time to find the bucket (which is constant) plus the time for the list operation.
<span id="dots">...</span><br><br><span id="more">
<br>Chained hash tables with linked lists are popular because they require only basic data structures with simple algorithms, and can use simple hash functions that are unsuitable for other methods.
<br><br>

<div class="algoName">
The idea of hashing
</div> 
is to distribute the entries (key/value pairs) across an array of buckets. Given a key, the algorithm computes an index that suggests where the entry can be found:

index = f(key, array_size)

Often this is done in two steps:

hash = hashfunc(key)
index = hash % array_size

In this method, the hash is independent of the array size, and it is then reduced to an index (a number between 0 and array_size − 1) using the modulo operator (%).

In the case that the array size is a power of two, the remainder operation is reduced to masking, which improves speed, but can increase problems with a poor hash function.<br><br>
<div class="bestcase">Best Case: N/A </div> 
<div class="average"> Average: O(1)</div>
<div class="worstcase"> Worst Case: O(n)</div></span>
',6,'2020-02-24 09:48:00.000','https://www.geeksforgeeks.org/implementing-our-own-hash-table-with-separate-chaining-in-java/?ref=rp','',1,0)
insert into Algorithm(algo_Name,algo_CodeJava,algo_CodeCplus,algo_CodeJS,algo_Description,category_ID,algo_DateTime,algo_Resource,algo_Files,algo_CompareStatus,delete_Status)
values('Open Addressing','<table><tr id="line_1"><td>  public int get(int key) {</td></tr>     
<tr id="line_2"><td>    int hash = (key % TABLE_SIZE);</td></tr>     
<tr id="line_3"><td>    int initialHash = -1;</td></tr>     
<tr id="line_4"><td>    while (hash != initialHash&amp;&amp; (table[hash] == DeletedEntry.getUniqueDeletedEntry() </td></tr>     
<tr id="line_5"><td>      || table[hash] != null &amp;&amp; table[hash].getKey() != key)) {</td></tr>     
<tr id="line_6"><td>      if (initialHash == -1)</td></tr>     
<tr id="line_7"><td>        initialHash = hash;</td></tr>     
<tr id="line_8"><td>      hash = (hash + 1) % TABLE_SIZE;</td></tr>     
<tr id="line_9"><td>    }</td></tr>     
<tr id="line_10"><td>    if (table[hash] == null || hash == initialHash)</td></tr>     
<tr id="line_11"><td>      return -1;</td></tr>     
<tr id="line_12"><td>    else</td></tr>     
<tr id="line_13"><td>      return table[hash].getValue();</td></tr>     
<tr id="line_14"><td>  }</td></tr></table>','<table><tr><td>int get(int key) {</td></tr> 
<tr><td> int hash = (key % TABLE_SIZE);</td></tr> 
<tr><td> int initialHash = -1;</td></tr> 
<tr><td>    while (hash != initialHash &amp;&amp; (table[hash] == DeletedEntry::getUniqueDeletedEntry() || table[hash] != NULL</td></tr> 
<tr><td>    &amp;&amp; table[hash]-&gt;getKey() != key)) {</td></tr> 
<tr><td>      if (initialHash == -1)</td></tr> 
<tr><td>        initialHash = hash;</td></tr> 
<tr><td>        hash = (hash + 1) % TABLE_SIZE;</td></tr> 
<tr><td>      }</td></tr> 
<tr><td>      if (table[hash] == NULL || hash == initialHash)</td></tr> 
<tr><td>        return -1;</td></tr> 
<tr><td>      else</td></tr> 
<tr><td>        return table[hash]-&gt;getValue();</td></tr>   
<tr><td>  }</td></tr></table>','','<div class="algoName"> 
Open addressing - Linear probing
</div> In a good hash table, each bucket has zero or one entries, and sometimes two or three, but rarely more than that. Therefore, structures that are efficient in time and space for these cases are preferred.<span id="dots">...</span><br><br><span id="more">
<br> Structures that are efficient for a fairly large number of entries per bucket are not needed or desirable. If these cases happen often, the hashing function needs to be fixed.
<br> Each cell of a hash table stores a single key–value pair. When the hash function causes a collision by mapping a new key to a cell of the hash table that is already occupied by another key, linear probing searches the table for the closest following free location and inserts the new key there.
<br><br>

<div class="algoName">
The idea of hashing
</div> 
is to distribute the entries (key/value pairs) across an array of buckets. Given a key, the algorithm computes an index that suggests where the entry can be found:

index = f(key, array_size)

Often this is done in two steps:

hash = hashfunc(key)
index = hash % array_size

In this method, the hash is independent of the array size, and it is then reduced to an index (a number between 0 and array_size − 1) using the modulo operator (%).

In the case that the array size is a power of two, the remainder operation is reduced to masking, which improves speed, but can increase problems with a poor hash function.<br><br>
<div class="bestcase">Best Case: N/A </div> 
<div class="average"> Average: O(1)</div>
<div class="worstcase"> Worst Case: O(n)</div></span>

',6,'2020-02-24 09:48:00.000','http://www.algolist.net/Data_structures/Hash_table/Open_addressing','openaddressing_hash',1,0)


select * from Algorithm