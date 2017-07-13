/* Including images from 2011 + zoom working*/
var map;
var infoWindow;
var monitoringSites;
var flickrApiKey = "be89187acf4ec53720aeb23305808ab5";
var flickrSizeSmall = "_s";
var flickrSizeBig = "";
var flickrRequestsSent = 0;
var flickrRequestsRecived = 0;

function createFlickrUrl(info, size) {
    return "https://farm" + info.farmId +
                          ".static.flickr.com/" + info.serverId +
                          "/" + info.photoId + "_" +
                          info.secret + size +".jpg";
}

function hideZoomImageNow() {
    $("#floating-image")
        .css("z-index", 0)
        .css("display", "none");
}

function initialize() {
    var mapDiv = document.getElementById('map-canvas');
    map = new google.maps.Map(mapDiv, {
       center: new  google.maps.LatLng(-36.812, 174.945),
       zoom: 15,
       mapTypeId: google.maps.MapTypeId.SATELLITE
    });
    infoWindow = new google.maps.InfoWindow({'content':'Does Not Display'});
    $("#floating-image").mouseleave( function(evt){
        $(evt.target)
            .stop()
            .animate({
                    width:75,
                    height:75,
                }, {
                    duration :100,
                    complete : hideZoomImageNow
               });
    });
}

function photoHover() {
    var smallUrl = $("img",this).attr("src");
    var url = smallUrl.replace("_s.jpg",".jpg");
    var offset = $(this).offset();
    $("#floating-image")
        .stop()
        .attr('src', smallUrl) // Ensure correct image while loading.
        .attr('src', url)
        .height(0)
        .width(0)
        .css("display", "inline")
        .offset(offset)
        .height(75)
        .width(75)
        .css("z-index", 500)
        
        .animate({
            width:500,
            height:325
            },250);
}

    function monitoringSite(number, latitude, longitude, flickrPhotoIds) {
        this.number = number;
        this.latitude = latitude;
        this.longitude = longitude;
        this.flickrPhotoIds = flickrPhotoIds;
        this.flickrInfo = new Array();
        this.flickrDeferreds = new Array();
        this.__marker = new google.maps.Marker({
            'position': new  google.maps.LatLng(latitude, longitude),
            'title': 'Monitoring Site' + number});
        
        this.showMarker = function() {
            this.__marker.setMap(map);
        };
        
        this.hideMarker = function() {
            this.__marker.setMap(null);
        }
        
        this.getInfoWindowContent = function() {
            var ret =
                '<div id="monitor-site-info">' +
                 '<p>' +
                  'Site ' + this.number +'.' +
                 '</p>' +
                 this._getAllPhotoContent() +
                '</div>';
            return ret;
        }
            
        this._getAllPhotoContent = function() {
            var str = '<div class="photos">';
            var self = this;
            $.each(this.flickrInfo,
                function(index, info){
                    str += self._getSinglePhotoContent(info);
                });
            str += '</div>';
            return str;   
        }
            
        this._getSinglePhotoContent = function(info) {
           if(!('url' in info)) debugger;
           var str =
            '<div class="photo">' +
                '<a href="' + info.url + '" target="_blank">' +
                  '<img class="thumbnail" src="' + info.thumbNail +'"/>' +
                  '<img class="flickrpreload" src="' + info.largePic +'"/>' +
                 '</a>'+
                 '<time datetime="' + info.date + '">' + info.date.substring(0,7) + '</time>' +
            '</div>';
            return str;
        }
            
        var self = this;
        
        this.whenFlickrInfoLoaded = function (func) {
            $.when(
                this.flickrDeferreds[0],
                this.flickrDeferreds[1],
                this.flickrDeferreds[2],
                this.flickrDeferreds[3],
                this.flickrDeferreds[4],
                this.flickrDeferreds[5]).then(func);
        }
        
        this.fetchFlickrInfo = function() {
            $.each(this.flickrPhotoIds, function(index, photoId) {
                if(!photoId) {
                    return;
                }
                self.flickrDeferreds.push(
                    $.getJSON("https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=" + flickrApiKey +
                          "&photo_id=" + photoId +
                          "&format=json&jsoncallback=?",
                  function(data){
                      if(!data.photo) {
                      	  console.error(index + ' ' + photoId);
                      	  console.error(data);
                          a.Error();
                      }
                      var info = {
                          "farmId" : data.photo.farm,
                          "serverId" : data.photo.server,
                          "photoId" : data.photo.id,
                          "secret" : data.photo.secret,
                          "url" : data.photo.urls.url[0]._content,
                          "date" : data.photo.dates.taken,
                          };
                      info.thumbNail = createFlickrUrl(info, flickrSizeSmall);
                      info.largePic = createFlickrUrl(info, flickrSizeBig);
                      //self.flickrInfo.push(info);
                      self.flickrInfo[index] = info;
                      flickrRequestsRecived++;
                  }));
            });
        }
        
        this.showInfoWindow = function() {
            infoWindow.close();
            var content = this.getInfoWindowContent();
            infoWindow.setContent(content);
            infoWindow.open(map,this.__marker);
            infoWindow.setContent(content);
            $('div.photo').hover(photoHover,
                function() {
                    
                }
            );
        }
            
        google.maps.event.addListener(this.__marker, 'click', function() {
          self.showInfoWindow();
        });
    }
    

