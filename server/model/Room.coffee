class Room extends Paginate
    Schema = {
      email: {type:  String, unique: true},
      name: {type:  String},
      quantity: {type: Number},
      created_at: {type: Date, default: Date.now}
    }

room = new Room()



exports.Room = Room