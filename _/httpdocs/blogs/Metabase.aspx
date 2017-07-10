<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebCampsLondon.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Blog - Kakariki - The Database With in the Database – or the recurring Metabase</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />	
    <link href="../css/screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- BEGIN Header -->
<div class="header-wrap">
	<div class="header">
		<a name="pageTop"></a>
		<ul class="nav">
			<li><a id="A1" href="~/index.html" runat="server"><span>HOME</span></a></li>
			<li><a id="A2" href="~/people.html" runat="server"><span>PEOPLE</span></a></li>
			<li class="current"><a id="A3" href="~/blog.html" runat="server"><span>BLOG</span></a></li>
			<li><a id="A4" href="~/contact.html" runat="server"><span>CONTACT</span></a></li>
		</ul>
		<h2>Kakariki</h2>
	</div>
</div>
<!-- BEGIN Body -->
<div class="body-bg">
	<div class="body-wrap">
		<div class="body-pad">
			<p class="intro"><em>Our blog.</em> We live and breathe this stuff. Here we write musings on the subjects that matter.</p>
			<div class="col-med">
				<div class="panel-med-top"></div>
				<div class="panel-med bc">
					<div class="col-content">
						<h1>The Database With in the Database – or the recurring Metabase</h1>
						<p class="date">Wed 24th March 2010</p>
						<div class="sep"></div>
						<p>
                            For the fifth time in my career I am dealing with a database within the 
                            database and wishing people did it better before I got there. So here are some 
                            implementations and the pros &amp; cons of each. Followed by a controversial 
                            recommendation that the application should on the fly create database tables.</p>
                        
                            <h3>The Set Up</h3>
                            <p>
                            You have been given the brief to store data which the customer defines, at 
                            runtime, the shape of the data. Two example that I have dealt with are 
                            questionnaire surveys and Flexible field CRUD system.</p>
                        <p>
                            Questionnaire/Survey
                            <br />
                            The customer defines a number of questions, supplies an email list, you send the 
                            questionnaire to the participants, gather and collate the results, then report 
                            on the results of the survey, supplying the raw data and a number of user 
                            configurable reports.<br />
                            I have worked on questionnaire type systems with Advanced Management Systems, 
                            Answerview, Ubiquity, and Salmon</p>
                        <p>
                            Flexible Field CRUD ( Create Read Update Delete)</p>
                        <p>
                            The same software need to support different data collection policies for 
                            different organisations, fields and validation should be added to forms without 
                            a code change, and these fields and validation may be different for different 
                            organisations using the same deploy. This can also be used for rapid application 
                            development and extending existing systems.</p>
                        <p>
                            I have worked on Flexible Field systems with Applied Logic Systems, and Real 
                            Sports Ltd, and Boots.</p>
                        <p>
                            Though superficially different these two cases boil down to the same technical 
                            challengers. For the rest of this article I will deal with one concrete example, 
                            though all comments can equally be applied to either of the above scenarios.</p>
                        <p>
                            To give a concrete example I will talk about a Sports Player Registration 
                            System, the client is a highly hierarchical organisation e.g. 
                            National/State/Regional/Province/Club – There are different data collection 
                            policies for different types of registration [Coach, Referee, Player(Senior), 
                            Player(Junior )] and these data collection policies can change per 
                            State/Region/Provence. There is also reporting and performance requirements 
                            placed on the system. It soon becomes apparent that trying to hard code this 
                            many requirements is futile so we need to database drive what we store in the 
                            database.</p>
                        
                        <p>
                            I will now give an overview of two common approaches and present pros and cons 
                            for both.</p>
                        
                        <h3>
                            Naïve Object Oriented Approach.
                        </h3>
                        
                        <h3>
                          DB Structures</h3>
                        <pre>
MetaClass
    ClassId
    Name
    
MetaAttribute
    AttributeId
    ClassId (FK)
    Name
    DataType

ClassInstance
    ClassInstanceId
    ClassId(FK)

