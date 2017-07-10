using System;
using System.Collections.Generic;
using System.Web;
using System.IO;

namespace Kakariki.Blog.SOFRep
{
    public class SOFCachePageFetcher
    {
        private HttpContext context;
        public SOFCachePageFetcher(HttpContext context)
        {
            this.context = context;
        }

        private const string FileLocation = "~/App_Data/uk.co.kakariki.sfo.user.page.{0}.{1}.js";

        public bool hasCachedPage(int pageNumber, string format)
        {
            String filepath = getFilePath(pageNumber, format);
            return File.Exists(filepath);
        }

        private String getFilePath(int pageNumber, string format)
        {
            String filepath = context.Server.MapPath(String.Format(FileLocation, format, pageNumber));
            return filepath;
        }

        public void readFromCache(int pageNumber, string format, HttpResponse resp)
        {
            if (hasCachedPage(pageNumber, format) == false) throw new ApplicationException("readFromCached Called with no cachedPAge call hasCachedPage first");
            String filepath = context.Server.MapPath(String.Format(FileLocation, format, pageNumber));
            resp.WriteFile(filepath);
        }

        public void writeToCache(MemoryStream str, int pageNumber, string format)
        {
            String filepath = getFilePath(pageNumber, format);
            using (StreamWriter sw = File.CreateText(filepath))
            {
                str.WriteTo(sw.BaseStream);
            }
        }


    }
}
