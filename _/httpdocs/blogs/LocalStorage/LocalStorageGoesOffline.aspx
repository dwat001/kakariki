<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocalStorageGoesOffline.aspx.cs" Inherits="wwwroot_blogs_StackOverflowReputationGraph" %>
<!DOCTYPE html>

<!-- manifest="Offline.manifest.aspx" -->
<html lang="en" >
<head>
	<title>Blog - Kakariki - Html5 and Local storage goes offLine  </title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />	
    <link href="../../css/screen.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/script/jquery-1.4.2.min.js" ></script>
    <script src="Modernizer.js" type="text/javascript"></script>
    <style>
        span.readonly
        {
            display:block;
            border:1px solid transparent;
            padding:2px;
        }
        
        div.bc table td input,
        span.readonly
        {
            width : 60px;
        }
        div.bc ul.nobullet
        {
            margin-left:0px;
        }
        div.bc ul.nobullet li
        {
            background : none;
            padding-left : 0px;
        }
    </style>
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
						<h1>Html5 and Local storage goes offLine</h1>
						<p class="date">27 June 2011</p>
						<div class="sep"></div>
						<form id="personForm">
                            <p>People: <span data-bind="text: people().length">&nbsp;</span></p>
                            <table>
                                <caption>Form For User Edit</caption>
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Name</th>
                                        <th>Age</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody data-bind='template: { name: "personRowTemplate", foreach: people }'></tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4">&nbsp;</td>
                                        <td>
                                            <button data-bind="click: addPerson">Add Person</button>
                                            <button data-bind="click: saveLocal">Save Local</button>
                                            <button data-bind="click: clearLocal">Clear Local</button>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>

                            <table>
                                <caption>ViewModel Local In memory representation</caption>
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Name</th>
                                        <th>Age</th>
                                        <th>Status</th>
                                        <th>isEditing</th>
                                    </tr>
                                </thead>
                                <tbody data-bind='template: { name: "viewRowTemplate", foreach: people }'></tbody>                               
                            </table>
 
                           
                        </form>
                        <script type="text/html" id="viewRowTemplate">
                            <tr>
                                <td><span class="readonly" data-bind="text:id"></span></td>
                                <td><span class="readonly" data-bind="text:name"></span></td>
                                <td><span class="readonly" data-bind="text:age"></span></td>
                                <td><span data-bind="text: status"/></td>                   
                                <td><span data-bind="text: isEditing"/></td>
                            </tr>
                        </script>
 
                        <script type="text/html" id="personRowTemplate">
                            <tr>
                                <td>
                                    <input class="required number" data-bind="visible:isEditing(),value: id, uniqueName: true"/>
                                    <span class="readonly" data-bind="visible:isEditing()==false,text:id"></span>
                                </td>
                                <td>
                                    <input class="required" data-bind="visible:isEditing(),value: name, uniqueName: true"/>
                                    <span class="readonly" data-bind="visible:isEditing()==false,text:name"></span>
                                </td>
                                <td>
                                    <input class="required number" data-bind="visible:isEditing(),value: age, uniqueName: true"/>
                                    <span class="readonly" data-bind="visible:isEditing()==false,text:age"></span>
                                </td>
                                <td><span data-bind="text: status"/></td>
                                <td>
                                    <ul class="nobullet">
                                        <li data-bind="visible:isEditing() == false">
                                            <a href="#" data-bind="click: function() { viewModel.editPerson($data) }">
                                                Edit
                                             </a>
                                        </li>                                        
                                        <li data-bind="visible:isEditing() == false">
                                            <a href="#" data-bind="click: function() { viewModel.removePerson($data) }">
                                                Delete
                                            </a>
                                        </li>
                                        <li data-bind="visible:isEditing()">
                                            <a href="#" data-bind="click: function() { viewModel.savePerson($data) }">
                                                Save
                                            </a>
                                        </li>
                                        <li data-bind="visible:isEditing()">
                                            <a href="#" data-bind="click: function() { viewModel.cancelEditPerson($data) }">
                                                Cancel
                                            </a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                        </script>
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
    <script src="/script/jquery.tmpl.js" type="text/javascript"></script>
    <script src="/script/knockout-1.2.1.js" type="text/javascript"></script>
    <script src="LocalStorage.js" type="text/javascript"></script>
<script src='http://www.google-analytics.com/ga.js' type='text/javascript'></script>
<script type="text/javascript">
    try {
        var pageTracker = _gat._getTracker("UA-15440154-1");
        pageTracker._trackPageview();
    } catch (err) { }

</script>
</body>
</html>
