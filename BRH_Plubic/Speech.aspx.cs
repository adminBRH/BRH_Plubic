using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Speech.Synthesis;

namespace BRH_Plubic
{
    public partial class Speech : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btVoice_Click(object sender, EventArgs e)
        {
            // creating the object of SpeechSynthesizer class  
            SpeechSynthesizer sp = new SpeechSynthesizer();
            //setting volume   
            sp.Volume = 50;
            //ing text box text to SpeakAsync method   
            
            sp.Speak(txtMsg.Text);
        }
    }
}