function clearMonitoringSites() {
    for(index in monitoringSites) {
        monitoringSites[index].hideMarker();
    }
    monitoringSites.length = 0;
}

function showAllMonitoringSites() {
    for(index in monitoringSites) {
        var site = monitoringSites[index]
        site.showMarker();
    }    
}

function createMonitoringSites() {
    if(monitoringSites != null) {
        clearMonitoringSites();
    }
    monitoringSites = [
        new monitoringSite(01, -36.80495673, 174.94021432, ['515713027', '6414811147', '8377983028', '16016007707', '35071425226']),
        new monitoringSite(02, -36.80635174, 174.94254733, ['515714369', '6414817033', '8376906637', '16016001427', '34301225263']),
        new monitoringSite(03, -36.80749804, 174.94355147, ['515716203', '6414822701', '8377981602', '16014463980', '34980621271']),
        new monitoringSite(04, -36.80910591, 174.94278507, ['515719321', '6414928179', '8377965536', '15579392944', '34980593741']),
        new monitoringSite(05, -36.80824576, 174.94577856, ['515696346', '6414828041', '8377966466', '16175749636', '35071457586']),
        new monitoringSite(06, -36.81001435, 174.94510594, ['515697958', '6414866905', '8377966090', '15579148074', '34980658871']),
        new monitoringSite(07, -36.81186051, 174.94409896, ['515699458', '6414934633', '8377968306', '16200944442', '34724681430']),
        new monitoringSite(08, -36.81346032, 174.94382555, ['515700676', '6414873219', '8376899073', '16200950692', '35111413555']),
        new monitoringSite(09, -36.81587975, 174.94248548, ['372644079', '6414971643', '8377975604', '15581951713', '35111431615']),
        new monitoringSite(10, -36.81651514, 174.94166077, ['515702492', '6414979251', '8377976136', '15579371904', '34724736330']),
        new monitoringSite(11, -36.81883859, 174.94067690, ['515704042', '6414985793', '8376901205', '15581966423', '35071158846']),
        new monitoringSite(12, -36.82009842, 174.94024907, ['372588529', '6414992187', '8377970334', '16015983797', '34946243122']),
        new monitoringSite(13, -36.80832637, 174.94801120, ['515731469', '6414833753', '8377967022', '16015499159', '34266363514']),
        new monitoringSite(14, -36.81021319, 174.94727437, ['515707286', '6414861493', '8376904985', '16201565145', '34266343134']),
        new monitoringSite(15, -36.81161552, 174.94640193, ['372627774', '6414921851', '8376892989', '16201611105', '34300452513']),
        new monitoringSite(16, -36.81350694, 174.94593418, ['372630930', '6414940717', '8377968944', '16014134508', '34980171821']),
        new monitoringSite(17, -36.81494637, 174.94444606, ['372632084', '6414967227', '8377974950', '15581807243', '34266741644']),
        new monitoringSite(18, -36.81696154, 174.94412711, ['372635444', '6415032443', '8376894047', '16201635165', '34724212460']),
        new monitoringSite(19, -36.81862714, 174.94313788, ['515736093', '6415010361', '8376894433', '16175787766', '35110955345']),
        new monitoringSite(20, -36.82037788, 174.94245345, ['372589741', '6415004263', '8377977148', '15581830573', '35110988975']),
        new monitoringSite(21, -36.82205800, 174.94167752, ['372590926', '6414998247', '8377970754', '15581836983', '34266958644']),
        new monitoringSite(22, -36.80737300, 174.95133400, ['515711748', '6414841915', '16175733796', '34979846761']),
        new monitoringSite(23, -36.80875849, 174.95024156, ['515715066', '6414837957', '8376891659', '15579171024', '34945825522']),
        new monitoringSite(24, -36.81054144, 174.94924433, ['515717752', '6414856057', '8377980972', '15581750573', '34300786123']),
        new monitoringSite(25, -36.81225691, 174.94851437, ['6414917091', '8376902129', '15581888103', '34300754193']),
        new monitoringSite(26, -36.81441035, 174.94800847, ['515719426', '6414945647', '8377973582', '16015600009', '35071398696']),
        new monitoringSite(27, -36.81581673, 174.94743878, ['515746371', '6414961483', '8376897827', '16175834536', '34301108743']),
        new monitoringSite(28, -36.81747167, 174.94600094, ['515723292', '6415025829', '8376896511', '15581856173', '34267071944']),
        new monitoringSite(29, -36.81917646, 174.94537148, ['515751731', '6415015759', '8377971628', '16014184878', '35111157655']),
        new monitoringSite(30, -36.82094798, 174.94451946, ['372592157', '6415020007', '8376895543', '16199786801', '34980362391']),
        new monitoringSite(31, -36.80950664, 174.95188588, ['515729614', '6414847115', '8376892251', '16175721816', '35110594725']),
        new monitoringSite(32, -36.81066078, 174.95130988, ['515730998', '6414851363', '8377980122', '16201752505', '34300577983']),
        new monitoringSite(33, -36.81264121, 174.95091178, ['515757115', '6414910607', '8376902533', '16015621189', '34724058170']),
        new monitoringSite(34, -36.81437397, 174.95022712, ['515758501', '6414949779', '8377974068', '15581880863', '34980556631']),
        new monitoringSite(35, -36.81637829, 174.94892155, ['515761925', '6414955723', '8377972450', '16015588779', '35111254465']),
        new monitoringSite(36, -36.81020492, 174.95436966, ['515708151', '6414879179', '8376904181', '16199871411', '34723926060']),
        new monitoringSite(37, -36.81194855, 174.95357328, ['515708703', '6414906261', '8376902799', '15581900993', '34300684293']),
        new monitoringSite(38, -36.81040433, 174.95649330, ['372638751', '515709633', '6414883283', '8377979348', '16175885346', '34979970641']),
        new monitoringSite(39, -36.81180983, 174.95597981, ['372641856', '515710477', '6414900611', '8377978636', '16015916757', '34723997390']),
        new monitoringSite(40, -36.81156808, 174.95861910, ['372642926', '515685452', '6414888615', '8377979072', '16014250698', '35070800126']),
        ];
        $.each(monitoringSites,function(index, site) {
            site.fetchFlickrInfo();
        });
}
        
