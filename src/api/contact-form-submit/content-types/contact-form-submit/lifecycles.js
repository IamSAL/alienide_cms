const adminMail = process.env.ADMINEMAIL;

module.exports = {
  afterCreate(event) {
    strapi.service("api::contact-form-submit.mailer").sendEmail({
      to: event.result.email,
      from: "Alienide Interactive",
      subject: "Thanks for contacting us.",
      template: "contact_user",
      templateVars: {
        name: event.result.name,
      },
    });

    strapi.service("api::contact-form-submit.mailer").sendEmail({
      to: adminMail,
      from: "Alienide Interactive",
      subject: `${event.result.name},New contact form submission`,
      template: "contact_admin",
      templateVars: {
        data: event.result,
      },
    });
  },
};
