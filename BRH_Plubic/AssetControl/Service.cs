using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.Text;
using System.IO;

namespace BRH_Plubic.AssetControl
{
    public class AssetControlService
    {
        public string Sticker(string status)
        {
            string result = "";

            int stickerPackageID = 0;
            int stickerID = 0;

            if (status == "Notify")
            {
                stickerPackageID = 6370;
                stickerID = 11088029;
            }
            else if (status == "Acknowledge")
            {
                stickerPackageID = 11538;
                stickerID = 51626520;
            }
            else if (status == "Repaired")
            {
                stickerPackageID = 6136;
                stickerID = 10551398;
            }
            else if (status == "Finish")
            {
                stickerPackageID = 11537;
                stickerID = 52002734;
            }
            else
            {
                stickerPackageID = 0;
                stickerID = 0;
            }

            if (stickerPackageID > 0 && stickerID > 0)
            {
                var stickerPackageId = string.Format("stickerPackageId={0}", stickerPackageID);
                var stickerId = string.Format("stickerId={0}", stickerID);
                result = "&" + stickerPackageId.ToString() + "&" + stickerId.ToString();
            }

            return result;
        }

        public Boolean Linenotify(string sendTo, string message, string status, string pictureUrl)
        {
            Boolean bl = false;
            try
            {
                string token = "zAnirYUlJsqdbI9ISjXe7wPP0xbje3pAufQKXjs4UQ0";
                if (sendTo == "Clinic")
                {
                    token = "KvQLv7ml6usGawbF7ljp5GxZDyxo2LbGzdaVL09E8h6";
                }

                message = System.Web.HttpUtility.UrlEncode(message, Encoding.UTF8);
                var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
                var postData = string.Format("message={0}", message);
                postData += Sticker(status);
                if (pictureUrl != "")
                {
                    var imageThumbnail = string.Format("imageThumbnail={0}", pictureUrl);
                    var imageFullsize = string.Format("imageFullsize={0}", pictureUrl);
                    postData += "&" + imageThumbnail.ToString() + "&" + imageFullsize.ToString();
                }
                var data = Encoding.UTF8.GetBytes(postData);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = data.Length;
                request.Headers.Add("Authorization", "Bearer " + token);
                var stream = request.GetRequestStream();
                stream.Write(data, 0, data.Length);
                var response = (HttpWebResponse)request.GetResponse();
                var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

                bl = true;
            }
            catch (Exception ex)
            {
                bl = false;
            }

            return bl;
        }
    }
}