function showMonitoringSite(number){
    monitoringSites[number -1].showInfoWindow();
}

function showDataSite(anchor) {
    var trElement = $(anchor).parent().parent()[0];
    showMonitoringSite(parseInt($(trElement).data('site')));
    $("div#map-canvas").scrollTo();
}

function populatePhotoCell(cell, loggedSites) {
    var siteNumber = parseInt($(cell.parent()).data('site'));
    var year = cell.data('year');
    var site = monitoringSites[siteNumber -1];
    site.whenFlickrInfoLoaded( function () {
        if(console) {
            if(!loggedSites[siteNumber]) {
                //console.info(site); good spot for debugging or generating hardcoded image urls
                loggedSites[siteNumber] = true;
            }
        }
        for(var i=0; i < site.flickrInfo.length; i++) {
            var flickr = site.flickrInfo[i];
            // Skip over photos taken other years.
            if (flickr.date.indexOf(year + "") != 0) {
                continue;
            }
            cell.append(site._getSinglePhotoContent(flickr));
        }
        cell.find('div.photo').hover(photoHover,function() {});
    });
}

function populatePhotoTable() {
    var loggedSites = [];
    $("table.site-listing td.photoHolder").each( function () {
        populatePhotoCell($(this), loggedSites);
    });
}
    
    
(function($) {
    $.fn.scrollTo = function() {
        $('html, body').animate({
            scrollTop: $(this).offset().top + 'px'
        }, 'fast');
        return this; // for chaining...
    }
})(jQuery);

        
$(function () {
    initialize();
    createMonitoringSites();
    showAllMonitoringSites();
    populatePhotoTable();
    var site = monitoringSites[17 -1];
    site.whenFlickrInfoLoaded( function () {
        showMonitoringSite(17);
    });
});
