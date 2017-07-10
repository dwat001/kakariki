<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HumanReadableSerializer.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Blog - Kakariki - Human Readable Serializer</title>
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
			<li><a href="~/index.html" runat="server"><span>HOME</span></a></li>
			<li><a href="~/people.html" runat="server"><span>PEOPLE</span></a></li>
			<li class="current"><a href="~/blog.html" runat="server"><span>BLOG</span></a></li>
			<li><a href="~/contact.html" runat="server"><span>CONTACT</span></a></li>
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
						<h1>Human Readable Serializer</h1>
						<p class="date">Wed 16th September 2009</p>
						<div class="sep"></div>
						<p>
                        Welcome to my little weekend project, two weekends so far and may not be many 
                        more. We will see.</p>
                        <p>
                            The problem I was trying to solve:
                            <br />
                            The testers are my current contract are being required to test webServices and 
                            web services that have lots of information passed in as a object model.
                        </p>
                        <p>
                        The testers are not coders andThese testers are not coders and do not like xml so I wanted a simple and easy 
                            way of them being able to write to a values to a text file and for me to turn 
                            this into .net objects to send to the web service. Once I have the reply back 
                            from the the WebService I want to be able to put the response into the same 
                            format.</p>
                        <p>    
                            As these are webservices exposing already present business logic the pace of 
                            adding webserives is quick. trying to catch up with the 40 or so complex methods 
                            that are all ready being used. So I don&#39;t want to have to hand crank pretty 
                            print and parse for each of these messages and all the classes that are getting 
                            passed back and forth.     After a conversation with the testers they are happy with a dot seperated text 
                        file e.g.</p><pre>
Example.Foo.Bar.RequestDate=2008-09-15 23:18:00
Example.Foo.Bar.NumberOfFish=12
Example.Foo.Bar.NameOfPet=George
</pre>
                        <p>
                        Which reads as a programmer would read a dotty semi colon langauge (c++, java, 
                        c#) ordered age before beauty).</p>
                        
                        <p>
                        For each message I will hand crank the first example so I do allow my self lines 
                        of nonsense which the users can ignore . e.g.</p><pre>
Example.Foo.Barr:uk.co.kakariki.ExampleClass</pre>
                        <p>
                        A line with a colon in it is a type declaration and could read</p><pre>
Example.Foo.Barr = new uk.co.kakariki.ExampleClass();</pre>
                        <p>
                        Now this is not a complete serilizer nor do I intend it to ever be, but it 
                        should be good enough for the job at hand, useful enough to be a tool in the 
                        toolbox and complex enough not to write it many times.</p>
                        <h3>Current functionality</h3>
                        <p>
                         <strong>Defintions</strong>
                         <ul>
                         <li><em>Simple object</em>: One that we support</li>
                        <li><em>Simple object</em>: an object with a parameterless constructor and 
                        every meaningful field having a public read-writable property whose type is a 
                        SimpleObject, collection, array, generic collection or base type</li>
                        <li><em>basetype</em>: short,int,long,float,double,Date,Timespan, string</li>
                        </ul>
                        </p>
                        <p>
                        Given an object graph of simple objects we will traverse serialize and print the 
                        entire graph, then we will reverse the process and be able to recreate an 
                        equivalent object graph.</p>
                        <h3>Known Limitations</h3>
                        <p>There will be more limitations then this.</p>
                        <ul>
                        <li>No Loop detection, a pointing to b which points back at a will cause infinite 
                        loop. Hmm maybe I should add a max depth so we fail sooner.</li>
                        <li>We lose precision in real numbers. we just use the .tostring which in my local 
                        defaults to 7 significant figures.</li>
                        <li>float.maxValue double.max value will crash the system as they round to more 
                        the maxValue when printing</li>
                        <li>No Map or Set support</li>
                        <li>No support for multi dimensional arrays.</li>
                        <li>Dates lose precision</li>
                        <li>timespans lose precision.</li>
                        </ul>
                        <p>
                        All of these limitation are fixable with a little codding effort, but as they are not need for my current task and I'm a little short of project time I will declare this good enough for my current purpose. I fI ever need it do address more of these cases i should be easy work to extend it.
                        </p>
                        <p>
                            The code is up on sourceforge as project name <a href="http://sourceforge.net/projects/kakarikiserz/">kakarikiserz</a>
                        </p>
                        <p>
                        Have a happy day and drop me a note if you found this interesting or are using 
                        it..<br />
                        <br />
                        David Waters<br />
                        www.kakariki.co.uk.
                        </p>
						
                        </p>
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
                        <li><a href="~/blogs/Metabase.aspx" runat="server">The Database With in the Database – or the recurring Metabase</a><br /><span class="date">Wed 24th March 2010</span></li>					
						<li><a href="~/blogs/StackOverflowReputationGraph.aspx" runat="server">Javascript Graphing  of StackOverflows Reputation</a><br /><span class="date">Mon 15th March 2010</span></li>					
						<li><a href="~/blogs/HumanReadableSerializer.aspx" runat="server">Human Readable Serializer</a><br /><span class="date">Wed 16th September 2009</span></li>
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
} catch(err) {}</script>
</body>
</html>