ClassInstanceAttributeValue
    ClassInstanceAttributeValue (PK)
    ClassInstanceId(FK)
    AttributeId (FK)
    ShortTextValue nvarchar(256)
    LongTextValue ntext
    DateValue
    IntValue
    FloatValue
                        </pre>
                        <p>
                            Please note that the ClassInstanceAttributeValue does not have only one value a 
                            String type but has a couple of different primitives, SQL data bases work much 
                            better when they know the type of the data they deal with, especially when 
                            comparing date&#39;s or numbers.</p>
                        <p>
                            Now when we wish to collect a new piece of data on an existing type all we need 
                            to do is add a row to the MetaAttribute table for the given MetaClass. This 
                            seems to work find on developers machines and makes since to OO people. The 
                            trouble starts when you start trying to do anything in volume, to add one record 
                            for a new registration now requires n+1 inserts where n is the number of 
                            attributes for that given type of registration. Not only that but every insert 
                            into our meta base, no matter which user defined schema the insert is for, will 
                            make multiple inserts into the same table the ClasInstanceAttrubuteValue table. 
                            This will cause hotspotting on this table and if you have chosen an autonumber 
                            of some sort as the primary key you will get table locking and rebalancing 
                            issues. These can somewhat be avoided using GUID as the primary key or just 
                            using a composite key.
                        </p>
                        
                        <p>
                            The insert performance of this structure is bad especially as you get more 
                            people inserting or updating data in the system. But where you really suffer is 
                            as soon as you try and report on this data. Let us look at a fictitious example, 
                            the given table would probably be done as a Hard table with user configurable 
                            extensions but we will use it as an example of how hard it is get to insert and 
                            report on any soft table.</p>
                        
                        <pre>
<strong>User Configured Table</strong>
Player
    DateOfBirth
    FirstName
    LastName
    ShoeSize
    Position
    ShirtNumber
    LastSatSafetyCourse
                        </pre>
                        <p>
                            There are now just 7 configured fields to insert one logical player record we 
                            need to insert 8 rows, one class instance and seven ClassInstanceAttributeValue</p>
                        <p>
                            Now a look at reporting using the same example suppose we wanted to select all 
                            the information for players who are under 12 and have not sat a safety course in 
                            the last 12 months. The pseudo code for what we want is:</p>
                        <pre>
select * from player 
    where DateOfBirth &gt; 23-MAR-1998 and 
    (LastSatSafetyCourse is null or 
     LastSatSafetyCourse &lt; 23-MAR-2009)</pre>
                        <p>
                            Which is all good, however the actual SQL needed would look more like this:
                        </p>                       
                        <pre>
-- select all the AttributeValues                        
select * from ClassInstanceAttributeValue allValues 
    -- for give instance
    where allValues.ClassInstanceId in ( 
      -- Where the instance has
      select ClassInstanceId 
      from ClassInstance instance inner join 
        ClassInstanceAttributeValue dob inner join
        ClassInstanceAttributeValue lastCourse 
        where
        dob.ClassInstanceId = instance.ClassInstanceId and
        -- DOB before &#39;98
        dob.DateValue &gt; 23-MAR-1998 and 
        dob.AttributeId = DATE_OF_BIRTH_ATT_ID and
        lastCourse.ClassInstanceId = 
            instance.ClassInstanceId and
        lastCourse.AttributeId =
            LAST_SAT_SAFTY_COURSE_ATT_ID and
        -- and has not sat a course recently
        (lastCourse.DateValue is null or 
         lastCourse.DateValue &lt; 23-MAR-2009) 
    ) 
    order by 
        allValues.ClassInstanceId, 
        allValues.AttributeId
                        </pre>
                            
                        <p>
                            This is horrible SQL doing four selects/joins from our two biggest tables, and 
                            we still don&#39;t have a record set anyone can use because it still has only one 
                            property per line and is not sorted by any field on the logical table. As the 
                            ClassInstanceAttributeValue table is generic to the system the only way we can 
                            add indexes, or SQL can create automatic indexes is have an index for each of 
                            the value types e.g.</p>
                        <pre>
create index on ClassInstanceAttributeValue include
  (ClassInstanceId, AttributeId, ShortTextValue);
create index on ClassInstanceAttributeValue include
  (ClassInstanceId, AttributeId, DateValue);
create index on ClassInstanceAttributeValue include
  (ClassInstanceId, AttributeId, IntValue);
