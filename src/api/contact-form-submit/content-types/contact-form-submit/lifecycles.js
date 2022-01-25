const adminMail = process.env.ADMINEMAIL;
const myEmail = process.env.MYEMAIL;
module.exports = {
  afterCreate(event) {
    strapi.service("api::contact-form-submit.sendgrid").sendEmail({
      to: event.result.email,
      from: adminMail,
      subject: "Thanks for contacting us.",
      template: "contact_user",
      templateVars: {
        name: event.result.name,
      },
    });

    strapi.service("api::contact-form-submit.sendgrid").sendEmail({
      to: myEmail,
      from: adminMail,
      subject: `${event.result.name},New contact form submission`,
      template: "contact_admin",
      templateVars: {
        data: event.result,
      },
    });
  },
};
