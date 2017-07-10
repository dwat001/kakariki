using System;
using System.Collections.Generic;
using System.Web;
using System.Text;

namespace Kakariki.Blog.SOFRep
{
    public class SOFPagedUserSummary : IHttpHandler
    {

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            int page;
            if (int.TryParse(context.Request["page"], out page) == false)
            {
                page = 1;
            }
            if (page < 1) page = 1;
            String format = context.Request["format"];

            // Don't trust the data coming in only allow two values HTML or JSON, default to JSON
            format = format ?? "JSON";
            switch (format.ToUpper())
            {
                case "HTML":
                    format = "HTML";
                    break;
                case "":
                case "JSON":
                default:
                    format = "JSON";
                    break;
            }

            SOFPageFetcher fetcher = new SOFPageFetcher();
            fetcher.write(format, page, context);
        }
    }
}
