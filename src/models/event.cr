class Event < Granite::Base
  adapter pg
  table_name events

  primary id : Int64
  field deadline : Time
  field title : String
  field memo : String
  timestamps
end
