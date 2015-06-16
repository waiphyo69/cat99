

bob = Cat.create!( name: 'Bob' , color: 'white', sex: 'M', birth_date: 'Sat, 12 May 2007', description: 'fat')
sally = Cat.create!( name: 'Sally' , color: 'black', sex: 'F', birth_date: 'Sat, 11 May 2007', description: 'really fat')

# t.integer  "cat_id",                         null: false
# t.date     "start_date",                     null: false
# t.date     "end_date",                       null: false
# t.string   "status",     default: "pending", null: false
# t.datetime "created_at"
# t.datetime "updated_at"
# end

bobrequest1 = CatRentalRequest.create!(cat_id: bob.id, start_date: 'Sat, 12 May 2008', end_date: 'Sat, 12 May 2010', status: "approved")
bobrequest2 = CatRentalRequest.create!(cat_id: 1, start_date: 'Sat, 12 May 2011', end_date: 'Sat, 12 May 2012', status: "approved")
