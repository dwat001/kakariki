
var sof = (function($) {
  Array.prototype.map = function(fn) {
    if(!fn) return null;
    var r = [];
    for(var prop in this)
    {        
        var item = fn(this[prop]);
        if(item)
            r.push(item);
    }
    return r; 
  };


    var sof = {
        
        data: [],
        pageSize: 35,
        currentPageNumber: -1,
        currentPage:null,
        url: "/blogs/SOFRep/SOFPagedUserSummary.aspx",
        getPageAndPositionFromRanking: function(ranking) {
            var pos = ranking % this.pageSize;
            var pg = Math.floor(ranking / this.pageSize);
            return { "position": pos, "page": pg, "rank": ranking };
        },
        getDataAsList: function() {
            var mappedData = this.data.map(function(obj){
                if(obj)
                    return  [obj.Rank, obj.Reputation];
                else    
                    return null;
            });
            
            return mappedData.sort(function(a,b){
                return a[0] - b[0];
                });
        },
        onDataChanged: function(){;},
        getPage: function(pageNumber){
            var currentSof = this;
            $.get(this.url, {page:pageNumber},function(newDataStr){
                currentSof.currentPageNumber = pageNumber;
                var newData = currentSof.currentPage = eval(newDataStr);
                var currData= currentSof.data;
                var len = newData.length;
                for(var prop in newData){
                    var item = newData[prop];
                    if(item && item.Rank){
                        currData[item.Rank] = item;
                    }
                }
                currentSof.onDataChanged(currentSof);
                                
            }
             );
        },
    };
    return sof;

}
)(jQuery);
