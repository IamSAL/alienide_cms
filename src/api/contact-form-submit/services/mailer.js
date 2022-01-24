const nodemailer = require("nodemailer");
const fs = require("fs");
const ejs = require("ejs");
const { htmlToText } = require("html-to-text");
const juice = require("juice");
const { createCoreService } = require("@strapi/strapi").factories;
const userEmail = process.env.MYEMAIL;
const userPass = process.env.MYPASS;
const smtp = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true, // use SSL,
  // service: "Gmail",
  auth: {
    user: userEmail,
    pass: userPass,
  },
});

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

      return smtp.sendMail(options);
    },
  })
);
