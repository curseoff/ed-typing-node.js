UserSchema = new Schema({
    email: {type:  String, unique: true},
    name: {type:  String},
    quantity: {type: Number},
    created_at: {type: Date, default: Date.now}
});

User = mongoose.model('User', UserSchema);
###
User.users = (events)=>
  User.find({}, (err, records)=>
     events.emit('receiveRecords', 'users', records)
  )
###
exports.User = User