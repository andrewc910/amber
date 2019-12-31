class ApplicationModel < Jennifer::Model::Base
  with_timestamps
  with_timestamps
  mapping(
    id: {type: Int32, primary: true},
    created_at: {type: Time, null: true},
    updated_at: {type: Time, null: true}
  )
end
