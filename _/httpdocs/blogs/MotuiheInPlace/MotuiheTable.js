(function() {

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
			sitesTemp[siteKey].photos.sort(function(a,b){
				if(a.date > b.date) {
					return 1;
				} else if (a.date < b.date) {
					return -1;
				} else {
					return 0;
				}
			});
		}

		return sitesTemp;
	}

	var createPhotoRow = function(photoIndex, sites) {
		var photoFound = false;
		var tr = document.createElement("tr");
		for(var siteIndex = 1; siteIndex < 41; siteIndex++) {
			var td = null;
			var photoInfo = sites[siteIndex].photos[photoIndex];
			if(photoInfo) {
				photoFound = true;
				td = createPhotoTd(photoInfo);
			} else {
				td = document.createElement("td");
			}
			tr.appendChild(td);
		}
		if(photoFound) {
			return tr;
		} else {
			return null;
		}
	}

	var createPhotoTable = function(sites) {
		var table = document.createElement("table");

		var workDone = true;
		for(var photoIndex=0; workDone; photoIndex++) {
			var tr = createPhotoRow(photoIndex, sites);
			workDone = tr != null;
			if(tr) {
				table.appendChild(tr);
			}
		}
		return table;
	}

	var createPhotoTd = function(photoInfo) {
		var td = document.createElement("td");
		td.classList.add("image-cell");
		var image = document.createElement("img");
		image.src = photoInfo.largePic;

		var dateSpan = document.createElement("div");
		var date = document.createTextNode("Site " + photoInfo.siteNumber + " - " + photoInfo.date.substr(0, 7));
		dateSpan.appendChild(date);

		td.appendChild(dateSpan);
		td.appendChild(image);

		return td;
	}


	var populatedSites = populateSites();
	var content = document.getElementById("content");
	content.appendChild(createPhotoTable(populatedSites));
	
})();