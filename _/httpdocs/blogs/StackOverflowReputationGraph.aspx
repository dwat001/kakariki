<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StackOverflowReputationGraph.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Blog - Kakariki - A London-based software development company</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />	
    <link href="../css/screen.css" rel="stylesheet" type="text/css" />
    <link href="/script/jquery.jqplot/jquery.jqplot.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/script/jquery-1.4.2.min.js" ></script>
    <script type="text/javascript" src="/script/jquery.jqplot/jquery.jqplot.js" ></script>
    <script type="text/javascript" src="/script/jquery.jqplot/plugins/jqplot.logAxisRenderer.js"></script>
    <script type="text/javascript" src="/script/jquery.jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
    <script type="text/javascript" src="/script/jquery.jqplot/plugins/jqplot.canvasAxisTickRenderer.js"></script>
    <script type="text/javascript" src="/script/jquery.jqplot/plugins/jqplot.highlighter.js"></script>
    <script type="text/javascript" src="/script/jquery.jqplot/plugins/jqplot.cursor.js"></script>
    <script type="text/javascript" src="/script/sof.js" ></script>
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
						<h1>Graphing StackOverflows Reputation</h1>
						<p class="date">Mon 15th March</p>
						<div class="sep"></div>
						<p>
						    UPDATE:Since I have written this I have found that StackOverflow make all their data
						    downloadedable with a creative commons licence at <a href="http://blog.stackoverflow.com/category/cc-wiki-dump/">StackOverflow Data Dump</a>
						    So my fun little screen scraper is of even less use. 						    
						</p>
						<p>For this weekends project, I decided I wanted to make a graph of the distibution 
                            of reputation within the stackoverflow comunity. I also felt the urg to play 
                            with javascript, so I tried to do it all in the browser with javascript, after 
                            being reminded of the cross site restriction I realised this was impossible and 
                            created a quick little IHttpHandler that did a screen scrape of the 
                            stackoverflow users page and returned JSON with the rank, reputation and name of 
                            all the users on a given page.
                            <br />
                            Here is a sample:</p>
                        <div class="jqPlot" id="chart1" style="height:300px; width:500px;"></div>
                                <script type="text/javascript">
            var plot4 = null;
            $(function() {
                var drawGraph = function(sof) {
                    $('#chart1').empty();
                    plot4 = $.jqplot('chart1', [sof.getDataAsList()], {
                        legend: { show: false, location: 'ne' },
                        title: 'Reputation Vs Rank on StackOverflow',
                        series: [{label:'reputation'}],
                        axes: {
                            xaxis: {
                                min: 10,
                                max: 100000,
                                renderer: $.jqplot.LogAxisRenderer,
                                userTicks: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, 200000],
                                tickDistribution: 'power',
                                rendererOptions: { tickRenderer: $.jqplot.CanvasAxisTickRenderer },
                                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                                labelOptions:{ angle: -45 },
                                tickOptions: { angle: -35 },
                                title:"Rank"
                            },
                            yaxis: { min: 10,
                            title:"Reputation",
                            max: 100000, 
                                renderer: $.jqplot.LogAxisRenderer, tickDistribution: 'power' }
                        },
                        highlighter: { sizeAdjust: 7.5 },
                        cursor: { show: false }
                    });
                }
                sof.onDataChanged = function(sof) {
                    drawGraph(sof);
                };

                var pagesToLoad = [1,4000,28,1000, 500, 2, 125, 3, 4, 5, 20, 40, 50, 60, 100, 110, 120, 180, 190, 200, 600,
                                    700, 900, 2000,  3000,  ];
                sof.getPage(1);
                for (var key in pagesToLoad) {
                    sof.getPage(pagesToLoad[key]);
                }


            });
            
            
        </script>
                        <h3>Overview</h3>
                        <p>Libaries Used:
                            <ul>
                                <li>JQuery - For all its greatness</li>
                                <li>jqplot - a jQuery plugin for drawing graphs. I have yet to be convicenced this 
                                    is great. But it seemed to do the job here and was quick to get going</li>
                                <li>HtmlAgilityPack - to prevent me trying to use RegEx to parse html. This is a 
                                    full fledged html parser and made screen scrapping SOF as easy as remembering 
                                    XPath</li>
                            </ul>
                        </p>
                        <h3>Example Request</h3>
                        <p>
                            Client Side:<br />
                            The page is loaded with no data, the main javascript object "sof" get created and we bind the function drawGraph to its data changed event.
                            We then start a serries of getPage calles which use AJAX to fetch UserSummaries serilised as JSON. When the AJAX call compleates sof.data is updated
                            and drawGraph is called. <br />
                            The function
                            drawGraph shapes the data to what jqplot expects removes any existing graph (as jqplot does not seem to be able to)
                            and draws the graph with the current data. As the variouse getPages compleate the graph is updated.
                            <br />
                        </p>
                        <p>
                            Server Side:<br />
                            The hosting page does nothing fancy in fact it can be a static page. Each call 
                            of the javascript function getPage makes a call through to an IHttpHandler 
                            SOFPagedUserSummary with two optional parameters page and format. 
                            SOFPagedUserSummary parses the parameters then delegates to SOFPageFetch.<br />
                            SOFPageFetch checks to see if this page/format is in the cache (written to disk 
                            to out live worker process recycles)&nbsp; if present on disk we output the 
                            cached version. the heavy use of caching here is to prevent this project 
                            becoming a pain for StackOverflow.&nbsp; If not present in the cache we delegate 
                            to SOFNetPageFetcher which returns a List&lt;UserSummary&gt; these are then formatted 
                            with in HTML or JSON, this formatted output is cached on disk then returned to 
                            the client.<br />
                            SOFNetPageFetcher connect to the stackoverflow users page passing the page 
                            number through and parsers the returned html using the HtmlAgilityPack . We then 
                            procced to scrape the page using XPath to extract data on each of the 35 users 
                            returned, currently we are gathering rank, reputation and name. This is returned 
                            as a List&lt;UserSummary&gt; . SOFPageFetch
                            <pre>
HtmlWeb hw = new HtmlWeb();
HtmlDocument doc = hw.Load(
    String.Format(UserPage, pageNumber), "GET");
int rank = ((pageNumber - 1) * 35);

foreach (HtmlNode userInfo in 
  doc.DocumentNode.SelectNodes("//div[@class='user-info']"))
                            </pre>
                        </p>
                        
                        <p>
                            &nbsp;</p>
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
