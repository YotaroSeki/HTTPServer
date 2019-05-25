require "./spec_helper"

def event_hash
  {"deadline" => "2019-06-11T14:00:00+09:00", "title" => "Fake", "memo" => "Fake"}
end

def event_params
  params = [] of String
  params << "deadline=#{event_hash["deadline"]}"
  params << "title=#{event_hash["title"]}"
  params << "memo=#{event_hash["memo"]}"
  params.join("&")
end

def create_event
  model = Event.new()
  model.title = event_hash["title"]
  model.memo = event_hash["memo"]
  model.deadline = Time.parse_local(event_hash["deadline"].not_nil!, "%F")
  model.save
  model
end

class EventControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :api do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
    end
    @handler.prepare_pipelines
  end
end

describe EventControllerTest do
  subject = EventControllerTest.new

  it "renders event index json" do
    Event.clear
    model = create_event
    response = subject.get "/api/v1/event"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders event show json" do
    Event.clear
    model = create_event
    location = "/api/v1/event/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a event" do
    Event.clear
    response = subject.post "/api/v1/event/", body: event_params

    response.status_code.should eq(200)
    response.body.should contain "\"status\":\"success\",\"message\":\"registered\",\"id\":"
  end

  it "updates a event" do
    Event.clear
    model = create_event
    response = subject.patch "/api/v1/event/#{model.id}", body: event_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a event" do
    Event.clear
    model = create_event
    response = subject.delete "/api/v1/event/#{model.id}"

    response.status_code.should eq(204)
  end
end