create index on ClassInstanceAttributeValue include
  (ClassInstanceId, AttributeId, FloatValue);
                            </pre>
                        <p>
                            This number of indexes on a busy table is going to increase the cost of 
                            inserting once more, and remember we are already doing 7 inserts into this table 
                            for our example player, for every logical row we wish to insert.</p>
                        <p>
                            If you had only one value column you would get no indexing on dates or numbers.</p>
                        <p>
                            So is this approach worthless? No this approach can be acceptable on low volume 
                            solutions with very limited reporting requirements but start performance testing 
                            as soon as possible if not sooner. Throw in a million logical records and start 
                            seeing how long different select and inserts take.
                        </p>
                        <p>
                        </p>
                        <h3>
                            Programmatic Creation Of Tables</h3>
                        <p>
                            In this approach we will use the same tables for describing the data so we will 
                            use MetaClass and MetaAttribute, for this approach the initial creation of the 
                            use defined schema is the simple case so I will walk through this first and come 
                            back to the alteration of it. An administrator logs into your system and decides 
                            today is a nice day for a new user defined schema and goes ahead and uses your 
                            administrative interface adds a record to MetaClass and a number of records to 
                            MetaAttribute thereby defining the new schema. Once she clicks Save the system 
                            creates a new table as per the description of the schema. Lets run through that 
                            once more slower</p>
                        <ol>
                            <li>
                                User enters MetaClass and MetaAttribute information
                            </li>
                            <li>
                                User hit save
                            </li>
                            <li>
                                    The system chooses a DB connection that is privileged to be able to create 
                                    Tables.
                            </li>
                            <li>
                                    The system constructs a TableName say 
                                    [ClientOwner].[MetaClassId]_[MetaClass.Name] e.g. Acme.123_Person
                            </li>
                            <li>
                                    The system constructs a DDL specific to the DBMS we are running against to 
                                    create the new table. To ensure uniqueness we prepend the MetaAttribute.ID to 
                                    the name, more on this later. e.g. 
                                    <pre>
create table [Acme].[123_Person] 
    (101_DateOfBirth DateTime, 
     102_FirstName NvarChar(256), 
     103_LastName NvarChar(256), 
     104_Shoesize int, 
     105_Position NvarChar(256), 
     106_ShirtNumber int, 
     107_LastSatSaftyCourse DateTime)</pre>
                            </li>
                        </ol>
                        <p >
                            Now when it comes time to register a new player it is just one insert into the 
                            [Acme].[123_Person] table. And when it comes time to report from this table we 
                            can use simple SQL with very little modification</p>
                        <pre>select * from player 
    where DateOfBirth &gt; 23-MAR-1998 and 
    (LastSatSafetyCourse is null or 
     LastSatSafetyCourse &lt; 23-MAR-2009)</pre>
                        <p >
                            =&gt;</p>
<pre>select * from [Acme].[123_Person] 
    where 101_DateOfBirth &gt; 23-MAR-1998 and 
    (107_LastSatSafetyCourse is null or 
     107_LastSatSafetyCourse &lt; 23-MAR-2009)</pre>
                        <p>
                            Since this table is specific to this data most good DBMSs create good indexes on 
                            the fly, or if a table is under performing you can manually or programmatically 
                            add the appropriate indexes. Reports off this structure will be several orders 
                            of magnitude quicker then the previous solution. The number of possible 
                            updates/inserts per second of the logical structures will also be orders of 
                            magnitude better. We will now be able to utilise standard reporting tools which 
                            expect to find related data in the same row of a table. With good use of table 
                            owner we should even be able to give client access to their data without the 
                            possibility of them being able to access other clients data stored in the same 
                            system.</p>
                        <p>
                            Moving on to administrators updating the schema:</p>
                        <p>
                            Renames of columns are simple .. we don&#39;t, we just give the impression of having 
                            done so. To achieve this we add DBColumnName to the MetaAttribute table which is 
                            set once the table is created and not updated, the administrator can change the 
                            display name of the column and this will change throughout the system wherever 
                            it is displayed but the column in the database remains unchanged.</p>
                        <p>
                            Adding new columns is also easy once new columns are saved we add the 
                            appropreate rows to MetaAttribute and we generate a alter table statement which 
                            add the appropriate columns e.g.</p>
                        <pre>
