using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using S22.Imap;
using System.Net.Mail;
using System.IO;
using System.Web.UI;
using System.Text;
using MailKit;
using MimeKit;
using MimeKit.Text;
using MimeKit.Tnef;

namespace FacturacionIndividual.App_Data.Code
{

    public class MailTask
    {

        MailMessage mail;
        SmtpClient smtp;

        public string from { get { return _from; } set { _from = value; } }
        public string to { get { return _to; } set { _to = value; } }
        public string body { get { return _body; } set { _body = value; } }
        public string subject { get { return _subject; } set { _subject = value; } }

        private string _from, _to, _body, _subject;
        private object uuid;

        ~MailTask()
        {
            try
            {
                smtp.Dispose();
            }
            catch (Exception) { }
        }

        public MailTask(string smtpServer, string login, string pass, string port, string ssl)
        {
            _from = _to = _body = _subject = "";
            smtp = new SmtpClient(smtpServer);
            smtp.Port = Convert.ToInt32(port);
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.DeliveryFormat = SmtpDeliveryFormat.International;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(login, pass);
            smtp.EnableSsl = (ssl.ToUpper().Equals("FALSE")) ? false : true;
            uuid = System.Guid.NewGuid();
        }

        public MailMessage getMail()
        {
            return this.mail;
        }

        public void NewMail()
        {
            this.mail = new MailMessage();
            this.mail.Priority = MailPriority.Normal;
            this.mail.IsBodyHtml = true;
        }

        public void SetDisposeSmtp()
        {
            smtp.Dispose();
        }


        public void setFrom(string name, string mail)
        {
            this.mail.From = new MailAddress(mail, name);
        }

        public void setBody(string body)
        {
            this.body = body;
        }

        public void addTo(string to)
        {
            mail.To.Add(new MailAddress(to));
        }

        public void addBcc(string bcc)
        {
            mail.Bcc.Add(new MailAddress(bcc));
        }

        public void addCC(string cc)
        {
            mail.CC.Add(new MailAddress(cc));
        }

        public void attach(string filePath)
        {
            try
            {
                Attachment attachment = new Attachment(filePath);
                mail.Attachments.Add(attachment);
                //attachment.Dispose(); //disposing the Attachment object

            }
            catch (Exception) { }
        }

        public void desattach()
        {
            try
            {
                foreach (Attachment attachment in mail.Attachments)
                {
                    attachment.Dispose();
                }
            }
            catch (Exception) { }
        }


        public bool post()
        {
            string err = "";
            mail.Subject = subject.Equals("") ? "FE Notification" : subject;
            mail.Body = body;
            try
            {
                smtp.Send(mail);
            }
            catch (SmtpException ex)
            {
                err = ex.Message;
            }
            desattach();
            mail.Dispose();

            if (err != "")
            {
                throw (new Exception(err));
            }

            return true;
        }

    }

}
