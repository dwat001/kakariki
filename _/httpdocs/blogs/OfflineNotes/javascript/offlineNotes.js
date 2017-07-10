/*

TextArea = #currentdoc
UL Document List = #documentlist
text field for title = #title

localstorage 
	savedDocumentNames = ["Doc Name","Doc Name","Doc Name"]
	<DocumentName> = DocInfo
	currentVersion = "the document would go here"
	currentDocumentName = "string"
	
DocInfo
	createdDate
	lastEditDate
	content
	name

*/

$(function() {
	console.log("On Load");
	refreshDocumentList();
	initEditor();
	startAutoSaver();
	attachEvents();
	});

function attachEvents() {
	$("#clear").click(function(event) {
		localStorage.clear();
		refreshDocumentList();
		initEditor();
	});
	
	$("#new").click(function(event) {
		saveDocument();
		createNewDocument();
	});
	
	$("#save").click(function(event) {
		saveDocument();
	});
	
	$("#reload").click(function(event) {
		reloadContent();
	});
	
	$("#delete").click(function(event) {
		deleteCurrentDocument();
	});
	
	window.addEventListener("popstate", function(e) {
    	loadFromUrl();
	});
}

function loadFromUrl() {
	console.log("loadFromUrl - " + location.hash);
	var oldName = location.hash;
	if(oldName.length > 1) {
		oldName = oldName.substr(1); // remove the #
	}
	var nameArray = getSavedDocumentNames();
	var index = $.inArray(oldName, nameArray);
	if(index >= 0) {
		loadDocument(oldName);
	}
	refreshDocumentList();
}

function startAutoSaver() {
	setInterval(quickSave, 5000);
}

function initEditor() {
	console.log("initEditor");
	var docName = localStorage['currentDocumentName'];
	if(typeof(docName) == undefined || docName == null || docName == '' ) {
		createNewDocument();
		return;
	}
	
	var unsavedEdits = localStorage['currentVersion']
	loadDocument(docName);
	$('#currentdoc')[0].value = unsavedEdits;
	localStorage['currentVersion'] = unsavedEdits;
	
	return;
}

function deleteCurrentDocument() {
	var docToDelete = localStorage['currentDocumentName'];
	var nameArray = getSavedDocumentNames();
	var indexToDelete = $.inArray(docToDelete, nameArray);
	nameArray.splice(indexToDelete,1);
	localStorage['savedDocumentNames'] = JSON.stringify(nameArray);
	localStorage.removeItem(docToDelete);
	
	if(nameArray.length > 0 ) {
		loadDocument(nameArray[0]);
		refreshDocumentList();
	} else {
		createNewDocument();
	}
}

function createNewDocument() {
	console.log("createNewDocument");
	var d = new Date();
	var documentName = "New Document " + 
		(1900 + d.getYear()) + "-" + 
		padLeft(d.getMonth()) + "-" +
		padLeft(d.getDate()) + " " +  
		padLeft(d.getHours()) + ":" +
		padLeft(d.getMinutes()) + ":" +
		padLeft(d.getSeconds()); 
	appendDocumentName(documentName);
	var docInfo = {
		"createdDate" : new Date(), 
		"lastEditDate" : new Date(), 
		"content" : "", 
		"name" : documentName}
	localStorage[documentName] = JSON.stringify(docInfo);

	loadDocument(documentName);
	
	refreshDocumentList();
}

function getDocInfo(docName) {
	var docInfoRaw = localStorage[docName];
		//TODO validate return
	return JSON.parse(docInfoRaw);
}

function loadDocument(docName) {
	console.log("loadDocument");
	var docInfo = getDocInfo(docName);
	$('#currentdoc')[0].value = docInfo.content;
	$("#title")[0].value = docInfo.name;
	var title ="Offline Notes - " + docInfo.name;
	var newDoc
	document.title = title;
	localStorage['currentDocumentName'] = docInfo.name;
	localStorage['currentVersion'] = docInfo.content;
	var loc = window.location + "";
	var hashIndex = loc.indexOf('#');
	loc = loc.substring(0,hashIndex) + "#" + docInfo.name;
	console.log("new location = " +  loc);
	var data = null;
	var newDocument = true
	
	if(window.location + "" == loc) {
		newDocument = false;
		console.log("newDocument = false;");
	}
	
	if(newDocument) {
		history.pushState(data, title, loc + "");
	}
}

function appendDocumentName(name) {
	console.log("appendDocumentName");
	var names = getSavedDocumentNames();
	names.push(name);
	localStorage['savedDocumentNames'] = JSON.stringify(names);
}

//Will return string[]
function getSavedDocumentNames() {
	console.log("getSavedDocumentNames");
	var nameListRaw = localStorage['savedDocumentNames'];
	if(typeof(nameListRaw) == undefined || nameListRaw == null || nameListRaw == '' ) {
		return new Array();
	}
	return JSON.parse(nameListRaw);
}

function refreshDocumentList(){
	console.log("refreshDocumentList");
	var list = $('#documentlist');
	list.html("");
	
	var nameList = getSavedDocumentNames();
	var currentDocumentName = localStorage['currentDocumentName'];
	
	var index;
	for(index in nameList) {
		if(nameList[index] == currentDocumentName) {
			var className = ' class="selected"';
		} else {
			var className = '';
		}
		list.append("<li" + className + "><a href='#'>" + nameList[index] +"</a></li>");
	}
	$('#documentlist li').click(function(event){
		var target = event.currentTarget;
		var docName = target.textContent;
		saveDocument();
		loadDocument(docName);
		refreshDocumentList();
		event.preventDefault();
	});
}

function renameIfRequired() {
	console.log('renameIfRequired');
	var newName = $.trim($('#title')[0].value);
	var oldName = localStorage['currentDocumentName'];
	if(newName == oldName) {
		console.log('No Rename Required');
		return;
	}
	var nameList = getSavedDocumentNames();
	var nameLocation = $.inArray(oldName, nameList)
	nameList[nameLocation] = newName;
	
	var docInfo = getDocInfo(oldName);
	docInfo.name = newName;
	
	localStorage.removeItem(oldName);
	localStorage[newName] = JSON.stringify(docInfo);
	localStorage['currentDocumentName'] = newName;
	localStorage['savedDocumentNames'] = JSON.stringify(nameList);
}

function saveDocument() {
	console.log('saveDocument');
	renameIfRequired();
	var content = $('#currentdoc')[0].value;
	var documentName = localStorage['currentDocumentName'];
	var docInfo = getDocInfo(documentName);
	docInfo.content = content;
	docInfo.lastEditDate = new Date();
	localStorage[documentName] = JSON.stringify(docInfo);
	localStorage['currentVersion'] = content;
	refreshDocumentList();
}

function quickSave() {
	console.log('quickSave');
	var content = $('#currentdoc')[0].value;
	localStorage['currentVersion'] = content;
}

function reloadContent() {
	console.log('reloadContent');
	loadDocument(localStorage['currentDocumentName']);
}

function padLeft(number) {
	if(number < 10) 
		return '0' + number;
	return '' + number;
}