alter table [Acme].[123_Person] 
    add(108_PreferedHalfTimeFruit nvarchar(256))</pre>
                        <p>
                            Deleting columns and tables is also easy, I myself would be inclinded to mark 
                            MetaClass or MetaAttribute as deleted but don&#39;t remove the data. Or at a minimum 
                            leave this in place for 1 month so data is not lost if a user makes a mistake 
                            and call customer service promptly.</p>
                        <p>
                            Modifying types of existing columns – I would suggest not allowing this, or only 
                            allowing by deleting and existing column and creating a new one. Otherwise the 
                            complexity of conversions would get … complex.</p>
                        <p>
                            Another pleasing aspect to this solution is that most of a clients data is 
                            stored in tables specific to that client allowing for business models like data 
                            size caps and charging per Mega Byte of DB storage. If relationships are 
                            possible between user defined schemas these can be easily managed by foreign key 
                            constraints , an approach that would be unworkable under the other approach.</p>
                        <p>
                            This approach has the disadvantage of your application having access to 
                            privileged accounts with the ability to create tables , this should first be 
                            addressed by ensuring that most DB connection from within your application do 
                            not use this privileged account. Then as the next more secure step you can have 
                            a privileged user per client who can create/alter table in there user space but 
                            not other users, application or dbo owned tables. The next step after that is to 
                            break the code that alters the DB into a separate small simple application that 
                            does just that and is run on a machine not addressable outside of your firewall, 
                            this could just periodically check for changes to the MetaClass or 
                            MetaAttributeTable or could have an interface which said checkForChangesNow.</p>
                        <p>
                            Another thing some people would hold against this is that all access to these 
                            tables would be through generated SQL which has the following perceived down 
                            sides</p>
                        <ol>
                            <li>
                                    Performance due to not being compiled like stored procs
                            </li>
                            <li>
                                    Performance due to not being editable by the DBA&#39;s
                            </li>
                            <li>
                                    Security due to SQL injection
                            </li>
                        </ol>
                        <p>
                            With prepared SQL statements utilising cached execution plans this price is only 
                            paid once when a statement is first prepared, from then on execution speeds are 
                            comparable to that of stored procs.</p>
                        <p>
                            Yes it is true DBA will not be able to hand tune individual queries other then 
                            by adding indexes, how ever with user defined data we should not be looking for 
                            human intervention so this is no great loss given these business requirements.</p>
                        <p>
                            With proper attention to detail, prepared statements and parameters passed as 
                            parameters not built into the SQL string this risk can be greatly alleviated and 
                            since we are not going to be building code that knows about any individual user 
                            defined schema this code will be very limited.</p>
                        <h3>
                            Recommendation</h3>
                        <p>
                            I think it will come as not surprise to anyone that has read the text before 
                            here that I recommend the best solution for allowing users to create there own 
                            schemas on the fly is to create database tables on the fly. As this is both the 
                            simpler and more performant method of the two analysed here. As an example half 
                            way through a conversion from the first approach to the second reports using the 
                            existing solution where taking over 90 seconds to run, creating a new table, 
                            moving data from ClassInstanceAttributeValue to the new table and running the 
                            report was taking approximately 31 seconds, 30 seconds to create the table and 
                            copy the data and 1 second to run the report. Of course moving forward we used 
                            the dynamically created table as the primary store so we no longer needed to 
                            spend that 30 seconds copying the data so we took that report from over 90 
                            seconds to under 1 second with out any tweaking, so if this was not fast enough 
                            we could of added indexes and such like to get more performance, but this was 
                            unnecessary.</p>
                        <p>
                            I hope you enjoyed this article if you have any comments or queries please get 
                            in touch.</p>
                        <p>
                            David Waters</p>
                        <p>
                            <a href="mailto:david.waters@kakariki.co.uk">david.waters@kakariki.co.uk</a></p>
					</div>
				</div>
				<div class="panel-med-btm"></div>
				<p class="btn floatRight"><a href="#"><span>Next article</span></a></p>
				<p class="btn-prev floatLeft"><a href="#"><span>Previous article</span></a></p>

			</div>
			<div class="sidebar">
				<div class="bloglist">
					<h2>Recent articles</h2>
					<ul>
					    <li><a id="A8" href="~/blogs/WebCampsLondon.aspx" runat="server">WebCamps London – Urban Food Swap</a><br /><span class="date">Sun 6th June 2010</span></li>
					    <li><a id="A5" href="~/blogs/Metabase.aspx" runat="server">The Database With in the Database – or the recurring Metabase</a><br /><span class="date">Wed 24th March 2010</span></li>
						<li><a id="A6" href="~/blogs/StackOverflowReputationGraph.aspx" runat="server">Javascript Graphing  of StackOverflows Reputation</a><br /><span class="date">Mon 15th March 2010</span></li>					
						<li><a id="A7" href="~/blogs/HumanReadableSerializer.aspx" runat="server">Human Readable Serializer</a><br /><span class="date">Wed 16th September 2009</span></li>
					</ul>

				</div>
			</div>
			<div class="clear"></div>
		</div>  <!-- CLOSE body-pad -->
	</div>  <!-- CLOSE body-wrap -->
</div>  <!-- CLOSE body-bg -->
<div class="footer-wrap">
	<div class="footer">
		<p class="floatRight">Contact: <a href="mailto:david.waters@kakariki.co.uk">david.waters@kakariki.co.uk</a></p>
		<p>Copyright &copy; Kakariki Ltd</p>
	</div>
</div>
<script src='http://www.google-analytics.com/ga.js' type='text/javascript'></script>
<script type="text/javascript">
    try {
        var pageTracker = _gat._getTracker("UA-15440154-1");
        pageTracker._trackPageview();
    } catch (err) { }</script>
</body>
</html>
