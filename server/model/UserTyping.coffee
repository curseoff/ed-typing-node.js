UserTypingSchema = new Schema({
    user_id: {type:  String},
    word: {type: String},
    quantity: {type: Number, default: 0},
    created_at: {type: Date, default: Date.now}
});

UserTyping = mongoose.model('UserTyping', UserTypingSchema);
exports.UserTyping = UserTyping