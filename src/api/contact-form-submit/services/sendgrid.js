const nodemailer = require("nodemailer");
const fs = require("fs");
const ejs = require("ejs");
const { htmlToText } = require("html-to-text");
const juice = require("juice");
const { createCoreService } = require("@strapi/strapi").factories;
const sgMail = require("@sendgrid/mail");

sgMail.setApiKey(process.env.SENDGRID_API_KEY);
// const msg = {
//   to: "test@example.com",
//   from: "test@example.com", // Use the email address or domain you verified above
//   subject: "Sending with Twilio SendGrid is Fun",
//   text: "and easy to do anywhere, even with Node.js",
//   html: "<strong>and easy to do anywhere, even with Node.js</strong>",
// };

module.exports = createCoreService(
  "api::contact-form-submit.contact-form-submit",
  ({ strapi }) => ({
    sendEmail({ template: templateName, templateVars, ...restOfOptions }) {
      const templatePath = `src/utils/email/templates/${templateName}.html`;
      const options = {
        ...restOfOptions,
      };

      if (templateName && fs.existsSync(templatePath)) {
        const template = fs.readFileSync(templatePath, "utf-8");
        const html = ejs.render(template, templateVars);
        const text = htmlToText(html);
        const htmlWithStylesInlined = juice(html);
        options.html = htmlWithStylesInlined;
        options.text = text;
      }

      return sgMail.send(options).then(
        () => {
          console.log(`Sent Email to:${options.to}`);
        },
        (error) => {
          console.error(error);

          if (error.response) {
            console.error(error.response.body);
          }
        }
      );
    },
  })
);
