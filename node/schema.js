var mongoose = require('mongoose'), Schema = mongoose.Schema;

var Message = new Schema({
    username: { type: String, required: true },
    type: { type: String, required: true },
    body_content: { type: String, required: true },
    timestamp: { type: String, required: true }
});

Message.methods.all = function (callback) {
  return this.db.model('Message').find({}, callback);
}

/**
 * Define model.
 */

mongoose.model('Message', Message);