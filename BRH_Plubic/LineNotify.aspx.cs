using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using System.Text;
using System.IO;

namespace BRH_Plubic
{
    public partial class LineNotify : System.Web.UI.Page
    {
        public void Page_Load(object sender, EventArgs e)
        {
			string token = ""; //i1KdLjvtcZptJeGKvkUTWWuasmzIUTf3Obw2a6vS7bN
			string msg = "TEST Line notify By BEER";

			try
			{
				var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
				var postData = string.Format("message={0}", msg);
				var data = Encoding.UTF8.GetBytes(postData);
				request.Method = "POST";
				request.ContentType = "application/x-www-form-urlencoded";
				request.ContentLength = data.Length;
				request.Headers.Add("Authorization", "Bearer " + token);

				using (var stream = request.GetRequestStream())
				{
					stream.Write(data, 0, data.Length);
				}

				var response = (HttpWebResponse)request.GetResponse();
				var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
			}
			catch (Exception ex)
			{
				lblText.Text = ex.ToString();
			}
		}
    }
}