class UserRoom extends Paginate
    Schema = {
      email: {type:  String, unique: true},
      name: {type:  String},
      quantity: {type: Number},
      created_at: {type: Date, default: Date.now}
    }

user_room = new UserRoom()


exports.UserRoom = UserRoom