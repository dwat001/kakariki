<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Metabase.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Blog - Kakariki - WebCamps London – Urban Food Swap</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="WebCamps London MVC" />	
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
						<h1>WebCamps London – Urban Food Swap</h1>
						<p class="date">Sun 6th June 2010</p>
						<div class="sep"></div>
						<p>
						    The last two days I have been at a really cool course put on for free by Microsoft, <a href="http://www.webcamps.ms/#london_panel">Web Camp London</a>.
						    This covered the changes to Asp.Net WebForms in 4.0 and a basic introduction to MVC 2, which is now shipping with Visual Studio 2010. The course
						    was incredably well structured, the Friday was learning, Saturday was doing.
						</p>
						<p>
						    On Friday there was the usual mix of talk/slides/coding followed by the audience pitching idea to work on for Saturday. Twenty two ideas were pitched then voted on and teams formed.						    
                        </p>    
                        <p>
                            Saturday was when I got the most value. In the small teams we had formed on Friday we got stuck in and
                            coded up the ideas that we had pitched on the Friday. Starting from 'File > New Project' and building up working websites
                            using the latest technology stacks. 
                        </p>
                        <h3>Urban Food Swap</h3>
                        <p>
                            In the team I joined we were working on Tom's idea of a website where people who grow their own food can give or
                            trade excess food with people in their area. The team were given six hours and six people, GO!    
                        </p>
                        
                        <p>
                            We quickly whacked out some wireframes, decided on the technology, set up Source Control (<a href="http://www.visualsvn.com/server/">Visual SVN</a> free, easy to setup) 
                            and set up a shared DB, took a screen each and started coding.  
                            The setup was not quite as easy as suggested due to an "interesting" wireless network which filtered an unknown set of ports and dropped connections
                            silently if you did not make frequent requests.
                        </p>
                        <p>
                            The technology we used:
                        </p>
                        <ul>
                            <li>ASP.NET 4 - MVC 2</li>
                            <li>ADO.Net Entity Data Model</li>
                            <li>MS-SQL Server Express</li>
                            <li>jQuery jQueryUI</li>
                            <li>Bing Maps</li>
                            <li>Visual Studio 2010 Express Edition</li>
                        </ul>
                         <p>
                            One very gratifing thing was that we found no impediment using the Express Edition of 
                            Visual Studio, it was nice to be trying the new stack without having to fork out for MSDN or Visual Studio licences.
                        </p>
                        <p>
                            Five hours of coding later, due to some pretty awesome team work and a person with a strong vision (go Tom!)
                            we had a (mostly) working website. Reading and writing from the database, integrating with BingMaps, 
                            jQuery datepickers, RSS feeds, and even a IE8 webslice (thanks <a href="http://nerddinner.codeplex.com/" target="_blank">Nerd Dinner</a> We even had a rare thing -
                            a developer with a sence of aesthetic, so the end result looked very nice and didn't just use MVC default styles.
                        </p>
                        <p>
                            And a quick touch of what the site looked like, click on images for a larger view
                            <a href="WebCampsLondon/HomePage.png" target="_blank"><img src="WebCampsLondon/HomePageSmall.png" alt="Screen shot of Home Page" title="Home Page" /></a>
                            <a href="WebCampsLondon/OfferPage.png" target="_blank"><img src="WebCampsLondon/OfferPageSmall.png" alt="Screen shot of Offer Page" title="Offer Food"/></a>
                            <a href="WebCampsLondon/ProfilePage.png" target="_blank"><img src="WebCampsLondon/ProfilePageSmall.png" alt="Screen shot of Profile Page" title="Profile Page"/></a>
                            <a href="WebCampsLondon/RequestPage.png" target="_blank"><img src="WebCampsLondon/RequestPageSmall.png" alt="Screen shot of Request Page" title="Take up the offer"/></a>
                        </p>
                        
                        <p>
                            We even got a nice bag for coming first equal in the little competition between teams :)
                        </p>
                        
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
} catch(err) {}</script>
</body>
</html>
