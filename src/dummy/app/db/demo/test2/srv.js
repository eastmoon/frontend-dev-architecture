module.exports = (req, res, db) => {
    console.log("Call service");
    if (db !== null) {
      res.jsonp(db);
    } else {
      res.jsonp({});
    }
    return true;
}
