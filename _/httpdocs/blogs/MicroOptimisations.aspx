<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MicroOptimisations.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Blog - Kakariki - Micro Optimisations</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="optimizations java merdgesort" />	
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
						<h1>Micro-Optimisations in Merdge Sort</h1>
						<p class="date">Sun 27th March 2011</p>
						<div class="sep"></div>
						<p>
                            When to do micro optimisations?</br>
                            Back in 1974 the learned Donald Knuth said:
                        </p>
                        
                            <blockquote>
                                "Premature optimization is the root of all evil (or at least most of it) in programming."
                            </blockquote>
                            <em>Computer Programming as an Art (1974) p671</em>.
                        <p>
                            This I agree with whole heartaly, with an emphasis on the premature,
                            once you have selected an efficent algorithium, worked out it algorithmic compexity, 
                            implemented this is cleanest most maintainable code you can, timed it on a working set
                            of the same order of magnatude as you will run it. Then and only then it is the time to
                            look into micro optimisation. 
                        </p>
                        
                        <p>
                            With that said (and your pinches of salt prepared) I would like to share some interesting
                            measurement I made when comparing two <strong>almost</strong> identical implementations
                            of the same optimised merdge sort.         
                        </p>
                        
                        <p>
                            A bit of back-ground. Last year I applied for (and got woot!) a job at Google.
                            I read in <a href="http://steve-yegge.blogspot.com/2008/03/get-that-job-at-google.html">Get that job at Google</a>
                            that I must prepare and that I should be able to produce a O(n*log(n)) sort on command.
                            It's been a while since university. So I went to practicing, 
                            one of the sorts I practiced was merdge sort. Just to make sure I had it down I did it twice.
                            Implementing the same algorithium, with the same algorithmic (macro) optimisations. 
                            I ran them both through my testing frame work and they took different times to compleat.     
                        </p>

                        <p>
                            One of my two algorithems was finishing 5-10% faster then my other implementation.
                            Can you guess which was faster 
                            <a href="MicroOptimisations/MerdgeSortOne.java">MerdgeSortOne.java</a>
                            <a href="MicroOptimisations/MerdgeSortTwo.java">MerdgeSortTwo.java</a>
                            ?
                        </p>

                        <p>Pause and wait for you to read the two merdge implementations.</p>
                        <p>...</p>

<script type="text/javascript"><!--
google_ad_client = "ca-pub-3054505571765751";
/* Text Add */
google_ad_slot = "6808512844";
google_ad_width = 120;
google_ad_height = 240;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
                        
                        <p>
                            David Waters<br />
                            www.kakariki.co.uk.
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
