EnglishSchema = new Schema({
    word: {type: String},
    sentence: {type: String},
    created_at: {type: Date, default: Date.now}
});

English = mongoose.model('English', EnglishSchema);
exports.English = English