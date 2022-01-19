const sanitizeArticleData = (article, fields) => {
  const { id, firstname, lastname } = article.createdBy || {};
  article.author = id && { id, name: firstname + " " + lastname };
  delete article.updatedBy;
  delete article.createdBy;
  fields &&
    fields.forEach((field) => {
      delete article[field];
    });

  return article;
};

module.exports = { sanitizeArticleData };
