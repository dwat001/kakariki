"use strict";

(function() {

	var years = [
		{label:"2006/2007", years:["2006","2007"]},
		{label:"2011", years:["2011"]},
		{label:"2012", years:["2012"]},
		{label:"2014", years:["2014"]},
		{label:"2017", years:["2017"]},
		{label:"2019", years:["2019"]},
	];

	var compareSite = function(a, b) {
		if(a.date > b.date) {
			return 1;
		} else if (a.date < b.date) {
			return -1;
		} else {
			return 0;
		}
	};

	var populateSites = function() {
		var sitesTemp = {};
		for (var photoId in flickrData) {
			var photoInfo = flickrData[photoId];
			if(!sitesTemp[photoInfo.siteNumber]) {
				sitesTemp[photoInfo.siteNumber] = {photos : []};
			}
			sitesTemp[photoInfo.siteNumber].photos.push(photoInfo);
		}
		for (var siteKey in sitesTemp) {
			sitesTemp[siteKey].photos.sort(compareSite);
		}

		return sitesTemp;
	};

	var getPhotoForYear = function (year, photos) {
		for(var index=0; index<photos.length; index++) {
			if(year.years.includes(photos[index].date.substr(0, 4))){
				return photos[index];
			}
		}
		return null;
	}

	var createPhotoYearRow = function(year, sites) {
		var tr = document.createElement("tr");

		var yearHeader = document.createElement("th");
		yearHeader.appendChild(document.createTextNode(year.label));

		tr.appendChild(yearHeader);

		for(var siteIndex = 1; siteIndex < 41; siteIndex++) {
			var td = null;
			var photoInfo = getPhotoForYear(year, sites[siteIndex].photos)
			if(photoInfo) {
				td = createPhotoTd(photoInfo);
			} else {
				td = document.createElement("td");
			}
			tr.appendChild(td);
		}
		return tr;
	}

	var createPhotoTable = function(sites) {
		var table = document.createElement("table");
		var header = document.createElement("tr");

		var th = document.createElement("th");
		th.appendChild(document.createTextNode("Site/Year"));
		header.appendChild(th);
		
		for(var siteIndex = 1; siteIndex < 41; siteIndex++) {
			var siteHeader = document.createElement("th");
			siteHeader.appendChild(document.createTextNode("Site " + siteIndex));
			header.appendChild(siteHeader);
		}
		table.appendChild(header);

		years.forEach(function(year, index) {
			table.appendChild(createPhotoYearRow(year, sites));
		});

		return table;
	}

	var createPhotoTd = function(photoInfo) {
		var td = document.createElement("td");
		td.classList.add("image-cell");
		var image = document.createElement("img");
		image.src = photoInfo.largePic;

		var dateSpan = document.createElement("div");
		var date = document.createTextNode("Site " + photoInfo.siteNumber + " - " + photoInfo.date.substr(0, 7) + " - ");
		var download = document.createElement("a");
		download.href = photoInfo.originalPic;
		download.target = "_blank";
		//download.download = "Motuihe_Site_" + photoInfo.siteNumber + "_" + photoInfo.date.substr(0, 7)
		download.appendChild(
			document.createTextNode("download")
			);

		dateSpan.appendChild(date);
		dateSpan.appendChild(download);

		td.appendChild(dateSpan);
		td.appendChild(image);

		return td;
	}


	var populatedSites = populateSites();
	var content = document.getElementById("content");
	content.appendChild(createPhotoTable(populatedSites));
	
})();