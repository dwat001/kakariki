using System;
using System.Collections.Generic;
using System.Web;
using System.Net;
using HtmlAgilityPack;
using System.Text.RegularExpressions;

namespace Kakariki.Blog.SOFRep
{
    public class UserSummary
    {
        private int rank;
        private int reputation;
        private String name;



        public int Rank
        {
            get { return rank; }
            set { this.rank = value; }
        }


        public int Reputation { get { return reputation; } set { this.reputation = value; } }
        public String Name { get { return name; } set { this.name = value; } }
    }

    public class SOFNetPageFetcher
    {
        private const string UserPage = "http://stackoverflow.com/users?page={0}";
        private const int UsersPerPage = 35;
        private static readonly Regex RepFinder = new Regex("reputation score ([0-9]+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        internal IList<UserSummary> getPage(int pageNumber)
        {
            IList<UserSummary> summaries = new List<UserSummary>();
            HtmlWeb hw = new HtmlWeb();
            HtmlDocument doc = hw.Load(String.Format(UserPage, pageNumber), "GET");
            int rank = ((pageNumber - 1) * 35);

            foreach (HtmlNode userInfo in doc.DocumentNode.SelectNodes("//div[@class='user-info']"))
            {
                rank++;
                HtmlNode repSpan = userInfo.SelectSingleNode(".//span[@class='reputation-score']");
                String repTitle = repSpan.GetAttributeValue("title", "");
                Match m = RepFinder.Match(repTitle);
                int rep;
                String repString;
                if (m.Success == false)
                {
                    repString = repSpan.InnerText.Replace(",", "");
                }
                else
                {
                    repString = m.Groups[1].Value;
                }

                if (!int.TryParse(repString, out rep))
                {
                    continue;
                }

                HtmlNode nameAnchor = userInfo.SelectSingleNode(".//div[@class='user-details']/a");
                String name = nameAnchor.InnerText;

                UserSummary user = new UserSummary();
                user.Name = name;
                user.Rank = rank;
                user.Reputation = rep;

                summaries.Add(user);
            }

            return summaries;
        }
    }
}
